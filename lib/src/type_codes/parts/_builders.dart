//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

part of '../type_codes.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String? _buildObjectMapper(
  String type,
  String fieldName,
  TTypeMappers mappers,
) {
  final event = ObjectMapperEvent()
    .._type = type
    .._name = fieldName;
  return _buildMapper(event, mappers);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String _buildCollectionMapper(
  Iterable<List<String>> typeData,
  TTypeMappers mappingFormulas,
) {
  var output = "#x0";
  // Loop through type data elements.
  for (final element in typeData) {
    final collectionEvent = CollectionMapperEvent().._ltypes = element.skip(2);
    final pLength = collectionEvent._ltypes.length;
    collectionEvent
      .._lhashes = Iterable.generate(pLength, (n) => n).map((n) => "#p$n")
      .._lparams = Iterable.generate(pLength, (n) => n).map((n) => "p$n")
      .._largs = Iterable.generate(pLength, (n) => n).map((n) => "final p$n")
      .._type = element[1];
    final argIdMatch = RegExp(r"#x(\d+)").firstMatch(output);
    collectionEvent._nameIndex = argIdMatch != null && argIdMatch.groupCount > 0 //
        ? int.tryParse(argIdMatch.group(1)!)
        : null;
    final xHash = "#x${collectionEvent._nameIndex}";
    final formula = _buildMapper(collectionEvent, mappingFormulas);
    if (formula != null) {
      output = output.replaceFirst(xHash, formula);
    } else {
      assert(false, "Collection type-mapper not found!");
    }
    // Loop through object types.
    for (var n = 0; n < pLength; n++) {
      final objectEvent = ObjectMapperEvent()
        .._nameIndex = n
        .._type = collectionEvent._ltypes.elementAt(n);
      final pHash = "#p$n";

      // If the object type is the next type data element.
      if (objectEvent.type?[0] == "*") {
        final xHash = "#x$n";
        output = output.replaceFirst(pHash, xHash);
      }
      // If the object type is something else like num, int, double, bool or
      // String.
      else {
        final formula = _buildMapper(objectEvent, mappingFormulas);
        if (formula != null) {
          output = output.replaceFirst(pHash, formula);
        } else {
          assert(false, "Object type-mapper not found!");
        }
      }
    }
  }
  return output;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String? _buildMapper(
  MapperEvent event,
  TTypeMappers mappers,
) {
  final type = event.type;
  if (type != null) {
    // Get all mappers that match the type.
    final results = filterMappersByType(
      mappers,
      type,
    );
    assert(results.length == 1);
    // If there are any matches, take the first one.
    if (results.isNotEmpty) {
      final result = results.entries.first;
      final typePattern = result.key;
      final match = RegExp(typePattern).firstMatch(type);
      if (match != null) {
        event._matchGroups = Iterable.generate(match.groupCount + 1, (i) => match.group(i)!);
        final eventMapper = result.value;
        return eventMapper(event);
      }
    }
  }
  return null;
}

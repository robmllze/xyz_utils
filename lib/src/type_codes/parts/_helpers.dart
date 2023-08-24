// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Gen
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

part of '../type_codes.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Decomposes a complex [typeCode] into its constituent parts in
/// preparation for being processed by the builder.
///
/// i.e. This function transforms collection type codes like `List<String>` into
/// their components. Nested type codes are split into separate parts, and each
/// part is represented as a list of strings. This structure makes it easier to
/// process nested and composite types.
///
/// Examples:
/// - `"List"` results in `()`
/// - `"List<dynamic>"` results in `([List<dynamic>, List, dynamic])`
/// - `"List<List<String>>"` results in `([List<************>, List, ************], [List<String>, List, String])`
/// ... and so forth for nested types.
///
/// Notice the following:
///
/// - Asterisks in the results act as placeholders for type components that
/// have already been broken down.
/// - "List" results in `()` because it is seen as an object type (i.e. not a
/// collection) This is because it does not have a `<...>` component.
Iterable<List<String>> decomposeCollectionTypeCode(String typeCode) {
  final mapping = <int, List<String>>{};

  String? decompose(String input) {
    // Find all collection type expressions from the input.
    const A = r"[\w\*\|\?]+";
    const B = r"\b(" "$A" r")\<((" "$A" r")(\," "$A" r")*)\>(\?)?";
    final matches = RegExp(B).allMatches(input);

    // Map each map to its primary type and its subtypes.
    final mappingEntries = matches.map((e) {
      final longType = e.group(0)!; // e.g. "List<String,int>"
      final shortType = e.group(1)!; // // e.g. "List"
      final subtypes = e.group(2)!.split(","); // e.g. ["String", "int"] in "List<String,int>"
      final nullableSymbol = e.group(5) ?? ""; // "?" or ""
      final index = e.start; // index in [input] where the match starts
      return MapEntry(
        index,
        [
          longType,
          "$shortType$nullableSymbol",
          ...subtypes,
        ],
      );
    });

    // Add the mapping entries to final mapping.
    mapping.addEntries(mappingEntries);

    // Replace processed parts with placeholders.
    for (final e in mappingEntries) {
      final first = e.value.first;
      input = input.replaceFirst(first, "*" * first.length);
    }
    return mappingEntries.isNotEmpty ? input : null;
  }

  // Decompose the typeCode until complete.
  {
    // [decompose] doesn't take spaces into account.
    String? decomposed = typeCode.replaceAll(" ", "");
    do {
      decomposed = decompose(decomposed!);
    } while (decomposed != null);
  }

  // Sort the entries and extract values for return
  final sortedMapping = mapping.entries.toList()
    ..sort((a, b) {
      final aIndex = a.key;
      final bIndex = b.key;
      return aIndex.compareTo(bIndex);
    });
  final values = sortedMapping.map((e) => e.value);
  return values;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

TTypeMappers filterMappersByType(
  TTypeMappers mappers,
  String type,
) {
  return Map.fromEntries(
    mappers.entries.where((e) {
      final key = e.key;
      return RegExp(key).hasMatch(type);
    }),
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Expands non-generic Dart collection types (like "Map") to their generic forms
/// (e.g. Map<dynamic, dynamic>).
///
/// Handles cases followed by "|" and ignores already typed collections.
String toGenericTypeCode(String typeCode) {
  const TRANSFORMATIONS = {
    "Map": "Map<dynamic, dynamic>",
    "List": "List<dynamic>",
    "Set": "Set<dynamic>",
    "Iterable": "Iterable<dynamic>"
  };
  for (final key in TRANSFORMATIONS.keys) {
    // This regex looks for the key (like "Map") that is not immediately
    // followed by a "<", but it will also match if the key is followed by "|"
    // and any text.
    final regex = RegExp(r"\b" + key + r"\b(?![<|])");
    typeCode = typeCode.replaceAll(regex, TRANSFORMATIONS[key]!);
  }
  return typeCode;
}

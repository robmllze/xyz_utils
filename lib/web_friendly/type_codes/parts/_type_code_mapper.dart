//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

part of '../type_codes.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class TypeCodeMapper {
  //
  //
  //

  final TTypeMappers mappers;

  //
  //
  //

  const TypeCodeMapper(this.mappers);

  //
  //
  //

  String map({required String fieldName, required String typeCode}) {
    final genericTypeCode = toGenericTypeCode(typeCode);
    var result = this.mapCollection(
      fieldName: fieldName,
      genericTypeCode: genericTypeCode,
    );
    if (result == "#x0") {
      result = this.mapObject(
        fieldName: fieldName,
        typeCode: genericTypeCode,
      );
    }
    return result;
  }

//
//
//

  String mapObject({
    required String fieldName,
    required String typeCode,
  }) {
    final formula = _buildObjectMapper(typeCode, fieldName, this.mappers) ?? "#x0";
    return formula;
  }

//
//
//

  String mapCollection({
    required String fieldName,
    required String genericTypeCode,
  }) {
    // Break the typeCode up into to a list of type data that can be processed
    // by the builder.
    final typeData = decomposeCollectionTypeCode(genericTypeCode);
    // Use the typeData to build a mapping formula.
    var formula = _buildCollectionMapper(typeData, this.mappers);
    // Insert the field name into the formula.
    formula = formula.replaceFirst("p0", fieldName);
    return formula;
  }
}

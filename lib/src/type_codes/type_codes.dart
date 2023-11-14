//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'loose_type_mappers.dart';

part 'parts/_builders.dart';
part 'parts/_helpers.dart';
part 'parts/_mapper_event.dart';
part 'parts/_type_code_mapper.dart';
part 'parts/_type_code.dart';
part 'parts/_type_mappers.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String mapWithLooseToMappers({required String fieldName, required String typeCode}) {
  final mappers = LooseTypeMappers.instance.toMappers;
  return TypeCodeMapper(mappers).map(
    fieldName: fieldName,
    typeCode: typeCode,
  );
}

String mapWithLooseFromMappers({required String fieldName, required String typeCode}) {
  final mappers = LooseTypeMappers.instance.fromMappers;
  return TypeCodeMapper(mappers).map(
    fieldName: fieldName,
    typeCode: typeCode,
  );
}

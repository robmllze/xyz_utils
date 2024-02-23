//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'extensions/string_extensions.dart';
import 'type_message_mixin.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum StringCaseType implements TypeMessageMixin {
  //
  //
  //

  LOWER_SNAKE_CASE(_LOWER_SNAKE_CASE),
  UPPER_SNAKE_CASE(_UPPER_SNAKE_CASE),
  LOWER_KEBAB_CASE(_LOWER_KEBAB_CASE),
  UPPER_KEBAB_CASE(_UPPER_KEBAB_CASE),
  CAMEL_CASE(_CAMEL_CASE),
  PASCAL_CASE(_PASCAL_CASE),
  LOWER_DOT_CASE(_LOWER_DOT_CASE),
  UPPER_DOT_CASE(_UPPER_DOT_CASE),
  PATH_CASE(_PATH_CASE);

  //
  //
  //

  @override
  final String $message;

  @override
  String get message => this.$message;

  //
  //
  //

  const StringCaseType(this.$message);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const CAMEL_CASE = "camelCase";
const LOWER_DOT_CASE = "lower.dot.case";
const LOWER_KEBAB_CASE = "lower-kebab-case";
const LOWER_SNAKE_CASE = "lower_snake_case";
const PASCAL_CASE = "PascalCase";
const PATH_CASE = "path/case";
const UPPER_DOT_CASE = "UPPER.DOT.CASE";
const UPPER_KEBAB_CASE = "UPPER-KEBAB-CASE";
const UPPER_SNAKE_CASE = "UPPER_SNAKE_CASE";

const _CAMEL_CASE = CAMEL_CASE;
const _LOWER_DOT_CASE = LOWER_DOT_CASE;
const _LOWER_KEBAB_CASE = LOWER_KEBAB_CASE;
const _LOWER_SNAKE_CASE = LOWER_SNAKE_CASE;
const _PASCAL_CASE = PASCAL_CASE;
const _PATH_CASE = PATH_CASE;
const _UPPER_DOT_CASE = UPPER_DOT_CASE;
const _UPPER_KEBAB_CASE = UPPER_KEBAB_CASE;
const _UPPER_SNAKE_CASE = UPPER_SNAKE_CASE;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String convertToStringCaseType(
  String value,
  StringCaseType? stringCaseType,
) {
  switch (stringCaseType) {
    case StringCaseType.LOWER_SNAKE_CASE:
      return value.toLowerSnakeCase();
    case StringCaseType.UPPER_SNAKE_CASE:
      return value.toUpperSnakeCase();
    case StringCaseType.LOWER_KEBAB_CASE:
      return value.toLowerKebabCase();
    case StringCaseType.UPPER_KEBAB_CASE:
      return value.toUpperKebabCase();
    case StringCaseType.CAMEL_CASE:
      return value.toCamelCase();
    case StringCaseType.PASCAL_CASE:
      return value.toPascalCase();
    case StringCaseType.LOWER_DOT_CASE:
      return value.toLowerDotCase();
    case StringCaseType.UPPER_DOT_CASE:
      return value.toUpperDotCase();
    case StringCaseType.PATH_CASE:
      return value.toPathCase();
    default:
      return value;
  }
}

extension ConvertStringToStringCaseType on StringCaseType {
  String convertString(String value) {
    return convertToStringCaseType(value, this);
  }
}

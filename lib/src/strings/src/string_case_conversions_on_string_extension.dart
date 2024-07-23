//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension StringCaseConversionsOnStringExtension on String {
  /// Converts the string to UPPER_SNAKE_CASE;
  String toUpperSnakeCase() => this.toSnakeCase().toUpperCase();

  /// Converts the string to lower_snake_case (alias for [toSnakeCase]).
  String toLowerSnakeCase() => this.toSnakeCase();

  /// Converts the string to snake_case.
  String toSnakeCase() => this.extractLowercaseComponents().join('_');

  /// Converts the string to lower-kebab-case.
  String toUpperKebabCase() => this.toKebabCase().toUpperCase();

  /// Converts the string to lower-kebab-case (alias for [toKebabCase]).
  String toLowerKebabCase() => this.toKebabCase();

  /// Converts the string to kebab-case.
  String toKebabCase() => this.extractLowercaseComponents().join('-');

  /// Converts the string to dot.case.
  String toDotCase() => this.extractLowercaseComponents().join('.');

  /// Converts the string to lower.dot.case. (alias for [toDotCase]).
  String toLowerDotCase() => this.toDotCase();

  /// Converts the string to UPPER.DOT.CASE.
  String toUpperDotCase() => this.toDotCase().toUpperCase();

  /// Converts the string to path/case.
  String toPathCase([String separator = '/']) => this.extractLowercaseComponents().join(separator);

  /// Converts the string to camelCase.
  String toCamelCase() => this.toPascalCase().withFirstLetterAsLowerCase();

  /// Converts the string to PascalCase.
  String toPascalCase() => this.extractLowercaseComponents().map((e) => e.capitalize()).join();

  /// Extracts and returns a list of lowercase components from the string.
  ///
  /// This method identifies components based on transitions between lowercase
  /// and uppercase letters, between letters and digits, within sequences of
  /// uppercase letters (including [special] characters), and at any
  /// non-alphanumeric characters. Each identified component is converted to
  /// lowercase.
  ///
  /// The method is useful for parsing strings formatted in camelCase, PascalCase,
  /// snake_case, kebab-case, or other mixed-case styles into a list of lowercase words or segments.
  ///
  /// Example:
  /// ```dart
  /// var example = 'HelloWorld123.456';
  /// var components = example.extractLowercaseComponents(special = const {'.'});
  /// print(components); // Output: ['hello', 'world', '123+456']
  /// ```
  List<String> extractLowercaseComponents({
    Set<String> special = const {'.'},
  }) {
    if (this.isEmpty) return [this];
    final words = <String>[];
    var currentWord = StringBuffer();
    String? a;
    for (var n = 0; n < this.length; n++) {
      final b = this[n];
      final bIsLetter = b.isLetter || special.contains(b);
      if (bIsLetter || b.isDigit) {
        if (a != null) {
          final aIsLetter = a.isLetter || special.contains(a);
          if ((a.isLowerCase && b.isUpperCase) ||
              (a.isDigit && bIsLetter) ||
              (aIsLetter && b.isDigit) ||
              (a.isUpperCase &&
                  b.isUpperCase &&
                  (n + 1 < this.length && this[n + 1].isLowerCase))) {
            words.add(currentWord.toString().toLowerCase());
            currentWord = StringBuffer();
          }
        }
        currentWord.write(b);
      } else if (currentWord.isNotEmpty) {
        words.add(currentWord.toString().toLowerCase());
        currentWord = StringBuffer();
      }
      a = b;
    }
    if (currentWord.isNotEmpty) {
      words.add(currentWord.toString().toLowerCase());
    }
    return words;
  }

  /// Returns `true` if the string is a digit.
  bool get isDigit => RegExp(r'^[0-9]$').hasMatch(this);

  /// Returns `true` if the string is a letter.
  bool get isLetter => RegExp(r'^[a-zA-Z]$').hasMatch(this);

  /// Returns `true` if the string is all uppercase.
  bool get isUpperCase => this == this.toUpperCase() && this != this.toLowerCase();

  /// Returns `true` if the string is all lowercase.
  bool get isLowerCase => this == this.toLowerCase() && this != this.toUpperCase();

  /// Capitalizes the first letter of the string.
  ///
  /// The same as [withFirstLetterAsUpperCase].
  String capitalize() => this.withFirstLetterAsUpperCase();

  /// Converts the first letter of the string to uppercase.
  ///
  /// The same as [capitalize].
  String withFirstLetterAsUpperCase() {
    if (this.isEmpty) return this;
    if (this.length == 1) return this.toUpperCase();
    return this[0].toUpperCase() + this.substring(1);
  }

  /// Converts the first letter of the string to lowercase.
  String withFirstLetterAsLowerCase() {
    if (this.isEmpty) return this;
    if (this.length == 1) return this.toLowerCase();
    return this[0].toLowerCase() + this.substring(1);
  }

  /// Capitalizes each word in the string.
  String withCapitalizedWords() {
    return this
        .trim()
        .split(RegExp(r'[- ]+'))
        .map((e) => e.trim().toLowerCase().capitalize())
        .join(' ');
  }
}

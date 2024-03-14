//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// X|Y|Z & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension StringExtensions on String {
  /// Converts the string to UPPER_SNAKE_CASE;
  String toUpperSnakeCase() => this.toSnakeCase().toUpperCase();

  /// Converts the string to lower_snake_case (alias for [toSnakeCase]).
  String toLowerSnakeCase() => this.toSnakeCase();

  /// Converts the string to snake_case.
  String toSnakeCase() => this.extractLowercaseComponents().join("_");

  /// Converts the string to lower-kebab-case.
  String toUpperKebabCase() => this.toKebabCase().toUpperCase();

  /// Converts the string to lower-kebab-case (alias for [toKebabCase]).
  String toLowerKebabCase() => this.toKebabCase();

  /// Converts the string to kebab-case.
  String toKebabCase() => this.extractLowercaseComponents().join("-");

  /// Converts the string to dot.case.
  String toDotCase() => this.extractLowercaseComponents().join(".");

  /// Converts the string to lower.dot.case. (alias for [toDotCase]).
  String toLowerDotCase() => this.toDotCase();

  /// Converts the string to UPPER.DOT.CASE.
  String toUpperDotCase() => this.toDotCase().toUpperCase();

  /// Converts the string to path/case.
  String toPathCase([String separator = "/"]) =>
      this.extractLowercaseComponents().join(separator);

  /// Converts the string to camelCase.
  String toCamelCase() => this.toPascalCase().withFirstLetterAsLowerCase();

  /// Converts the string to PascalCase.
  String toPascalCase() =>
      this.extractLowercaseComponents().map((e) => e.capitalize()).join();

  /// Extracts and returns a list of lowercase components from the string.
  ///
  /// This method identifies components based on transitions between lowercase
  /// and uppercase letters, between letters and digits, within sequences of
  /// uppercase letters, and at any non-alphanumeric characters.
  /// Each identified component is converted to lowercase.
  ///
  /// The method is useful for parsing strings formatted in camelCase, PascalCase,
  /// snake_case, kebab-case, or other mixed-case styles into a list of lowercase words or segments.
  ///
  /// Example:
  /// ```dart
  /// var example = "HelloWorld123";
  /// var components = example.extractLowercaseComponents();
  /// print(components); // Output: ['hello', 'world', '123']
  /// ```
  List<String> extractLowercaseComponents() {
    if (this.isEmpty) return [this];
    final words = <String>[];
    var currentWord = StringBuffer();
    String? a;
    for (var n = 0; n < this.length; n++) {
      final b = this[n];
      if (b.isLetter || b.isDigit) {
        if (a != null &&
            ((a.isLowerCase && b.isUpperCase) ||
                (a.isDigit && b.isLetter) ||
                (a.isLetter && b.isDigit) ||
                (a.isUpperCase &&
                    b.isUpperCase &&
                    (n + 1 < this.length && this[n + 1].isLowerCase)))) {
          words.add(currentWord.toString().toLowerCase());
          currentWord = StringBuffer();
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
  bool get isDigit => RegExp(r"^[0-9]$").hasMatch(this);

  /// Returns `true` if the string is a letter.
  bool get isLetter => RegExp(r"^[a-zA-Z]$").hasMatch(this);

  /// Returns `true` if the string is all uppercase.
  bool get isUpperCase =>
      this == this.toUpperCase() && this != this.toLowerCase();

  /// Returns `true` if the string is all lowercase.
  bool get isLowerCase =>
      this == this.toLowerCase() && this != this.toUpperCase();

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
        .split(RegExp(r"[- ]+"))
        .map((e) => e.trim().toLowerCase().capitalize())
        .join(" ");
  }

  /// Truncates the string to the given [length] and adds "..." at the end.
  String truncToLength(int length) {
    return (this.length > length
        ? "${this.substring(0, length).trim()}..."
        : this);
  }

  /// Replaces all whitespace characters with a single space.
  String withNormalizedWhitespace() {
    return this.replaceAll(RegExp(r"[\s]+"), " ");
  }

  /// Converts the string to a [Uri] or returns `null` if the string is not a
  /// valid URI.
  Uri? toUriOrNull() => Uri.tryParse(this);

  /// Replaces the last occurrence of [from] with [to] starting at [startIndex].
  ///
  /// See: [replaceFirst].
  String replaceLast(Pattern from, String to, [int startIndex = 0]) {
    final match = from.allMatches(this, startIndex).lastOrNull;
    if (match == null) return this;
    final lastIndex = match.start;
    final beforeLast = this.substring(0, lastIndex);
    final group0 = match.group(0);
    if (group0 == null) return this;
    final afterLast = this.substring(lastIndex + group0.length);
    return beforeLast + to + afterLast;
  }
}

//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension MiscOnStringExtension on String {
  /// Truncates the string to the given [length] and adds '...' at the end.
  String truncToLength(int length) {
    return (this.length > length
        ? '${this.substring(0, length).trim()}...'
        : this);
  }

  /// Replaces all whitespace characters with a single space.
  String withNormalizedWhitespace() {
    return this.replaceAll(RegExp(r'[\s]+'), ' ');
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

  // Splits the string by the last occurrence of [separator].
  List<String> splitByLastOccurrenceOf(String separator) {
    final splitIndex = this.lastIndexOf(separator);
    if (splitIndex == -1) {
      return [this];
    }
    return [
      this.substring(0, splitIndex),
      this.substring(splitIndex + separator.length),
    ];
  }
}

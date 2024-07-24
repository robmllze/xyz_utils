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

/// Replaces placeholders in a string with corresponding values from a provided
/// map, supporting default values and custom delimiters.
String replacePatterns(
  String input,
  Map data, {
  ReplacePatternsSettings settings = const ReplacePatternsSettings(),
}) {
  var output = input;
  final regex = RegExp(
    '${RegExp.escape(settings.opening)}(.*?)${RegExp.escape(settings.closing)}',
  );
  final matches = regex.allMatches(input);
  for (final match in matches) {
    final fullMatch = match.group(0)!;
    final keyWithDefault = match.group(1)!;
    final parts = keyWithDefault.split(settings.delimiter);
    final e0 = parts.elementAtOrNull(0);
    final e1 = parts.elementAtOrNull(1);
    final key = (e1 ?? e0)!;
    final defaultValue = e0 ?? key;
    final data1 = settings.caseSensitive
        ? data
        : data.map((k, v) => MapEntry(k.toString().toLowerCase(), v));
    final key1 = settings.caseSensitive ? key : key.toLowerCase();
    final suggestedReplacementValue = data1[key1];
    final replacementValue =
        settings.callback?.call(key, suggestedReplacementValue, defaultValue) ??
            suggestedReplacementValue?.toString() ??
            defaultValue;
    output = output.replaceFirst(fullMatch, replacementValue);
  }

  return output;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ReplaceAllPatternsOnStringExtension on String {
  /// Replaces placeholders in this string with corresponding values from a
  /// provided map, supporting default values and custom delimiters.
  String replacePatterns(
    Map data, {
    ReplacePatternsSettings settings = const ReplacePatternsSettings(),
  }) {
    return _replacePatterns(
      this,
      data,
      settings: settings,
    ).toString();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const _replacePatterns = replacePatterns;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ReplacePatternsSettings {
  //
  //
  //

  final String opening;
  final String closing;
  final String separator;
  final String delimiter;
  final bool caseSensitive;
  final String? Function(
    String key,
    dynamic suggestedReplacementValue,
    String defaultValue,
  )? callback;

  //
  //
  //

  const ReplacePatternsSettings({
    this.opening = '<<<',
    this.closing = '>>>',
    this.separator = '.',
    this.delimiter = '||',
    this.caseSensitive = true,
    this.callback,
  });
}

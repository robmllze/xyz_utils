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

dynamic replaceAllPatterns(
  String input,
  Map<dynamic, dynamic> data, {
  String opening = "<<<",
  String closing = ">>>",
  String delimeter = "||",
  String? Function(
    String key,
    dynamic value,
    String? defaultValue,
  )? onReplace,
}) {
  final o1 = RegExp.escape(opening);
  final c1 = RegExp.escape(closing);
  var output = input;

  final regex = RegExp("$o1(.*?)$c1");
  final matches = regex.allMatches(input);

  for (final match in matches) {
    final fullMatch = match.group(0)!;
    final keyWithDefault = match.group(1)!;
    final parts = keyWithDefault.split(delimeter);
    final key = parts[0];
    final defaultValue = parts.length > 1 ? parts[1] : null;

    String? replacementValue;
    if (data.containsKey(key)) {
      replacementValue = data[key].toString();
    } else if (defaultValue != null) {
      replacementValue = defaultValue;
    }

    if (replacementValue != null) {
      final temp = onReplace?.call(key, replacementValue, defaultValue);
      if (temp != null) {
        replacementValue = temp;
      }
      output = output.replaceFirst(fullMatch, replacementValue);
    }
  }

  return output;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ReplaceAllPatternsOnStringExtension on String {
  String replaceAllPatterns(
    Map<String, dynamic> data, {
    String opening = "<<<",
    String closing = ">>>",
    String delimeter = "||",
    String? Function(
      String key,
      dynamic value,
      String? defaultValue,
    )? onReplace,
  }) {
    return _replaceAllPatterns(
      this,
      data,
      opening: opening,
      closing: closing,
      delimeter: delimeter,
      onReplace: onReplace,
    ).toString();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const _replaceAllPatterns = replaceAllPatterns;

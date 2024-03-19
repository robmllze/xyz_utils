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

import '/xyz_utils.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Replaces placeholders in a string with corresponding values from a provided
/// map, supporting default values and custom delimiters.
dynamic replacePatterns(
  String input,
  Map<dynamic, dynamic> data, {
  String opening = "<<<",
  String closing = ">>>",
  String delimiter = "||",
  bool caseSensitive = true,
  String? Function(
    String key,
    dynamic value,
    String defaultValue,
  )? callback,
}) {
  final o1 = RegExp.escape(opening);
  final c1 = RegExp.escape(closing);
  var output = input;
  final regex = RegExp("$o1(.*?)$c1");
  final matches = regex.allMatches(input);
  for (final match in matches) {
    final fullMatch = match.group(0)!;
    final keyWithDefault = match.group(1)!;
    final parts = keyWithDefault.split(delimiter);
    final e0 = parts.elementAtOrNull(0);
    final e1 = parts.elementAtOrNull(1);
    final key = (e1 ?? e0)!;
    final defaultValue = e0 ?? key;
    final value = (caseSensitive ? data : data.mapKeys((k) => k.toLowerCase()))[
        caseSensitive ? key : key.toLowerCase()];
    final replacementValue = value?.toString() ?? defaultValue;
    callback?.call(key, value, defaultValue);
    output = output.replaceFirst(fullMatch, replacementValue);
  }

  return output;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ReplaceAllPatternsOnStringExtension on String {
  /// Replaces placeholders in this string with corresponding values from a
  /// provided map, supporting default values and custom delimiters.
  String replacePatterns(
    Map<String, dynamic> data, {
    String opening = "<<<",
    String closing = ">>>",
    String delimiter = "||",
    bool caseSensitive = true,
    String? Function(
      String key,
      dynamic value,
      String defaultValue,
    )? callback,
  }) {
    return _replacePatterns(
      this,
      data,
      opening: opening,
      closing: closing,
      delimiter: delimiter,
      caseSensitive: caseSensitive,
      callback: callback,
    ).toString();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const _replacePatterns = replacePatterns;

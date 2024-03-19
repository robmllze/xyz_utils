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

import '/shared_src/web_friendly/_all_web_friendly.g.dart';
import '/src/web_friendly/_all_web_friendly.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Performs recursive replacement of string values within a map using
/// placeholders defined by the map's own key-value pairs. It supports nested
/// structures (maps and lists) and replaces placeholders in strings with
/// corresponding values.
Map recursiveReplace(
  Map input, {
  String opening = "<<<",
  String closing = ">>>",
  String separator = ".",
  String delimiter = "||",
  String? Function(
    String key,
    dynamic value,
    String defaultValue,
  )? callback,
}) {
  final data = expandFlattenedJson(
    flattenJson(input, separator: separator),
    separator: separator,
  );

  dynamic $replace<T>(dynamic inputKey, dynamic inputValue) {
    dynamic r;
    if (inputValue is Map) {
      r = {};
      for (final e in inputValue.entries) {
        final k = e.key;

        final v = e.value;
        final res = $replace(k, v);
        final localKey = "$separator$k";
        data[localKey] = res;
        r[k] = res;
      }
    } else if (inputValue is List) {
      r = <dynamic>[];
      for (var n = 0; n < inputValue.length; n++) {
        final k = "$inputKey$separator$n";
        final v = inputValue[n];
        final res = $replace(k, v);
        final localKey = "$separator$k";
        data[localKey] = res;
        r.add(res);
      }
    } else if (inputValue is String) {
      r = replaceAllPatterns(
        inputValue,
        data,
        opening: opening,
        closing: closing,
        delimiter: delimiter,
        callback: callback,
      );
    } else {
      r = inputValue;
    }
    return r;
  }

  final res = $replace("", input);
  return res;
}

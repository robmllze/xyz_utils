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

import '/shared_src/web_friendly/_all_web_friendly.g.dart';
import '/src/web_friendly/_all_web_friendly.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Performs recursive replacement of string values within a map using
/// placeholders defined by the map's own key-value pairs. It supports nested
/// structures (maps and lists) and replaces placeholders in strings with
/// corresponding values.
Map recursiveReplace(
  Map input, {
  ReplacePatternsSettings settings = const ReplacePatternsSettings(),
}) {
  final data = expandFlattenedJson(
    flattenJson(input, separator: settings.separator),
    separator: settings.separator,
  );

  dynamic $replace<T>(dynamic inputKey, dynamic inputValue) {
    dynamic r;
    if (inputValue is Map) {
      r = {};
      for (final e in inputValue.entries) {
        final k = e.key;

        final v = e.value;
        final res = $replace(k, v);
        final localKey = '$settings.separator$k';
        data[localKey] = res;
        r[k] = res;
      }
    } else if (inputValue is List) {
      r = <dynamic>[];
      for (var n = 0; n < inputValue.length; n++) {
        final k = '$inputKey$settings.separator$n';
        final v = inputValue[n];
        final res = $replace(k, v);
        final localKey = '$settings.separator$k';
        data[localKey] = res;
        r.add(res);
      }
    } else if (inputValue is String) {
      r = replacePatterns(
        inputValue,
        data,
        settings: settings,
      );
    } else {
      r = inputValue;
    }
    return r;
  }

  final res = $replace('', input);
  return res;
}

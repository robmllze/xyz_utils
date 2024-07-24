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

/// Expands a flattened JSON map, e.g. `{'a.b': 1}` to `{a.b: 1, b: 1}`.
Map expandFlattenedJson(
  Map input, {
  String separator = '.',
}) {
  final res = {...input};
  var modified = true;
  while (modified) {
    final currentRes = {...res};
    modified = false;
    for (final entry in currentRes.entries) {
      final key = entry.key;
      final value = entry.value;
      final parts = key.split(separator);
      if (parts.length > 1) {
        final modifiedKey = parts.sublist(1).join(separator);
        if (!res.containsKey(modifiedKey)) {
          res[modifiedKey] = value;
          modified = true;
        }
      }
    }
  }

  return res;
}

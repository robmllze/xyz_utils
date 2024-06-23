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

// ignore_for_file: prefer_single_quotes

/// Flattens a nested JSON object into a single-level map with string keys.
///
///
/// The function can handle nested structures containing other Maps and
/// Lists. In the case of Lists, the list indices are included in the
/// flattened keys.
///
/// ### Parameters:
///
/// - [input] The nested Map to be flattened. This map can contain other
///   maps, lists, and basic data types (e.g., String, int, bool).
/// - [separator] A string used to separate the segments of the path
///   in the keys of the resulting flat map. Defaults to `.`.
///
/// ### Returns:
///
/// A Map where each key is a path composed of the keys from the original
/// nested map (and indices for lists), separated by [separator], leading to
/// the corresponding value.
///
/// ### Example Usage:
/// ```dart
/// final nestedJson = {
///   'user': {
///     'name': 'Phillip Sherman',
///     'address': {
///       'street': '42 Wallaby Way',
///       'city': 'Sydney',
///       'zip': '2000'
///     }
///   },
///   'emails': [
///     'p.sherman@sydneydental.com.au',
///     'phillip.sherman@gmail.com'
///   ]
/// };
///
/// final flattened = flattenJson(nestedJson);
/// print(flattened);
/// // Output:
/// // {
/// //   'user.name': 'hillip Sherman',
/// //   'user.address.street': '42 Wallaby Way',
/// //   'user.address.city': 'Sydney',
/// //   'user.address.zip': '2000',
/// //   'emails.0': 'p.sherman@sydneydental.com.au',
/// //   'emails.1': 'phillip.sherman@gmail.com'
/// // }
/// ```
Map flattenJson(Map input, {String separator = '.'}) {
  Map $flattenJson(dynamic input, [String prefix = '']) {
    final result = {};
    void flatten(String path, dynamic value) {
      if (value is Map) {
        for (final entry in value.entries) {
          final k = entry.key;
          final v = entry.value;
          final newPath = path.isEmpty ? k.toString() : '$path$separator$k';
          flatten(newPath, v);
        }
      } else if (value is List) {
        for (var i = 0; i < value.length; i++) {
          flatten('$path$separator$i', value[i]);
        }
      } else {
        result[path] = value;
      }
    }

    flatten(prefix, input);
    return result;
  }

  return $flattenJson(input);
}

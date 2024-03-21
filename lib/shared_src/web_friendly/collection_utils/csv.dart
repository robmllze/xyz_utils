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

/// Converts a map to a CSV string.
String mapToCsv(Map input) {
  var output = '';
  for (final entry in input.entries) {
    final key = entry.key;
    dynamic value = entry.value;
    if (value is Map) {
      value = mapToCsv(value);
    } else if (value is List) {
      value = value.join(',');
    }
    output += '"$key","$value"\n';
  }
  return output;
}

/// Converts a CSV string to a map.
Map<int, List<String>> csvToMap(String input) {
  final processedInput =
      input.replaceAll(r'\,', '\u{F0001}').replaceAll(r'\"', '\u{F0002}');
  final lines = processedInput.split('\n');
  final res = <int, List<String>>{};
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    var parts = line
        .split(RegExp(r',(?=(?:[^"]*"[^"]*")*[^"]*$)'))
        .map((part) => part.trim())
        .toList();
    parts = parts.map((e) {
      return e.replaceAll('\u{F0001}', ',').replaceAll('\u{F0002}', r'\"');
    }).toList();

    res[i] = parts;
  }
  return res;
}

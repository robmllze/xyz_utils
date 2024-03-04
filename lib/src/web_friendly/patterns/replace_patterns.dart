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
  Map<dynamic, dynamic> data,
  String opening,
  String closing,
) {
  final o1 = RegExp.escape(opening);
  final c1 = RegExp.escape(closing);
  var output = input;
  for (final entry in data.entries) {
    final k = entry.key;
    final v = entry.value;
    final source = "$o1$k$c1";
    if (input == source) return v;
    final expression = RegExp(source, caseSensitive: false);
    output = output.replaceAll(expression, v.toString());
  }
  return output;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ReplacePatterns on String {
  String replacePatterns(
    Map<String, dynamic> data, [
    String opening = "{",
    String closing = "}",
  ]) {
    return replaceAllPatterns(this, data, opening, closing).toString();
  }
}

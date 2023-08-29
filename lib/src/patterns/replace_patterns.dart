// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

extension ReplacePatterns on String {
  String replacePatterns(
    Map<String, dynamic> data, [
    String opening = "(=",
    String closing = ")",
  ]) {
    return replaceAllPatterns(this, data, opening, closing).toString();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

dynamic replaceAllPatterns(
  String input,
  Map<dynamic, dynamic> data,
  String opening,
  String closing,
) {
  final o1 = RegExp.escape(opening);
  final c1 = RegExp.escape(closing);
  var copy = input;
  for (final entry in data.entries) {
    final k = entry.key;
    final v = entry.value;
    final source = "$o1$k$c1";
    if (input == source) return v;
    final expression = RegExp(source, caseSensitive: false);
    copy = copy.replaceAll(expression, v.toString());
  }
  return copy;
}

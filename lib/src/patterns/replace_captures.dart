// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

/// Usage example:
/// ```dart
/// void main() {
///  final result = replaceCaptures("Hello {{{World}}}", {r"\w+": "there {{1}}"});
///  print(result); // Prints: "Hello there World"
/// }
/// ```
String replaceCaptures(
  String input,
  Map<String, dynamic> data, {
  String patternOpening = "{{{",
  String patternClosing = "}}}",
  String captureOpening = "{{",
  String captureClosing = "}}",
}) {
  final o1 = RegExp.escape(patternOpening);
  final c1 = RegExp.escape(patternClosing);
  final o2 = RegExp.escape(captureOpening);
  final c2 = RegExp.escape(captureClosing);
  var output = input;
  for (final entry in data.entries) {
    final k = entry.key;
    final v = entry.value.toString();
    final from = RegExp("$o1($k)$c1", caseSensitive: false);
    output = output.replaceAllMapped(from, (match) {
      final groups = List<String?>.filled(match.groupCount + 1, null);
      for (var i = 0; i <= match.groupCount; i++) {
        groups[i] = match.group(i);
      }
      final from = RegExp("$o2(\\d+)$c2");
      return v.replaceAllMapped(from, (match) {
        final index = int.parse(match.group(1)!);
        return groups[index]!;
      });
    });
  }
  return output;
}

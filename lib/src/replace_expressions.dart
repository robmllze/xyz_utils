// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Gen
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

String replaceExpressions(String inputString, Map<String, String> expressions) {
  var outputString = inputString;
  for (final entry in expressions.entries) {
    final expression = RegExp(entry.key);
    final replacement = entry.value;
    outputString = outputString.replaceAllMapped(expression, (match) {
      final groups = List<String?>.filled(match.groupCount + 1, null);
      for (var i = 0; i <= match.groupCount; i++) {
        groups[i] = match.group(i);
      }
      return replacement.replaceAllMapped(RegExp(r"\{\{(\d+)\}\}"), (innerMatch) {
        var index = int.parse(innerMatch.group(1)!);
        return groups[index]!;
      });
    });
  }
  return outputString;
}

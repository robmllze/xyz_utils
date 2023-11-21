//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

String inlineReplaceAll(
  String input,
  Map<String, dynamic> replacements, {
  String opening = "",
  String closing = "",
}) {
  final result = StringBuffer();
  var index = 0;
  while (index < input.length) {
    var replaced = false;
    if (opening.isEmpty || input.startsWith(opening, index)) {
      var offset = opening.isEmpty ? 0 : opening.length;
      for (var key in replacements.keys) {
        if (input.startsWith(key, index + offset) &&
            (closing.isEmpty || input.startsWith(closing, index + offset + key.length))) {
          result.write(replacements[key]);
          index += offset + key.length + (closing.isEmpty ? 0 : closing.length);
          replaced = true;
          break;
        }
      }
    }
    if (!replaced) {
      result.write(input[index]);
      index++;
    }
  }

  return result.toString();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension InlineReplace on String {
  String inlineReplace(
    Map<String, dynamic> replacements, {
    String opening = "",
    String closing = "",
  }) {
    return inlineReplaceAll(
      this,
      replacements,
      opening: opening,
      closing: closing,
    );
  }
}

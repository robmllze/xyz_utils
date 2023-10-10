// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

String inlineReplaceAll(
  String input,
  Map<String, dynamic> replacements,
) {
  final result = StringBuffer();
  var currentPosition = 0;

  while (currentPosition < input.length) {
    var nextReplacementPosition = input.length;
    var nextReplacementKey = "";

    for (final key in replacements.keys) {
      final keyPosition = input.indexOf(key, currentPosition);
      if (keyPosition != -1 && keyPosition < nextReplacementPosition) {
        nextReplacementPosition = keyPosition;
        nextReplacementKey = key;
      }
    }

    if (nextReplacementPosition > currentPosition) {
      // Append the part of the input string before the next replacement.
      result.write(input.substring(currentPosition, nextReplacementPosition));
      currentPosition = nextReplacementPosition;
    }

    if (nextReplacementKey.isNotEmpty) {
      // Replace the key with its corresponding value.
      result.write(replacements[nextReplacementKey]);
      currentPosition += nextReplacementKey.length;
    } else {
      // No more replacements found, break the loop.
      break;
    }
  }

  // Append the remaining portion of the input string.
  if (currentPosition < input.length) {
    result.write(input.substring(currentPosition));
  }

  return result.toString();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension InlineReplace on String {
  String inlineReplace(Map<String, dynamic> replacements) {
    return inlineReplaceAll(this, replacements);
  }
}

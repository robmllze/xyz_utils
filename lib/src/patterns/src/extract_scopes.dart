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

// External.
import '/src/core/src/let.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Extracts nested scopes from a [source] string based on [opening] and
/// [closing] delimiters.
///
/// **Example:**
///
/// ```dart
/// final scopes = extractScopes('{hello{world}', '{', '}');
/// print(scopes); // Prints "([hello, [world]])"
/// ```
Iterable<String> extractScopes(
  String source,
  String opening,
  String closing,
) {
  var index = 0;
  dynamic $parse() {
    final result = <dynamic>[];
    while (index < source.length) {
      if (source.startsWith(opening, index)) {
        index += opening.length;
        result.add($parse());
      } else if (source.startsWith(closing, index)) {
        index += closing.length;
        return result.isNotEmpty ? result : result.first;
      } else {
        final nextOpen = source.indexOf(opening, index);
        final nextClose = source.indexOf(closing, index);
        var nextIndex = nextOpen;
        if (nextOpen == -1 || (nextClose != -1 && nextClose < nextOpen)) {
          nextIndex = nextClose;
        }
        if (nextIndex == -1) {
          result.add(source.substring(index).trim());
          break;
        } else {
          result.add(source.substring(index, nextIndex).trim());
          index = nextIndex;
        }
      }
    }
    return result.isNotEmpty ? result : null;
  }

  return letAsOrNull<List>($parse())?.map((e) => e?.toString()).nonNulls ?? [];
}

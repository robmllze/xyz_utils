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

import 'let.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Extracts nested scopes from a source string based on opening and closing\
/// delimiters.
Iterable<String> extractScopes(
  String source,
  String open,
  String close,
) {
  var index = 0;
  dynamic parse() {
    final result = <dynamic>[];
    while (index < source.length) {
      if (source.startsWith(open, index)) {
        index += open.length;
        result.add(parse());
      } else if (source.startsWith(close, index)) {
        index += close.length;
        return result.isNotEmpty ? result : result.first;
      } else {
        final nextOpen = source.indexOf(open, index);
        final nextClose = source.indexOf(close, index);
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

  return letAsOrNull<List>(parse())?.map((e) => e?.toString()).nonNulls ?? [];
}

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

import 'package:collection/collection.dart' show mergeMaps;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Merges two lists or sets into one list or set.
T mergeListsOrSets<T extends Iterable>(T a, dynamic b) {
  final aa = a is List
      ? List.of(a)
      : a is Set
          ? Set.of(a)
          : null;
  final bb = b is List
      ? List.of(b)
      : b is Set
          ? Set.of(b)
          : null;
  if (aa == null) {
    throw Error();
  }
  return bb == null ? ((aa as dynamic)..add(b)) : ((aa as dynamic)..addAll(bb));
}

/// Merges two iterables into one iterable.
Iterable mergeIterables(dynamic a, dynamic b) {
  final aa = a is Iterable ? a : [a];
  final bb = b is Iterable ? b : [b];
  return aa.followedBy(bb);
}

/// Merges two data structures deeply.
dynamic mergeDataDeep(
  dynamic a,
  dynamic b, [
  dynamic Function(dynamic)? elseFilter,
]) {
  if (a is Map && b is Map) {
    return mergeMaps(
      a,
      b,
      value: (final a, final b) {
        if (a is Map && b is Map) {
          return mergeDataDeep(a, b, elseFilter);
        }
        if (a is List || a is Set) {
          return mergeListsOrSets<Iterable>(a as Iterable, b);
        }
        if (a is Iterable) {
          return mergeIterables(a, b);
        }
        return elseFilter?.call(b) ?? b;
      },
    );
  }
  if (a is List || a is Set) {
    return mergeListsOrSets<Iterable>(a as Iterable, b);
  }
  if (a is Iterable) {
    return mergeIterables(a, b);
  }
  return elseFilter?.call(b) ?? b;
}

/// Merges two data structures deeply and tries to perform toJson on objects.
dynamic mergeDataDeepIncludeCallsToJson(dynamic a, dynamic b) {
  return mergeDataDeep(a, b, tryToJson);
}

/// Merges two data structures deeply and tries to perform toMap on objects.
dynamic mergeDataDeepIncludeCallsToMap(dynamic a, dynamic b) {
  return mergeDataDeep(a, b, tryToMap);
}

/// Tries to convert an object to a json map by calling its toJson method if it
/// exists.
dynamic tryToJson(dynamic object) {
  try {
    return object?.toJson();
  } catch (_) {
    return null;
  }
}

/// Tries to convert an object to a map by calling its toMap method if it exists.
dynamic tryToMap(dynamic object) {
  try {
    return object?.toMap();
  } catch (_) {
    return null;
  }
}

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

import 'dart:collection' show Queue;

import 'package:collection/collection.dart' show mergeMaps;


// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Merges two Iterables into one. Supported Iterable types are List, Set, and
/// Queue.
T mergeListsSetsOrQueues<T extends Iterable>(T a, Iterable b) {
  Iterable result;
  if (a is List) {
    result = List.of(a);
    var index = 0;
    for (var item in b) {
      if (result.length <= index || result.elementAt(index) != item) {
        (result as dynamic).add(item);
      }
      index++;
    }
  } else if (a is Set) {
    result = Set.of(a);
    (result as dynamic).addAll(b);
  } else if (a is Queue) {
    result = Queue.of(a);
    var index = 0;
    for (var item in b) {
      if (result.length <= index || result.elementAt(index) != item) {
        (result as dynamic).add(item);
      }
      index++;
    }
  } else {
    throw ArgumentError('Unsupported Iterable type');
  }

  return result as T;
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
      value: (a, b) {
        if (a is Map && b is Map) {
          return mergeDataDeep(a, b, elseFilter);
        }
        if (a is List || a is Set || a is Queue) {
          return mergeListsSetsOrQueues<Iterable>(a, b);
        }
        if (a is Iterable) {
          return mergeIterables(a, b);
        }
        return elseFilter?.call(b) ?? b;
      },
    );
  }
  if (a is List || a is Set || a is Queue) {
    return mergeListsSetsOrQueues<Iterable>(a, b);
  }
  if (a is Iterable) {
    return mergeIterables(a, b);
  }
  return elseFilter?.call(b) ?? b;
}

/// Merges all [maps] deeply.
Map<K, V> mergeMapsDeep<K, V>(List<Map<K, V>> maps) {
  var a = <K, V>{};
  for (final b in maps) {
    final temp = letMap<K, V>(mergeDataDeep(a, b));
    if (temp != null) {
      a = temp;
    }
  }
  return a;
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

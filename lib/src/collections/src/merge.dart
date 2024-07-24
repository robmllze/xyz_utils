//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:collection' show Queue;

import 'package:collection/collection.dart' show mergeMaps;

import '/src/core/src/let.dart';
import 'non_nulls_on_map_extension.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Merges two Iterables into one. Supported Iterable types are List, Set, and
/// Queue.
Iterable mergeListsSetsOrQueues(Iterable a, Iterable b) {
  final a1 = a.nonNulls;
  final b1 = b.nonNulls;
  Iterable result;
  if (a1 is List) {
    result = List.of(a1);
    var index = 0;
    for (var item in b1) {
      if (result.length <= index || result.elementAt(index) != item) {
        (result as dynamic).add(item);
      }
      index++;
    }
  } else if (a1 is Set) {
    result = Set.of(a1);
    (result as dynamic).addAll(b1);
  } else if (a1 is Queue) {
    result = Queue.of(a1);
    var index = 0;
    for (var item in b1) {
      if (result.length <= index || result.elementAt(index) != item) {
        (result as dynamic).add(item);
      }
      index++;
    }
  } else {
    throw ArgumentError('Unsupported Iterable type');
  }

  return result;
}

/// Merges two iterables into one iterable.
Iterable mergeIterables(dynamic a, dynamic b) {
  final aa = a is Iterable ? a.nonNulls : Iterable.generate(1, (_) => a);
  final bb = b is Iterable ? b.nonNulls : Iterable.generate(1, (_) => b);
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
          return mergeDataDeep(a.nonNulls, b.nonNulls, elseFilter);
        }
        if (a is List || a is Set || a is Queue) {
          return mergeListsSetsOrQueues(a, b);
        }
        if (a is Iterable) {
          return mergeIterables(a, b);
        }
        return elseFilter?.call(b) ?? b;
      },
    );
  }
  if (a is List || a is Set || a is Queue) {
    return mergeListsSetsOrQueues(a, b);
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

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart' show mergeMaps;
export 'dart:collection';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Map<T1, T2>? maybeAddToMap<T1, T2>(Map<T1, T2>? source, Map<T1, T2>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return {...source, ...add};
}

List<T>? maybeAddToList<T>(List<T>? source, List<T>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return [...source, ...add];
}

Set<T>? maybeAddToSet<T>(Set<T>? source, Set<T>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return {...source, ...add};
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

T mergeLists<T extends Iterable>(T a, dynamic b) {
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

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

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
          return mergeLists<Iterable>(a as Iterable, b);
        }
        return elseFilter?.call(b) ?? b;
      },
    );
  } // else
  if (a is List || a is Set) {
    return mergeLists<Iterable>(a as Iterable, b);
  } // else
  return elseFilter?.call(b) ?? b;
}

dynamic mergeDataDeepIncludeCalls_toJson(dynamic a, dynamic b) {
  return mergeDataDeep(a, b, tryCallingOnObject_toJson);
}

dynamic mergeDataDeepIncludeCalls_toMap(dynamic a, dynamic b) {
  return mergeDataDeep(a, b, tryCallingOnObject_toMap);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

dynamic tryCallingOnObject_toJson(dynamic object) {
  try {
    return object?.toJson();
  } catch (_) {
    return null;
  }
}

dynamic tryCallingOnObject_toMap(dynamic object) {
  try {
    return object?.toMap();
  } catch (_) {
    return null;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension MapNullKeysAndValuesRemoved<T1, T2> on Map<T1?, T2?> {
  Map<T1, T2> nullsRemoved() {
    return Map<T1, T2>.fromEntries(
      this
          .entries
          .where((final l) => l.key != null && l.value != null)
          .map((final l) => MapEntry(l.key as T1, l.value as T2)),
    );
  }
}

// extension MapNullKeysRemoved<T1, T2> on Map<T1?, T2> {
//   Map<T1, T2> nullsRemoved() {
//     return Map<T1, T2>.fromEntries(
//       this
//           .entries
//           .where((final l) => l.key != null)
//           .map((final l) => MapEntry(l.key as T1, l.value)),
//     );
//   }
// }

// extension MapNullValuesRemoved<T1, T2> on Map<T1, T2?> {
//   Map<T1, T2> nullsRemoved() {
//     return Map<T1, T2>.fromEntries(
//       this
//           .entries
//           .where((final l) => l.value != null)
//           .map((final l) => MapEntry(l.key, l.value as T2)),
//     );
//   }
// }

extension IterableNullsRemoved<T> on Iterable<T?> {
  Iterable<T> nullsRemoved() {
    return this.where((final l) => l != null).map((final l) => l!);
  }
}

extension ListNullsRemoved<T> on List<T?> {
  List<T> nullsRemoved() {
    return this.where((final l) => l != null).map((final l) => l!).toList();
  }
}

extension SetNullsRemoved<T> on Set<T?> {
  Set<T> nullsRemoved() {
    return this.where((final l) => l != null).map((final l) => l!).toSet();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension StringNullIfEmpty on String {
  String? nullIfEmpty() {
    return this.isEmpty ? null : this;
  }
}

extension MapNullIfEmpty<T1, T2> on Map<T1, T2> {
  Map<T1, T2>? nullIfEmpty() {
    return this.isEmpty ? null : this;
  }
}

extension IterableNullIfEmpty<T> on Iterable<T> {
  Iterable<T>? nullIfEmpty() {
    return this.isEmpty ? null : this;
  }
}

extension ListNullIfEmpty<T> on List<T> {
  List<T>? nullIfEmpty() {
    return this.isEmpty ? null : this;
  }
}

extension SetNullIfEmpty<T> on Set<T> {
  Set<T>? nullIfEmpty() {
    return this.isEmpty ? null : this;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Set<T> getSetDifference<T>(Set<T> before, Set<T> after) {
  final results = <T>{};
  for (final a in after) {
    if (!before.contains(a)) results.add(a);
  }
  return results;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef _VarArgsCallback<T> = T Function(List<dynamic>, Map<String, dynamic>);

class _VarArgsFunction<T> {
  //
  //
  //

  static const _OFFSET = 'Symbol("'.length;

  //
  //
  //

  final _VarArgsCallback<T> callback;

  //
  //
  //

  _VarArgsFunction(this.callback);

  //
  //
  //

  T call() => callback([], {});

  //
  //
  //

  @override
  T noSuchMethod(Invocation inv) {
    return callback(
      inv.positionalArguments,
      inv.namedArguments.map(
        (final key, final value) {
          final key_ = key.toString();
          return MapEntry(key_.substring(_OFFSET, key_.length - 2), value);
        },
      ),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// **Example:**
/// ```dart
/// final Iterable a = iterable(1, 2, 3, 4, /* etc. */);
/// print(a);
/// ```
/// **Output:**
/// ```bash
/// (1, 2, 3, 4)
/// ```
final dynamic iterable = _VarArgsFunction<Iterable>((final args1, final args2) {
  return args1.skip(0).followedBy(args2.values);
});

/// **Example:**
/// ```dart
/// final List a = list(1, 2, 3, 4, /* etc. */);
/// print(a);
/// ```
/// **Output:**
/// ```bash
/// [1, 2, 3, 4]
/// ```
final dynamic list = _VarArgsFunction<List>((final args1, final args2) {
  return List.from(args1.skip(0).followedBy(args2.values));
});

/// **Example:**
/// ```dart
/// final Set a = set(1, 2, 3, 4, /* etc. */);
/// print(a);
/// ```
/// **Output:**
/// ```bash
/// {1, 2, 3, 4}
/// ```
final dynamic set = _VarArgsFunction<Set>((final args1, final args2) {
  return Set.from(args1.skip(0).followedBy(args2.values));
});

/// **Example:**
/// ```dart
/// final Map a = map(1, 2, x: "x-axis", y: "y-axis", /* etc. */);
/// print(a);
/// ```
/// **Output:**
/// ```bash
/// {0: 1, 1: 2, x: x-axis, y: y-axis}
/// ```
final dynamic map = _VarArgsFunction<Map>((final args1, final args2) {
  var n = 0;
  final l1 = args1.map((final value) => MapEntry<dynamic, dynamic>(n++, value));
  final l2 = args2.entries;
  return Map.fromEntries(l1.followedBy(l2));
});

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef Json = Map<String, dynamic>;

Json mapToJson<T1, T2>(Map<T1, T2> input) => _mapToJson(input);

dynamic _mapToJson(dynamic input) {
  if (input is Map) {
    return input.map((final k, final v) => MapEntry(k.toString(), _mapToJson(v)));
  } else if (input is Iterable) {
    return input.map((final l) => _mapToJson(l)).toList();
  }
  if (input is num || input is bool || input is String) {
    return input;
  }
  if (input == null) {
    return "";
  }
  return input.toString();
}

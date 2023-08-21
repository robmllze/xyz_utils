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

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Iterable mergeIterables(dynamic a, dynamic b) {
  final aa = a is Iterable ? a : [a];
  final bb = b is Iterable ? b : [b];
  return aa.followedBy(bb);
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
        if (a is Map && b is Map) return mergeDataDeep(a, b, elseFilter);
        if (a is List || a is Set) return mergeListsOrSets<Iterable>(a as Iterable, b);
//         if (a is List) return mergeIterables(a, b).toList();
//         if (a is Set) return mergeIterables(a, b).toSet();
//         if (a is Iterable) return mergeIterables(a, b);
        return elseFilter?.call(b) ?? b;
      },
    );
  }
  if (a is List || a is Set) return mergeListsOrSets<Iterable>(a as Iterable, b);
//   if (a is List) return mergeIterables(a, b).toList();
//   if (a is Set) return mergeIterables(a, b).toSet();
//   if (a is Iterable) return mergeIterables(a, b);
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

extension TryFirstWhereIterable<T> on Iterable<T> {
  T? tryFirstWhere(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension TryFirstWhereList<T> on List<T> {
  T? tryFirstWhere(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension TryFirstWhereSet<T> on Set<T> {
  T? tryFirstWhere(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension IterableToMap<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() {
    return Map.fromEntries(this);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension IterableMapI<A> on Iterable<A> {
  Iterable<B> mapi<B, C>(B Function(A x, int index, C? option) mapper,
      {List<C> options = const []}) {
    var index = 0;
    return this.map((final x) {
      final option = options.length > index ? options[index] : null;
      return mapper(x, index++, option);
    });
  }
}

extension ListMapI<A> on List<A> {
  Iterable<B> mapi<B, C>(B Function(A x, int index, C? option) mapper,
      {List<C> options = const []}) {
    var index = 0;
    return this.map((final x) {
      final option = options.length > index ? options[index] : null;
      return mapper(x, index++, option);
    });
  }
}

extension SetMapI<A> on Set<A> {
  Iterable<B> mapi<B, C>(B Function(A x, int index, C? option) mapper,
      {List<C> options = const []}) {
    var index = 0;
    return this.map((final x) {
      final option = options.length > index ? options[index] : null;
      return mapper(x, index++, option);
    });
  }
}

extension MapMapI<A1, A2> on Map<A1, A2> {
  Map<B1, B2> mapi<B1, B2, C>(MapEntry<B1, B2> Function(A1 x1, A2 x2, int index, C? option) mapper,
      {List<C> options = const []}) {
    var index = 0;
    return this.map((final x1, final x2) {
      final option = options.length > index ? options[index] : null;
      return mapper(x1, x2, index++, option);
    });
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension MapNonNulls<T1, T2> on Map<T1?, T2?> {
  Map<T1, T2> get nonNulls {
    return Map<T1, T2>.fromEntries(
      this
          .entries
          .where((final l) => l.key != null && l.value != null)
          .map((final l) => MapEntry(l.key as T1, l.value as T2)),
    );
  }
}

extension MapNonNullKeys<T1, T2> on Map<T1?, T2> {
  Map<T1, T2> get nonNullKeys {
    return Map<T1, T2>.fromEntries(
      this
          .entries
          .where((final l) => l.key != null)
          .map((final l) => MapEntry(l.key as T1, l.value)),
    );
  }
}

extension MapNonNullValues<T1, T2> on Map<T1, T2?> {
  Map<T1, T2> get nonNullValues {
    return Map<T1, T2>.fromEntries(
      this
          .entries
          .where((final l) => l.value != null)
          .map((final l) => MapEntry(l.key, l.value as T2)),
    );
  }
}

// extension IterableNonNulls<T> on Iterable<T?> {
//   Iterable<T> get nonNulls {
//     return this.where((final l) => l != null).map((final l) => l!);
//   }
// }

// extension ListNonNulls<T> on List<T?> {
//   List<T> get nonNulls {
//     return this.where((final l) => l != null).map((final l) => l!).toList();
//   }
// }

// extension SetNonNulls<T> on Set<T?> {
//   Set<T> get nonNulls {
//     return this.where((final l) => l != null).map((final l) => l!).toSet();
//   }
// }

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension StringNullIfEmpty on String {
  String? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension MapNullIfEmpty<T1, T2> on Map<T1, T2> {
  Map<T1, T2>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension IterableNullIfEmpty<T> on Iterable<T> {
  Iterable<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension ListNullIfEmpty<T> on List<T> {
  List<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension SetNullIfEmpty<T> on Set<T> {
  Set<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

T? nullIfEmpty<T>(T value) {
  if (value is String) return value.nullIfEmpty as T?;
  if (value is Map) return value.nullIfEmpty as T?;
  if (value is Iterable) return value.nullIfEmpty as T?;
  if (value is List) return value.nullIfEmpty as T?;
  if (value is Set) return value.nullIfEmpty as T?;
  return value;
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
          final keyAsString = key.toString();
          return MapEntry(keyAsString.substring(_OFFSET, keyAsString.length - 2), value);
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

typedef JMap = Map<String, dynamic>;

String? _defaultKeyConverter(dynamic key) {
  if (key is DateTime) {
    return key.microsecondsSinceEpoch.toString();
  }
  return null;
}

JMap mapToJMap<T1, T2>(
  Map<T1, T2> input, {
  Set<Type> typesAllowed = const {},
  String? Function(dynamic)? keyConverter,
}) {
  return _mapToJMap(input, typesAllowed, keyConverter);
}

dynamic _mapToJMap(
  dynamic input,
  Set<Type> typesAllowed,
  String? Function(dynamic)? keyConverter,
) {
  if (input is Map) {
    return input.map(
      (final k, final v) => MapEntry(
        keyConverter?.call(k) ?? _defaultKeyConverter(k) ?? k.toString(),
        _mapToJMap(
          v,
          typesAllowed,
          keyConverter,
        ),
      ),
    );
  } else if (input is Iterable) {
    return input
        .map(
          (final l) => _mapToJMap(
            l,
            typesAllowed,
            keyConverter,
          ),
        )
        .toList();
  }
  if ({
    bool,
    String,
    int,
    double,
    num,
    ...typesAllowed,
  }.contains(input.runtimeType)) {
    return input;
  }
  assert(
    false,
    "[mapToJson] Unsupported type \"${input.runtimeType}\"",
  );
  return input.toString();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String mapToCsv(Map input) {
  var output = "";
  for (final entry in input.entries) {
    final key = entry.key;
    dynamic value = entry.value;
    if (value is Map) {
      value = mapToCsv(value);
    } else if (value is List) {
      final s = value.toString();
      value = s.substring(1, s.length - 1);
    }
    output += "\"$key\",\"$value\"\n";
  }
  return output;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension TryReduce<T> on Iterable<T> {
  T? tryReduce(T Function(T, T) combine) {
    try {
      return this.reduce(combine);
    } catch (_) {
      return null;
    }
  }
}

extension TryMerge<T> on Iterable<Iterable<T>> {
  Iterable<T>? tryMerge([Iterable<T> Function(Iterable<T>, Iterable<T>)? merge]) {
    try {
      return this.reduce(merge ?? (final a, final b) => <T>[...a, ...b]);
    } catch (_) {
      return null;
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

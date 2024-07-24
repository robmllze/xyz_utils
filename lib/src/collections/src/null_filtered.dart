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

/// Converts [input] to a Map with non-null keys and values if `K` and `V` are
/// non-null.
Map<K, V> nullFilteredMap<K, V>(Map input) {
  final filtered = input.entries.toList()
    ..retainWhere(
      (e) => (null is K || e.key != null) && (null is V || e.value != null),
    );
  final mapped = filtered.map((e) => MapEntry<K, V>(e.key, e.value));
  final result = Map.fromEntries(mapped);
  return result;
}

/// Converts [input] to a List with non-null elements if `T` is non-null.
List<T> nullFilteredList<T>(Iterable input) {
  final filtered = input.toList()..retainWhere((e) => (null is T || e != null));
  return filtered.cast();
}

/// Converts [input] to a Set with non-null elements if `T` is non-null.
Set<T> nullFilteredSet<T>(Iterable input) {
  final filtered = input.toSet()..retainWhere((e) => (null is T || e != null));
  return filtered.cast();
}

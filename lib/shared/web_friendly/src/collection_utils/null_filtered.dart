//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// Copyright (c) 2023 Robert Mollentze
// See LICENSE for details.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

Map<T1, T2> nullFilteredMap<T1, T2>(Map input) {
  final filtered = input.entries.toList()
    ..retainWhere(
      (final l) =>
          (null is T1 || l.key != null) && (null is T2 || l.value != null),
    );
  final mapped = filtered.map((final l) => MapEntry<T1, T2>(l.key, l.value));
  final result = Map.fromEntries(mapped);
  return result;
}

/// Converts [input] to a List with non-null elements if `T` is non-null.
List<T> nullFilteredList<T>(Iterable input) {
  final filtered = input.toList()
    ..retainWhere((final l) => (null is T || l != null));
  return filtered.cast();
}

/// Converts [input] to a Set with non-null elements if `T` is non-null.
Set<T> nullFilteredSet<T>(Iterable input) {
  final filtered = input.toSet()
    ..retainWhere((final l) => (null is T || l != null));
  return filtered.cast();
}

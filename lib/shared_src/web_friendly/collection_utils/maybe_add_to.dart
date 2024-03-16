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

/// Adds [add] to [source] if both are not null.
Iterable<T>? maybeAddToIterable<T>(Iterable<T>? source, Iterable<T>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return [...source, ...add];
}

extension MaybeAddToIterableExtension<T> on Iterable<T> {
  /// Adds [add] to this its not null.
  Iterable<T>? maybeAdd(Iterable<T>? add) => maybeAddToIterable(this, add)!;
}

/// Adds [add] to [source] if both are not null.
List<T>? maybeAddToList<T>(List<T>? source, List<T>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return [...source, ...add];
}

extension MaybeAddToListExtension<T> on List<T> {
  /// Adds [add] to this its not null.
  List<T> maybeAdd(List<T>? add) => maybeAddToList(this, add)!;
}

/// Adds [add] to [source] if both are not null.
Set<T>? maybeAddToSet<T>(Set<T>? source, Set<T>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return {...source, ...add};
}

extension MaybeAddToSetExtension<T> on Set<T> {
  /// Adds [add] to this its not null.
  Set<T> maybeAdd(Set<T>? add) => maybeAddToSet(this, add)!;
}

/// Adds [add] to [source] if both are not null.
Map<T1, T2>? maybeAddToMap<T1, T2>(Map<T1, T2>? source, Map<T1, T2>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return {...source, ...add};
}

extension MaybeAddToMapExtension<T1, T2> on Map<T1, T2> {
  /// Adds [add] to this its not null.
  Map<T1, T2> maybeAdd(Map<T1, T2>? add) => maybeAddToMap(this, add)!;
}

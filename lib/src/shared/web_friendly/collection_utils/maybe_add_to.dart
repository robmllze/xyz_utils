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

Iterable<T>? maybeAddToIterable<T>(Iterable<T>? source, Iterable<T>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return [...source, ...add];
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

Map<T1, T2>? maybeAddToMap<T1, T2>(Map<T1, T2>? source, Map<T1, T2>? add) {
  if (source == null) return source;
  if (add == null) return source;
  return {...source, ...add};
}

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

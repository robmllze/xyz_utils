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

extension ToMapOnIterableExtension<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() {
    return Map.fromEntries(this);
  }
}

Set<T> getSetDifference<T>(Set<T> before, Set<T> after) {
  final results = <T>{};
  for (final a in after) {
    if (!before.contains(a)) results.add(a);
  }
  return results;
}

extension TryReduceOnIterableExtension<T> on Iterable<T> {
  T? tryReduce(T Function(T, T) combine) {
    try {
      return this.reduce(combine);
    } catch (_) {
      return null;
    }
  }
}

extension TryMergeOnIterableExtension<T> on Iterable<Iterable<T>?> {
  Iterable<T>? tryMerge([
    Iterable<T> Function(Iterable<T>?, Iterable<T>?)? merge,
  ]) {
    try {
      return this.reduce(merge ?? (a, b) => <T>[...a ?? [], ...b ?? []]);
    } catch (_) {
      return null;
    }
  }
}

String combinedOrderedStringId(List<String> ids) {
  final sorted = ids..sort((a, b) => a.compareTo(b));
  final combined = sorted.join("_");
  return combined;
}

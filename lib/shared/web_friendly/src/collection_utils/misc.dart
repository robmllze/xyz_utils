//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension IterableToMap<K, V> on Iterable<MapEntry<K, V>> {
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

extension TryReduce<T> on Iterable<T> {
  T? tryReduce(T Function(T, T) combine) {
    try {
      return this.reduce(combine);
    } catch (_) {
      return null;
    }
  }
}

extension TryMerge<T> on Iterable<Iterable<T>?> {
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

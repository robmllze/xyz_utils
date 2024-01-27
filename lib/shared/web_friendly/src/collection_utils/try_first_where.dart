//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

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

extension TryFirstWhereMap<K, V> on Map<K, V> {
  MapEntry<K, V>? tryFirstWhere(bool Function(MapEntry<K, V>) test) {
    try {
      return this.entries.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

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

extension FirstWhereOrNullOnIterableExtension<T> on Iterable<T> {
  /// Returns the first element that satisfies the given predicate [test], or
  /// `null` if there are none.
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension FirstWhereOrNullOnListExtension<T> on List<T> {
  /// Returns the first element that satisfies the given predicate [test], or
  /// `null` if there are none.
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension FirstWhereOrNullOnSetExtension<T> on Set<T> {
  /// Returns the first element that satisfies the given predicate [test], or
  /// `null` if there are none.
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension FirstWhereOrNullOnMapExtension<K, V> on Map<K, V> {
  /// Returns the first entry that satisfies the given predicate [test], or
  /// `null` if there are none.
  MapEntry<K, V>? firstWhereOrNull(bool Function(MapEntry<K, V>) test) {
    try {
      return this.entries.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

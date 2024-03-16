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

extension FirstWhereOrNullOnIterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension FirstWhereOrNullOnListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension FirstWhereOrNullOnSetExtension<T> on Set<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return this.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

extension FirstWhereOrNullOnMapExtension<K, V> on Map<K, V> {
  MapEntry<K, V>? firstWhereOrNull(bool Function(MapEntry<K, V>) test) {
    try {
      return this.entries.firstWhere(test);
    } catch (_) {
      return null;
    }
  }
}

//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension MapNonNulls<K, V> on Map<K?, V?> {
  Map<K, V> get nonNulls {
    return Map<K, V>.fromEntries(
      this
          .entries
          .where((e) => e.key != null && e.value != null)
          .map((e) => MapEntry(e.key as K, e.value as V)),
    );
  }
}

extension MapNonNullKeys<K, V> on Map<K?, V> {
  Map<K, V> get nonNullKeys {
    return Map<K, V>.fromEntries(
      this
          .entries
          .where((e) => e.key != null)
          .map((e) => MapEntry(e.key as K, e.value)),
    );
  }
}

extension MapNonNullValues<K, V> on Map<K, V?> {
  Map<K, V> get nonNullValues {
    return Map<K, V>.fromEntries(
      this
          .entries
          .where((e) => e.value != null)
          .map((e) => MapEntry(e.key, e.value as V)),
    );
  }
}
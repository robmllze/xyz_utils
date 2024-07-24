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

extension MapWithDefaultOnMapExtension<K, V> on Map<K, V> {
  /// Returns a new map with the same keys as this map but with the specified
  /// [defaultValue] for all values that are null. If [defaultValue] is null,
  /// it simply returns a copy of the original map.
  Map<K, dynamic> mapWithDefault(dynamic defaultValue) {
    return defaultValue != null
        ? this.map((k, v) => MapEntry(k, v ?? defaultValue))
        : Map.of(this);
  }

  /// Filters the map's entries based on a list of included values.
  /// Returns a new map containing only the key-value pairs where the value
  /// is found within the [includedValues].
  Map<K, V> filterByIncludedValues(List<V> includedValues) {
    return Map.fromEntries(
      this.entries.where((e) => includedValues.contains(e.value)),
    );
  }

  /// Filters the map's entries based on a list of excluded values.
  /// Returns a new map excluding the key-value pairs where the value
  /// is found within the [excludedValues].
  Map<K, V> filterByExcludedValues(List<V> excludedValues) {
    return Map.fromEntries(
      this.entries.where((e) => !excludedValues.contains(e.value)),
    );
  }

  /// Filters the map's entries based on a list of included keys.
  /// Returns a new map containing only the key-value pairs where the key
  /// is found within the [includedKeys].
  Map<K, V> filterByIncludedKeys(List<K> includedKeys) {
    return Map.fromEntries(
      this.entries.where((e) => includedKeys.contains(e.key)),
    );
  }

  /// Filters the map's entries based on a list of excluded keys.
  /// Returns a new map excluding the key-value pairs where the key
  /// is found within the [excludedKeys].
  Map<K, V> filterByExcludedKeys(List<K> excludedKeys) {
    return Map.fromEntries(
      this.entries.where((e) => !excludedKeys.contains(e.key)),
    );
  }
}

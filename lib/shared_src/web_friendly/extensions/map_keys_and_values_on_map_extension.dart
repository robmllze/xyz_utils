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

extension MapKeysAndValyesOnMapExtension<K1, V1> on Map<K1, V1> {
  /// Returns a new map with new keys and the same values.
  Map<K2, V1> mapKeys<K2>(K2 Function(K1 key) mapper) {
    return Map.fromEntries(
      entries.map(
        (e) => MapEntry(
          mapper(e.key),
          e.value,
        ),
      ),
    );
  }

  /// Returns a new map with the same keys and new values.
  Map<K1, V2> mapValues<V2>(V2 Function(V1 value) mapper) {
    return Map.fromEntries(
      entries.map(
        (e) => MapEntry(
          e.key,
          mapper(e.value),
        ),
      ),
    );
  }
}

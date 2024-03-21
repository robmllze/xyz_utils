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

/// Converts a map to a Json map by recursively converting its keys and values
/// to Json compatible types.
Json mapToJson<T1, T2>(
  Map<T1, T2> input, {
  Set<Type> typesAllowed = const {},
  String? Function(dynamic)? keyConverter,
}) {
  return _mapToJson(input, typesAllowed, keyConverter);
}

dynamic _mapToJson(
  dynamic input,
  Set<Type> typesAllowed,
  String? Function(dynamic)? keyConverter,
) {
  if (input is Map) {
    return input.map(
      (k, v) => MapEntry(
        keyConverter?.call(k) ?? _defaultKeyConverter(k) ?? k.toString(),
        _mapToJson(
          v,
          typesAllowed,
          keyConverter,
        ),
      ),
    );
  } else if (input is Iterable) {
    return input.map((e) => _mapToJson(e, typesAllowed, keyConverter)).toList();
  }
  if ({
    bool,
    String,
    int,
    double,
    num,
    ...typesAllowed,
  }.contains(input.runtimeType)) {
    return input;
  }
  assert(
    false,
    '[mapToJson] Unsupported type "${input.runtimeType}"',
  );
  return input.toString();
}

String? _defaultKeyConverter(dynamic key) {
  if (key is DateTime) {
    return key.microsecondsSinceEpoch.toString();
  }
  return null;
}

/// A type alias for a Json map.
typedef Json = Map<String, dynamic>;

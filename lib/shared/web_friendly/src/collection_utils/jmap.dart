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

typedef JMap = Map<String, dynamic>;

String? _defaultKeyConverter(dynamic key) {
  if (key is DateTime) {
    return key.microsecondsSinceEpoch.toString();
  }
  return null;
}

JMap mapToJMap<T1, T2>(
  Map<T1, T2> input, {
  Set<Type> typesAllowed = const {},
  String? Function(dynamic)? keyConverter,
}) {
  return _mapToJMap(input, typesAllowed, keyConverter);
}

dynamic _mapToJMap(
  dynamic input,
  Set<Type> typesAllowed,
  String? Function(dynamic)? keyConverter,
) {
  if (input is Map) {
    return input.map(
      (final k, final v) => MapEntry(
        keyConverter?.call(k) ?? _defaultKeyConverter(k) ?? k.toString(),
        _mapToJMap(
          v,
          typesAllowed,
          keyConverter,
        ),
      ),
    );
  } else if (input is Iterable) {
    return input
        .map(
          (final l) => _mapToJMap(
            l,
            typesAllowed,
            keyConverter,
          ),
        )
        .toList();
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
    "[mapToJson] Unsupported type \"${input.runtimeType}\"",
  );
  return input.toString();
}

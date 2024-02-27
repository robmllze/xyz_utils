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

extension StringNullIfEmpty on String {
  String? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension MapNullIfEmpty<T1, T2> on Map<T1, T2> {
  Map<T1, T2>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension IterableNullIfEmpty<T> on Iterable<T> {
  Iterable<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension ListNullIfEmpty<T> on List<T> {
  List<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension SetNullIfEmpty<T> on Set<T> {
  Set<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

T? nullIfEmpty<T>(T value) {
  if (value is String) return value.nullIfEmpty as T?;
  if (value is Map) return value.nullIfEmpty as T?;
  if (value is Iterable) return value.nullIfEmpty as T?;
  if (value is List) return value.nullIfEmpty as T?;
  if (value is Set) return value.nullIfEmpty as T?;
  return value;
}

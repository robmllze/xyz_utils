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

import 'dart:collection';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension NullIfEmptyOnStringExtension on String {
  String? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension NullIfEmptyOnMapExtension<T1, T2> on Map<T1, T2> {
  Map<T1, T2>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension NullIfEmptyOnIterableExtension<T> on Iterable<T> {
  Iterable<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension LNullIfEmptyOnListExtension<T> on List<T> {
  List<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension NullIfEmptyOnSetExtension<T> on Set<T> {
  Set<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension NullIfEmptyOnQueueExtension<T> on Queue<T> {
  Queue<T>? get nullIfEmpty {
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

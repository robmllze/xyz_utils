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

import "dart:collection";

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension NullIfEmptyOnStringExtension on String {
  /// Returns null if the String is empty, otherwise returns the String.
  String? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension NullIfEmptyOnMapExtension<T1, T2> on Map<T1, T2> {
  /// Returns null if the Map is empty, otherwise returns the Map.
  Map<T1, T2>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension NullIfEmptyOnIterableExtension<T> on Iterable<T> {
  /// Returns null if the Iterable is empty, otherwise returns the Iterable.
  Iterable<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension LNullIfEmptyOnListExtension<T> on List<T> {
  /// Returns null if the List is empty, otherwise returns the List.
  List<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension NullIfEmptyOnSetExtension<T> on Set<T> {
  /// Returns null if the Set is empty, otherwise returns the Set.
  Set<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

extension NullIfEmptyOnQueueExtension<T> on Queue<T> {
  /// Returns null if the Queue is empty, otherwise returns the Queue.
  Queue<T>? get nullIfEmpty {
    return this.isEmpty ? null : this;
  }
}

/// Returns null if [value] is empty, otherwise returns [value].
T? nullIfEmpty<T>(T value) {
  if (value is String) return value.nullIfEmpty as T?;
  if (value is Map) return value.nullIfEmpty as T?;
  if (value is Iterable) return value.nullIfEmpty as T?;
  if (value is List) return value.nullIfEmpty as T?;
  if (value is Set) return value.nullIfEmpty as T?;
  if (value is Queue) return value.nullIfEmpty as T?;
  return value;
}

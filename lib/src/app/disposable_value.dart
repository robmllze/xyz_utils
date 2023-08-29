// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:collection';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Manages disposal of DisposableValue instances by tracking values in a map,
/// with disposal and check methods.
class DisposableValue<T> {
  //
  //
  //

  static final _weakRefs = HashSet<WeakReference<DisposableValue>>();
  static final _values = <int, dynamic>{};
  static var _i = 0;

  //
  //
  //

  final int _key;

  //
  //
  //

  DisposableValue._(this._key);

  factory DisposableValue(T value) {
    _values[_i] = value;
    final instance = DisposableValue<T>._(_i);
    _i++;
    _weakRefs.add(WeakReference(instance));
    return instance;
  }

  //
  //
  //

  T get value => _values[this._key]; // Note that T may be Null

  set value(T value) => _values[this._key] = value;

  void dispose([bool garbageCollect = false]) {
    _values.remove(this._key);
    if (garbageCollect) {
      _weakRefs.removeWhere((final ref) => ref.target?._key == this._key);
    }
  }

  bool get isDisposed => !_values.containsKey(this._key);

  //
  //
  //

  /// Returns a new instance of the same type with the same internal key value,
  /// but without any finalizer or weak reference attached to it.
  ///
  /// The primary purpose of the `pass` method is to allow you to pass a
  /// `DisposableValue` instance to a function or another object, while ensuring
  /// that the original instance is not disposed of prematurely. The new instance
  /// returned by `pass` can be passed around freely, and when it is eventually
  /// disposed of, it will automatically dispose of the original instance as
  /// well.
  ///
  /// Example:
  /// ```dart
  /// final a = DisposableValue('hello');
  /// final b = a.pass;
  /// print(b.value); // Prints "hello"
  /// a.dispose();
  /// print(b.value); // Throws an exception, because a was disposed
  /// ```
  DisposableValue<T> get pass => DisposableValue<T>._(this._key);
  DisposableValue<C> passAs<C>() => DisposableValue<C>._(this._key);

  /// Removes any weak references to disposed `AutoDisposableValue` instances
  /// from the internal weak reference set and disposes of their associated
  /// values in the internal value map.
  ///
  /// Since `AutoDisposableValue` instances are automatically disposed of when
  /// they are no longer needed, you may end up with many instances that have
  /// been disposed of but whose weak references are still taking up memory. By
  /// calling `garbageCollect`, you can remove these weak references and free up
  /// memory.
  ///
  /// It's recommended to call `garbageCollect` periodically, such as during
  /// idle periods in your application, to keep memory usage under control.
  static void garbageCollect() {
    _weakRefs.removeWhere((ref) {
      final instance = ref.target;
      if (instance == null) {
        return true;
      }
      if (instance.isDisposed) {
        _values.remove(instance._key);
        return true;
      }
      return false;
    });
  }
}

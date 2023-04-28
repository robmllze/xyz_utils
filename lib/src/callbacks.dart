// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

import '../xyz_utils.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Provides a flexible and easy-to-use way to manage and execute a collection
/// of callbacks. Callbacks may be preferred over the usual Flutter callbacks
/// because they offer the following additional features:
///
/// - The ability to add, remove, and check the existence of callbacks using a
/// callback key.
/// - The ability to execute all callbacks in sequence or simultaneously.
/// - The ability to track the completion of the execution of all callbacks,
/// which is useful when subsequent actions depend on the completion of all
/// callbacks.
class Callbacks<T1, T2 extends TCallback<T1>> {
  //
  //
  //

  final _queue = FunctionQueue();
  final _callbacks = <dynamic, TCallback<T1>>{};

  //
  //
  //

  /// Adds a new [callback] to the collection and assigns an optional
  /// [callbackKey] to call or remove it later.
  void Function() add(TCallback<T1> callback, {dynamic callbackKey}) {
    final k = callbackKey ?? callback;
    this._callbacks[k] = callback;
    return () => this._callbacks.remove(k);
  }

  /// Checks whether a callback with the given callbackKey exists in the collection.
  bool exists(dynamic callbackKey) => this._callbacks.containsKey(callbackKey);

  /// Removes the callback with the given [callbackKey] from the collection.
  bool remove(dynamic callbackKey) => this._callbacks.remove(callbackKey) != null;

  /// Clears all callbacks from the collection.
  void clear() => this._callbacks.clear();

  /// Returns a Future which waits for all currently executing callbacks to
  /// complete.
  Future<void> wait() async => await this._queue.add(() async {});

  /// Invokes the callback with the given [callbackKey] passing in the given
  /// [param].
  Future<bool> call(dynamic callbackKey, T1 param) async {
    final callback = this._callbacks[callbackKey];
    await callback?.call(callbackKey, param);
    return callback != null;
  }

  /// Invokes all callbacks in the collection with the given [param] and returns
  /// a map of the results of each callback. The optional function [onError] can
  /// be passed to handle errors.
  Future<Map<dynamic, dynamic>> callAll(
    T1 param, [
    dynamic Function(Object e)? onError,
  ]) async {
    return _queue.add<Map<dynamic, dynamic>>(() async {
      final results = <dynamic, dynamic>{};
      for (final entry in this._callbacks.entries) {
        final key = entry.key;
        final function = entry.value;
        results[key] = await function(key, param);
      }
      return results;
    });
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef TCallback<T> = Future<dynamic> Function(dynamic callbackKey, T param);

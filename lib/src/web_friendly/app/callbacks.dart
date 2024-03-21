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

import 'dart:async';

import '/src/web_friendly/_all_web_friendly.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Provides a flexible and easy way to manage and execute a set of callbacks.
///
/// This class provides the following features:
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

  /// Adds a new callback.
  ///
  /// - [callback] Specify the callback to add.
  /// - [callbackKey] Specify a key for the callback that can be used to
  /// identify the callback. If not specified, the callback itself will be used
  /// as the key.
  ///
  /// Returns a function that removes the callback.
  void Function() add(TCallback<T1> callback, {dynamic callbackKey}) {
    if (this._queue.isNotEmpty) {
      Here().debugLogAlert(
        'Do not add callbacks while callbacks are executing. Call wait() first.',
      );
    }
    final k = callbackKey ?? callback;
    this._callbacks[k] = callback;
    return () => this._callbacks.remove(k);
  }

  /// Checks if the appropriate callback exists.
  ///
  /// - [callbackKey] Specify which callback to check.
  ///
  /// Returns `true` if the callback exists, otherwise `false`.
  bool exists(dynamic callbackKey) {
    if (this._queue.isNotEmpty) {
      Here().debugLogAlert(
        'Do not check callbacks while callbacks are executing. Call wait() first.',
      );
    }
    return this._callbacks.containsKey(callbackKey);
  }

  /// Removes the appropriate callback.
  ///
  /// - [callbackKey] Specify which callback to remove.
  ///
  /// Returns `true` if the callback was found and removed, otherwise `false`.
  bool remove(dynamic callbackKey) {
    if (this._queue.isNotEmpty) {
      Here().debugLogAlert(
        'Do not remove callbacks while callbacks are executing. Call wait() first.',
      );
    }
    return this._callbacks.remove(callbackKey) != null;
  }

  /// Clears all callbacks.
  void clear() {
    if (this._queue.isNotEmpty) {
      Here().debugLogAlert(
        'Do not clear callbacks while callbacks are executing. Call wait() first.',
      );
    }
    this._callbacks.clear();
  }

  /// Returns a Future which waits for all currently callbacks to complete.
  Future<void> wait() => this._queue.wait();

  /// Invokes the appropriate callback.
  ///
  /// - [callbackKey] Specify which callback to invoke.
  /// - [param] Specify a parameter to pass to the callback.
  ///
  /// Returns `true` if the callback was found and invoked, otherwise `false`.
  Future<bool> call(dynamic callbackKey, T1 param) async {
    return this._queue.add(() async {
      final callback = this._callbacks[callbackKey];
      await callback?.call(callbackKey, param);
      return callback != null;
    });
  }

  /// Invokes the appripriate callbacks in the collection.
  ///
  /// - [param] Specify a parameter to pass to the callbacks.
  /// - [include] Specify which callbacks to invoke. Set to null to include all callbacks.
  /// - [exclude] Specify which callbacks to exclude from invocation.
  /// - [onError] Specify a callback to execute if an error occurs.
  ///
  /// Returns a map where each key corresponds to a callback's key and its
  /// associated result.
  Future<Map<dynamic, dynamic>> callAll(
    T1 param, {
    Set<dynamic>? include,
    Set<dynamic> exclude = const {},
    dynamic Function(Object e)? onError,
  }) async {
    return this._queue.add(() async {
      final results = <dynamic, dynamic>{};
      var entries = this._callbacks.entries;
      if (include != null) {
        entries = entries.where((e) => include.contains(e.key));
      }
      if (exclude.isNotEmpty) {
        entries = entries.where((e) => !exclude.contains(e.key));
      }
      for (final entry in entries) {
        final key = entry.key;
        final function = entry.value;
        try {
          results[key] = await function(key, param);
        } catch (e) {
          if (onError != null) {
            results[key] = onError(e);
          } else {
            rethrow;
          }
        }
      }
      return results;
    });
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef TCallback<T> = Future<dynamic> Function(dynamic callbackKey, T param);

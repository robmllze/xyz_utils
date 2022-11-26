// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

typedef TCallback<T> = Future<dynamic> Function(dynamic key, T param);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// # Usage Example:
///
/// ```dart
/// final callbacks = Callbacks();
/// final keyEnlgish = "123";
/// callbacks.add(
///   (_, final param) async {print("Hello ${param}!");},
///   key: keyEnlgish
/// );
/// final removeSpanish = callbacks.add(
///   (_, final param) async {print("Hola ${param}!");}
/// );
/// await callbacks.executeTogether("Jack");
/// await callbacks.executeTogether("Jill");
/// removeSpanish();
/// await callbacks.executeTogether("Jose");
/// callbacks.remove(keyEnlgish);
/// await callbacks.executeTogether("Juan");
///  ```
///
/// ## Output:
///
/// ```bash
/// Hello Jack!
/// Hola Jack!
/// Hello Jill!
/// Hola Jill!
/// Hello Jose!
/// ```
class Callbacks<T1, T2 extends TCallback<T1>> {
  //
  //
  //

  final _callbacks = <dynamic, TCallback<T1>>{};

  //
  //
  //

  void Function() add(TCallback<T1> callback, {dynamic key}) {
    final k = key ?? callback;
    this._callbacks[k] = callback;
    return () => this._callbacks.remove(k);
  }

  //
  //
  //

  bool exists(dynamic key) {
    return this._callbacks.containsKey(key);
  }

  //
  //
  //

  bool remove(dynamic key) {
    return this._callbacks.remove(key) != null;
  }

  //
  //
  //

  void clear() {
    return this._callbacks.clear();
  }

  //
  //
  //

  Future<bool> call(dynamic key, T1 param) async {
    final callback = this._callbacks[key];
    await callback?.call(key, param);
    return callback != null;
  }

  //
  //
  //

  Future<Map<dynamic, dynamic>?> callAll(
    T1 param, [
    dynamic Function(Object e)? onError,
  ]) async {
    final results = <dynamic, dynamic>{};
    for (final l in this._callbacks.entries) {
      final key = l.key;
      final callback = l.value;
      try {
        results[key] = await callback(key, param);
      } catch (e) {
        if (onError != null) {
          results[key] = onError(e);
        } else {
          rethrow;
        }
      }
    }
    return results;
  }

  //
  //
  //

  Future<Map<dynamic, dynamic>?> callAllSimultaneously(
    T1 param, {
    dynamic Function(Object e)? onError,
  }) async {
    final results = <dynamic, dynamic>{};
    final callbacks = this._callbacks.entries.map(
      (final l) async {
        final key = l.key;
        final callback = l.value;
        try {
          results[key] = await callback(key, param);
        } catch (e) {
          if (onError != null) {
            results[key] = onError(e);
          } else {
            rethrow;
          }
        }
      },
    );
    if (callbacks.isNotEmpty) {
      await Future.wait(callbacks);
      return results;
    }
    return null;
  }
}

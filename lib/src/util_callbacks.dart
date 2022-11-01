// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

typedef TCallback<T> = FutureOr<void> Function(dynamic key, T param);

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
    this._callbacks[key ?? callback] = callback;
    return () {
      this._callbacks.remove(callback);
    };
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

  FutureOr<bool> execute(dynamic key, T1 param) async {
    final callback = this._callbacks[key];
    await callback?.call(key, param);
    return callback != null;
  }

  //
  //
  //

  FutureOr<bool> executeTogether(T1 param) async {
    final all = this._callbacks.entries.map((final l) => l.value(l.key, param));
    if (all.isNotEmpty) {
      await Future.wait(all.map((final l) async => await l));
      return true;
    }
    return false;
  }
}

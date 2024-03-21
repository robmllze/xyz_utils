//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:async' show Timer;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// # Usage Example:
///
/// ```dart
/// bool _didPrint = false;
///
/// final _debouncer = Debouncer(
///   const Duration(seconds: 1),
///   onWaited: () {
///     print('Hello World!');
///     bool _didPrint = true;
///   }
/// );
///
/// // ...
///
/// this._debouncer((){
///   bool _didPrint = false;
/// });
/// ```
class Debouncer {
  //
  //
  //

  Timer? _timer;

  /// The function to call after the [delay] has passed.
  final void Function()? onWaited;

  /// The function to call immediately.
  final void Function()? onCall;

  /// The delay before calling the [onWaited] function.
  final Duration delay;

  //
  //
  //

  Debouncer({
    required this.delay,
    this.onWaited,
    this.onCall,
  });

  //
  //
  //

  /// Calls the [onCall] function and then waits for [delay] before calling the
  /// [onWaited] function.
  void call({
    void Function()? onWaited,
    void Function()? onCall,
  }) async {
    this.onCall?.call();
    onCall?.call();
    this._timer?.cancel();
    this._timer = Timer(delay, () async {
      this.onWaited?.call();
      onWaited?.call();
    });
  }

  //
  //
  //

  /// Finalizes the debouncer and calls the [onWaited] function.
  void finalize({void Function()? onWaited}) async {
    if (this._timer != null) {
      if (this._timer!.isActive) {
        this._timer!.cancel();
        this._timer = null;
        this.onWaited?.call();
        onWaited?.call();
      }
    }
  }

  //
  //
  //

  /// Cancels the debouncer.
  bool cancel() {
    final timer = this._timer;
    if (timer != null) {
      if (timer.isActive) {
        timer.cancel();
        return true;
      }
    }
    return false;
  }
}

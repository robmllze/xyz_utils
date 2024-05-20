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

import 'dart:async' show FutureOr, Timer;

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
  final FutureOr<void> Function()? onWaited;

  /// The function to call immediately.
  final FutureOr<void> Function()? onCall;

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
  FutureOr<void> call({
    FutureOr<void> Function()? onWaited,
    FutureOr<void> Function()? onCall,
  }) async {
    this.cancel();
    await this.onCall?.call();
    await onCall?.call();
    this._timer = Timer(
      delay,
      () async {
        await this.onWaited?.call();
        await onWaited?.call();
      },
    );
  }

  //
  //
  //

  /// Finalizes the debouncer and calls the [onWaited] function.
  FutureOr<void> finalize({FutureOr<void> Function()? onWaited}) async {
    if (this.cancel()) {
      await this.onWaited?.call();
      await onWaited?.call();
    }
  }

  //
  //
  //

  /// Cancels the debouncer.
  bool cancel() {
    if (this._timer != null) {
      if (this._timer!.isActive) {
        this._timer!.cancel();
        this._timer = null;
        return true;
      }
    }
    return false;
  }
}

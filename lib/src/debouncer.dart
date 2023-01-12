// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

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
///     print("Hello World!");
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
  final void Function()? onWaited;
  final void Function()? onCall;
  final Duration delay;

  //
  //
  //

  Debouncer({required this.delay, this.onWaited, this.onCall});

  //
  //
  //

  void call({void Function()? onWaited, void Function()? onCall}) {
    this.onCall?.call();
    onCall?.call();
    this._timer?.cancel();
    this._timer = Timer(delay, () {
      this.onWaited?.call();
      onWaited?.call();
    });
  }

  //
  //
  //

  void finalize({void Function()? onWaited}) {
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

  void cancel() {
    this._timer?.cancel();
  }
}

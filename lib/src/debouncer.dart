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
  final Future<void> Function()? onWaited;
  final Future<void> Function()? onCall;
  final Duration delay;

  //
  //
  //

  Debouncer({required this.delay, this.onWaited, this.onCall});

  //
  //
  //

  Future<void> call({
    Future<void> Function()? onWaited,
    Future<void> Function()? onCall,
  }) async {
    await this.onCall?.call();
    await onCall?.call();
    this._timer?.cancel();
    this._timer = Timer(delay, () async {
      await this.onWaited?.call();
      await onWaited?.call();
    });
  }

  //
  //
  //

  Future<void> finalize({Future<void> Function()? onWaited}) async {
    if (this._timer != null) {
      if (this._timer!.isActive) {
        this._timer!.cancel();
        this._timer = null;
        await this.onWaited?.call();
        await onWaited?.call();
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

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

/// A class that formats a [Duration] into a human-readable string.
class DurationFormattedEnglish {
  //
  //
  //

  DurationFormattedEnglish(int microseconds) {
    const MS = 1000,
        S = 1000 * MS,
        M = 60 * S,
        H = 60 * M,
        D = 24 * H,
        W = 7 * D;
    late final int tms, ts, tm, th, td, tw;
    w = microseconds ~/ W;
    tw = microseconds - W * w;
    d = tw ~/ D;
    td = tw - D * d;
    h = td ~/ H;
    th = td - H * h;
    m = th ~/ M;
    tm = th - M * m;
    s = tm ~/ S;
    ts = tm - s * S;
    ms = ts ~/ MS;
    tms = ts - ms * MS;
    us = tms;
  }

  //
  //
  //

  /// The remaining microseconds in the duration.
  late final int us;

  /// The remaining milliseconds in the duration.
  late final int ms;

  /// The remaining seconds in the duration.
  late final int s;

  /// The remaining minutes in the duration.
  late final int m;

  /// The remaining hours in the duration.
  late final int h;

  /// The remaining days in the duration.
  late final int d;

  /// The remaining weeks in the duration.
  late final int w;

  //
  //
  //

  /// The formatted duration string with the week as the largest unit.
  String get toW => (w != 0 ? '${w}w ' : '');

  /// The formatted duration string with the day as the largest unit.
  String get toD => toW + (d != 0 ? '${d}d ' : '');

  /// The formatted duration string with the hour as the largest unit.
  String get toH => toD + (h != 0 ? '${h}h ' : '');

  /// The formatted duration string with the minute as the largest unit.
  String get toM => toH + (m != 0 ? '${m}m ' : '');

  /// The formatted duration string with the second as the largest unit.
  String get toS => toM + (s != 0 ? '${s}s ' : '');

  /// The formatted duration string with the millisecond as the largest unit.
  String get toMs => toS + (ms != 0 ? '${ms}ms ' : '');

  /// The formatted duration string with the microsecond as the largest unit.
  String get toUs => toMs + (us != 0 ? '$usμs ' : '');
}

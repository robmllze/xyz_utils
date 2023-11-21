//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

class DurationFormattedEnglish {
  late final int _us, _ms, _s, _m, _h, _d, _w;
  DurationFormattedEnglish(int microseconds) {
    const MS = 1000, S = 1000 * MS, M = 60 * S, H = 60 * M, D = 24 * H, W = 7 * D;
    late final int tms, ts, tm, th, td, tw;
    _w = microseconds ~/ W;
    tw = microseconds - W * w;
    _d = tw ~/ D;
    td = tw - D * d;
    _h = td ~/ H;
    th = td - H * h;
    _m = th ~/ M;
    tm = th - M * m;
    _s = tm ~/ S;
    ts = tm - s * S;
    _ms = ts ~/ MS;
    tms = ts - ms * MS;
    _us = tms;
  }
  int get w => _w;
  int get d => _d;
  int get h => _h;
  int get m => _m;
  int get s => _s;
  int get ms => _ms;
  int get us => _us;
  String get toW => (_w != 0 ? "${_w}w " : "");
  String get toD => toW + (_d != 0 ? "${_d}d " : "");
  String get toH => toD + (_h != 0 ? "${_h}h " : "");
  String get toM => toH + (_m != 0 ? "${_m}m " : "");
  String get toS => toM + (_s != 0 ? "${_s}s " : "");
  String get toMs => toS + (_ms != 0 ? "${_ms}ms " : "");
  String get toUs => toMs + (_us != 0 ? "$_usμs " : "");
}

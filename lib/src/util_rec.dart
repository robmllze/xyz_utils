// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'util_debug_log.dart' as util_debug_log;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class RecOptions {
  final Map<String, String> value;
  const RecOptions(this.value);
  RecOptions operator +(RecOptions other) {
    return RecOptions({...this.value, ...other.value});
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef _Tr = T? Function<T>(String input, Map<dynamic, dynamic> args);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Rec {
  //
  //
  //

  static _Tr? _tr;
  static void setTr(_Tr tr) => _tr = tr;

  //
  //
  //

  final String? code;
  final RecOptions options;

  //
  //
  //

  const Rec([
    this.code = "",
    this.options = const RecOptions({}),
  ]);

  //
  //
  //

  Rec call([
    String? code,
    RecOptions options = const RecOptions({}),
  ]) {
    return Rec(
      code?.isNotEmpty == true
          ? this.code?.isNotEmpty == true
              ? "${this.code}.$code"
              : null
          : this.code,
      this.options + options,
    );
  }

  //
  //
  //

  String _key() => (this.code?.isNotEmpty == true ? this.code ?? "" : "unknown");

  //
  //
  //

  String message({
    String? Function(String)? onError,
  }) {
    const ERROR = "Error: Must set translation function via Rec.setTr() before calling .message()";
    assert(_tr != null, ERROR);
    if (_tr == null) throw ERROR;
    final keyToLowerCase = this._key().toLowerCase();
    final translated = _tr!(
      keyToLowerCase,
      {
        "code": this.code ?? "",
        ...this.options.value,
      },
    ).to;

    if (keyToLowerCase == translated) {
      return onError?.call(translated) ?? translated;
    }
    return translated;
  }

  //
  //
  //

  void debugLog([Object? message]) {
    util_debug_log.debugLog(message ?? this.message(onError: (_) => "..."), this);
  }

  void debugLogAlert([String? message]) {
    util_debug_log.debugLogAlert(message ?? this.message(onError: (_) => "..."), this);
  }

  void debugLogIgnore([String? message]) {
    util_debug_log.debugLogIgnore(message ?? this.message(onError: (_) => "..."), this);
  }

  void debugLogError([String? message]) {
    util_debug_log.debugLogError(message ?? this.message(onError: (_) => "..."), this);
  }

  void debugLogInfo([String? message]) {
    util_debug_log.debugLogBegin(message ?? this.message(onError: (_) => "..."), this);
  }

  void debugLogSuccess([String? message]) {
    util_debug_log.debugLogSuccess(message ?? this.message(onError: (_) => "..."), this);
  }

  //
  //
  //

  @override
  String toString() => this.message();
}

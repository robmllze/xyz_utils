// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'debug_log.dart' as util_debug_log;

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
  final Symbol group;
  final RecOptions options;

  //
  //
  //

  const Rec([
    this.code = "",
    this.group = #debug,
    this.options = const RecOptions({}),
  ]);

  //
  //
  //

  Rec call([
    String? code,
    Symbol? group,
    RecOptions options = const RecOptions({}),
  ]) {
    return Rec(
      code?.isNotEmpty == true
          ? this.code?.isNotEmpty == true
              ? "${this.code}.$code"
              : null
          : this.code,
      group ?? this.group,
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

  void debugLog([
    Object? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLog(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  void debugLogError([
    String? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogError(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  void debugLogAlert([
    String? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogAlert(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  void debugLogIgnore([
    String? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogIgnore(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  void debugLogSuccess([
    String? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogSuccess(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  void debugLogStart([
    String? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogStart(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  void debugLogStop([
    String? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogStop(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  void debugLogInfo([
    String? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogInfo(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  void debugLogMessage([
    String? message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogMessage(
      message ?? this.message(onError: (_) => "..."),
      group ?? this.group,
      this,
    );
  }

  //
  //
  //

  @override
  String toString() => this.message();
}

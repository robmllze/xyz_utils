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

typedef FTranslate = String Function(String input, Map<dynamic, dynamic> args);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Rec {
  //
  //
  //

  final String? code;
  final Symbol? group;
  final RecOptions options;

  //
  //
  //

  const Rec([
    this.code = "",
    this.group,
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
              ? "${this.code}/$code"
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

  void debugLog([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLog(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  void debugLogAlert([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogAlert(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  void debugLogError([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogError(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  void debugLogIgnore([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogIgnore(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  void debugLogInfo([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogInfo(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  void debugLogMessage([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogMessage(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  void debugLogStart([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogStart(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  void debugLogStop([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogStop(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  void debugLogSuccess([
    dynamic message,
    Symbol? group,
  ]) {
    util_debug_log.debugLogSuccess(
      message ?? "???",
      group ?? this.group,
      this,
    );
  }

  //
  //
  //

  @override
  String toString() => this.code ?? "???";
}

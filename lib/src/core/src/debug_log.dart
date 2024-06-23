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

import 'ansi_styled_string.dart';
import 'callbacks.dart';
import 'rec.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// ⚪️ Logs a message to the console.
void debugLog(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '⚪️',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
  );
}

/// 🔴 Logs an error message to the console.
void debugLogError(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '🔴',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
  );
}

/// 🟠 Logs an alert message to the console.
void debugLogAlert(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '🟠',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
  );
}

/// 🟡 Logs an ignore message to the console.
void debugLogIgnore(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '🟡',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
    style: AnsiStyle.strikethrough,
  );
}

/// 🟢 Logs a success message to the console.
void debugLogSuccess(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '🟢',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
  );
}

/// 🔵 Logs a start message to the console.
void debugLogStart(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '🔵',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
  );
}

/// ⚫ Logs a stop message to the console.
void debugLogStop(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '⚫',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
  );
}

/// 🟣 Logs an info message to the console.
void debugLogInfo(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '🟣',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
  );
}

/// 🟤 Logs a debug message to the console.
void debugLogMessage(
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) {
  _debugLog(
    message: message,
    icon: '🟤',
    group: group,
    rec: rec,
    color: AnsiStyle.fgLightBlack,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A container for debug logs.
abstract final class DebugLog {
  /// A whitelist of groups to log.
  static final whitelist = {#debug};

  /// A list of logs.
  static final log = <String>[];

  /// A callback that is called when a log is added.
  static final callbacks = Callbacks<String, TCallback<String>>();

  /// Whether to only log in debug mode.
  static var debugOnly = true;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void _debugLog({
  required String icon,
  dynamic message,
  Symbol? group,
  Set<Symbol> whitelist = const {#debug},
  Rec? rec,
  AnsiStyle? color,
  AnsiStyle? style,
}) {
  bool log() {
    final groups = {...DebugLog.whitelist, ...whitelist};
    if (group == null || groups.contains(group)) {
      final colorPath = color != null ? AnsiStyle.italic + color : null;
      final colorTitle = color != null ? AnsiStyle.bold + color : null;
      final path =
          (rec?.code != null ? '${rec!.code}' : '').withAnsiStyle(colorPath);
      final title =
          '['.withAnsiStyle(colorTitle) + path + ']'.withAnsiStyle(colorTitle);
      final m = message.toString();
      final mStyled = m.withAnsiStyle(style);
      final resultUnstyled = '$icon $m';
      final resultStyled = '$icon $title $mStyled';
      print(resultStyled);
      DebugLog.callbacks.callAll(resultUnstyled);
    }
    return true;
  }

  if (DebugLog.debugOnly) {
    assert(log());
  } else {
    log();
  }
}

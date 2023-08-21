// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'ansi_styled_string.dart';
import 'rec.dart';
import 'callbacks.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class DebugLog {
  static final Set<Symbol> whitelist = {#debug};
  static final log = <String>[];
  static final callbacks = Callbacks<String, TCallback<String>>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void _debugLog({
  required String icon,
  Object? message,
  Symbol group = #debug,
  Set<Symbol> whitelist = const {#debug},
  Rec? rec,
  AnsiStyle? color,
  AnsiStyle? style,
}) {
  assert(
    () {
      final groups = {...DebugLog.whitelist, ...whitelist};
      if (groups.contains(group)) {
        final colorPath = color != null ? AnsiStyle.italic + color : null;
        final colorTitle = color != null ? AnsiStyle.bold + color : null;
        final path = (rec?.code != null ? "${rec!.code}" : "").withAnsiStyle(colorPath);
        final title = "[".withAnsiStyle(colorTitle) + path + "]".withAnsiStyle(colorTitle);
        final m = message.toString();
        final mStyled = m.withAnsiStyle(style);
        final resultUnstyled = "$icon $m";
        final resultStyled = "$icon $title $mStyled";
        // ignore: avoid_print
        print(resultStyled);
        DebugLog.callbacks.callAll(resultUnstyled);
      }
      return true;
    }(),
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void debugLog(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "⚪️",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogError(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "🔴",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogAlert(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "🟠",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogIgnore(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "🟡",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
      style: AnsiStyle.strikethrough,
    );

void debugLogSuccess(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "🟢",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogStart(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "🔵",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogStop(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "⚫",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogInfo(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "🟣",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogMessage(
  Object? message, [
  Symbol group = #debug,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "🟤",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

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

import '/src/shared/web_friendly/_all_web_friendly.g.dart';
import '/src/web_friendly/_all_web_friendly.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class DebugLog {
  static final Set<Symbol> whitelist = {#debug};
  static final log = <String>[];
  static final callbacks = Callbacks<String, TCallback<String>>();
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
  assert(
    () {
      final groups = {...DebugLog.whitelist, ...whitelist};
      if (group == null || groups.contains(group)) {
        final colorPath = color != null ? AnsiStyle.italic + color : null;
        final colorTitle = color != null ? AnsiStyle.bold + color : null;
        final path =
            (rec?.code != null ? "${rec!.code}" : "").withAnsiStyle(colorPath);
        final title = "[".withAnsiStyle(colorTitle) +
            path +
            "]".withAnsiStyle(colorTitle);
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
  dynamic message, [
  Symbol? group,
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
  dynamic message, [
  Symbol? group,
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
  dynamic message, [
  Symbol? group,
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
  dynamic message, [
  Symbol? group,
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
  dynamic message, [
  Symbol? group,
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
  dynamic message, [
  Symbol? group,
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
  dynamic message, [
  Symbol? group,
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
  dynamic message, [
  Symbol? group,
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
  dynamic message, [
  Symbol? group,
  Rec? rec,
]) =>
    _debugLog(
      message: message,
      icon: "🟤",
      group: group,
      rec: rec,
      color: AnsiStyle.fgLightBlack,
    );

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'ansi_styled_string.dart';
import 'rec.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

final xyzDebugLog = <String>[];

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void _debugLog({
  required String icon,
  required Object? message,
  required AnsiStyle color,
  required Rec? note,
  AnsiStyle? style,
}) {
  assert(
    () {
      final s0 = AnsiStyle.italic + color;
      final s1 = AnsiStyle.bold + color;
      final path = (note?.code != null ? "/${note!.code}" : "").withAnsiStyle(s0);
      final title = "[Xyz Engine".withAnsiStyle(s1) + path + "]".withAnsiStyle(s1);
      final m = message.toString();
      final mStyled = m.withAnsiStyle(style);
      final resultUnstyled = "$icon $m";
      final resultStyled = "$icon $title $mStyled";
      // ignore: avoid_print
      print(resultStyled);
      xyzDebugLog.add(resultUnstyled);
      return true;
    }(),
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void debugLog(
  Object? message, [
  Rec? note,
]) =>
    _debugLog(
      message: message,
      icon: "⚪️",
      note: note,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogError(
  Object? message, [
  Rec? note,
]) =>
    _debugLog(
      message: message,
      icon: "🔴",
      note: note,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogAlert(
  Object? message, [
  Rec? note,
]) =>
    _debugLog(
      message: message,
      icon: "🟠",
      note: note,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogIgnore(
  Object? message, [
  Rec? note,
]) =>
    _debugLog(
      message: message,
      icon: "🟡",
      note: note,
      color: AnsiStyle.fgLightBlack,
      style: AnsiStyle.strikethrough,
    );

void debugLogSuccess(
  Object? message, [
  Rec? note,
]) =>
    _debugLog(
      message: message,
      icon: "🟢",
      note: note,
      color: AnsiStyle.fgLightBlack,
    );

void debugLogBegin(
  Object? message, [
  Rec? note,
]) =>
    _debugLog(
      message: message,
      icon: "🔵",
      note: note,
      color: AnsiStyle.fgLightBlack,
    );

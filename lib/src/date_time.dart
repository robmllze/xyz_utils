// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:intl/intl.dart';

import 'duration_formatted.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension IntlDateTime on DateTime {
  /// e.g. 4:52 PM
  String jm(String locale) => DateFormat.jm(locale).format(this);

  /// e.g. 11/13/2022
  String yMd(String locale) => DateFormat.yMd(locale).format(this);

  /// e.g. 16:52
  String Hm(String locale) => DateFormat.Hm(locale).format(this);

  /// e.g. 13 November 2022
  String dMMMMy(String locale) => DateFormat("d MMMM y", locale).format(this);

  /// Returns a formatted DateTime string as per the [pattern]. Write a
  /// [pattern] from the following skeleton set:
  ///
  /// Symbol|Meaning|Presentation|Example
  /// :---:|---:|:---:|:---:
  /// G|era designator|(Text)|AD
  /// y|year|(Number)|1996
  /// M|month in year|(Text & Number)|July & 07
  /// L|standalone month|(Text & Number)|July & 07
  /// d|day in month|(Number)|10
  /// c|standalone day|(Number)|10
  /// h|hour in am/pm (1~12)|(Number)|12
  /// H|hour in day (0~23)|(Number)|0
  /// m|minute in hour| (Number)|30
  /// s|second in minute|(Number)|55
  /// S|fractional second|(Number)|978
  /// E|day of week|(Text)|Tuesday
  /// D|day in year|(Number)|189
  /// a|am/pm marker|(Text)|PM
  /// k|hour in day (1~24)|(Number)|24
  /// K|hour in am/pm (0~11)|(Number)|0
  /// Q|quarter|(Text)|Q3
  /// '|escape for text|(Delimiter)|'Date='
  /// ''|single quote|(Literal)|'o''clock'
  ///
  /// For more info, see: https://api.flutter.dev/flutter/intl/DateFormat-class.html
  String format(String pattern, String locale) => DateFormat(pattern, locale).format(this);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String dayAgo(DateTime date, String Function(String) tr, String locale) {
  final delta = DateTime.now().difference(date);
  const K = "time_ago";
  if (delta.inDays == 1) {
    return tr("$K.yesterday");
  }
  return date.dMMMMy(locale);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String timeAgo(DateTime date, String Function(String) tr, String locale) {
  final delta = DateTime.now().difference(date);
  final a = DurationFormatted(delta.inMicroseconds);
  const K = "time_ago";
  if (delta.inDays == 1) {
    return tr("$K.yesterday");
  }
  if (delta.inDays > 3) {
    return dayAgo(date, tr, locale);
  }
  if (delta.inDays > 1) {
    return "${a.d}${tr("$K.d")}";
  }
  if (delta.inHours > 1) {
    return "${a.h}${tr("$K.h")}";
  }
  if (delta.inMinutes > 1) {
    return "${a.m}${tr("$K.m")}";
  }
  if (delta.inSeconds > 30) {
    return "${a.s}${tr("$K.s")}";
  }
  return tr("$K.now");
}

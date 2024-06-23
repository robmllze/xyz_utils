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

import 'package:intl/intl.dart';

import 'duration_formatted_english.dart';

// External.
import '../../collections/src/etc.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension UtilsOnDateTimeExtension on DateTime {
  /// e.g. 4:52 PM
  String fjm(String locale) => DateFormat.jm(locale).format(this);

  /// e.g. 11/13/2022
  String fyMd(String locale) => DateFormat.yMd(locale).format(this);

  /// e.g. 16:52
  String fHm(String locale) => DateFormat.Hm(locale).format(this);

  /// e.g. 13 November 2022
  String fdMMMMy(String locale) => DateFormat('d MMMM y', locale).format(this);

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

  /// e.g. August 8, 2023
  String full([String? localeCode]) {
    return DateFormat('MMMM d, y', localeCode).format(this);
  }

  /// e.g. Aug-8 23
  String fullShort([String? localeCode]) {
    return DateFormat('MMM/d/yyyy', localeCode).format(this);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns a string representing the day ago from the given date. Requires a
/// translation function [tr] to translate the string into the given [locale].
String dayAgo(DateTime date, String Function(String) tr, String locale) {
  final delta = DateTime.now().difference(date);
  const K = 'time_ago';
  if (delta.inDays == 1) {
    return tr('$K.yesterday');
  }
  return DateFormat('MMMM d, y', locale).format(date);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns a string representing the time ago from the given date. Requires a
/// translation function [tr] to translate the string into the given [locale].
String timeAgo(DateTime date, String Function(String) tr, String locale) {
  final delta = DateTime.now().difference(date);
  final a = DurationFormattedEnglish(delta.inMicroseconds);
  const K = 'time_ago';
  if (delta.inDays == 1) {
    return tr('$K.yesterday');
  }
  if (delta.inDays > 3) {
    return dayAgo(date, tr, locale);
  }
  if (delta.inDays > 1) {
    return '${a.d}${tr('$K.d')}';
  }
  if (delta.inHours > 1) {
    return '${a.h}${tr('$K.h')}';
  }
  if (delta.inMinutes > 1) {
    return '${a.m}${tr('$K.m')}';
  }
  if (delta.inSeconds > 30) {
    return '${a.s}${tr('$K.s')}';
  }
  return tr('$K.now');
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Checks if two dates are on the same day.
bool isSameDay(DateTime date1, DateTime date2) {
  final a = date1.toUtc();
  final b = date2.toUtc();
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Checks if two dates are on the same week.
bool isSameWeek(DateTime date1, DateTime date2) {
  final a = date1.toUtc();
  final b = date2.toUtc();
  final week1 =
      DateTime.utc(a.year, a.month, a.day).difference(DateTime.utc(a.year, a.month)).inDays ~/ 7;
  final week2 =
      DateTime.utc(b.year, b.month, b.day).difference(DateTime.utc(b.year, b.month)).inDays ~/ 7;
  return week1 == week2;
}

/// Checks if two dates are on the same month.
bool isSameMonth(DateTime date1, DateTime date2) {
  final a = date1.toUtc();
  final b = date2.toUtc();
  return a.year == b.year && a.month == b.month;
}

/// Checks if two dates are on the same year.
List<DateTime> sortDates(List<DateTime> dates) {
  final copy = List<DateTime>.from(dates);
  return copy..sort((a, b) => a.compareTo(b));
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns the last date in the list of dates.
DateTime? getLastDate(Iterable<DateTime>? dates) =>
    dates?.tryReduce((a, b) => a.isAfter(b) ? a : b);

/// Returns the first date in the list of dates.
///
DateTime? getFirstDate(Iterable<DateTime>? dates) =>
    dates?.tryReduce((a, b) => a.isBefore(b) ? a : b);

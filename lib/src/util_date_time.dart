// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'util_duration_formatted.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension FormatNice on DateTime {
  String formatNiceDateOnly(String Function(String) tr) {
    return "${this.day} ${tr("month.${monthIndexToCode(this.month)}")} ${this.year}";
  }

  String formatNiceTimeOnly() {
    return "${formatNiceHourAndMinuteOnly()}:${"${this.second}".padLeft(2, "0")}s";
  }

  String formatNiceHourAndMinuteOnly() {
    return "${"${this.hour}".padLeft(2, "0")}:${"${this.minute}".padLeft(2, "0")}";
  }

  String formatNice(String Function(String) tr) =>
      "${this.formatNiceDateOnly(tr)} - ${this.formatNiceHourAndMinuteOnly()}";
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String monthIndexToCode(final int? i) {
  switch (i) {
    case 1:
      return "jan";
    case 2:
      return "feb";
    case 3:
      return "mar";
    case 4:
      return "apr";
    case 5:
      return "may";
    case 6:
      return "jun";
    case 7:
      return "jul";
    case 8:
      return "aug";
    case 9:
      return "sep";
    case 10:
      return "oct";
    case 11:
      return "nov";
    case 12:
      return "dec";
    default:
      return "";
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String dayAgo(DateTime date, String Function(String) tr) {
  final delta = DateTime.now().difference(date);
  const K = "time_ago";
  if (delta.inDays == 1) {
    return tr("$K.yesterday");
  }
  return date.formatNiceDateOnly(tr);
}

String timeAgo(DateTime date, String Function(String) tr) {
  final delta = DateTime.now().difference(date);
  final a = DurationFormatted(delta.inMicroseconds);
  const K = "time_ago";
  if (delta.inDays == 1) {
    return tr("$K.yesterday");
  }
  if (delta.inDays > 3) {
    return date.formatNiceDateOnly(tr);
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

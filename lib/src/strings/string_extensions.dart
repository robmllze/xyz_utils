// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '../data/data.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension XyzUtilsStringExtensions on String {
  //
  //
  //

  String toSnakeCase() {
    final expression = RegExp(r"(?<=[a-z])[A-Z0-9]");
    final result = this.replaceAllMapped(expression, (final l) {
      return ("_${l.group(0)}");
    }).toLowerCase();
    return result;
  }

  //
  //
  //

  String toCamelCase() {
    final expression = RegExp(r"([_])[a-zA-Z0-9]");
    final result = this.replaceAllMapped(expression, (final l) {
      return "${l.group(0)?[1].toUpperCase()}";
    });
    return result;
  }

  //
  //
  //

  String capitalize() {
    if (this.isEmpty) return this;
    var result = this[0].toUpperCase();
    if (this.length > 1) result += this.substring(1);
    return result;
  }

  //
  //
  //

  String toClassCase() {
    return this.toCamelCase().capitalize();
  }

  //
  //
  //

  String lineToLength(int length) {
    return (this.length > length ? "${this.substring(0, length).trim()}..." : this);
  }

  //
  //
  //

  String paragraphToLength(int length) {
    return this.lineToLength(length).replaceAll("\n", " ");
  }

  //
  //
  //

  Uri? toUri() => Uri.tryParse(this);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ToTrimmedStringOrNull on dynamic {
  String? toTrimmedStringOrNull() {
    return this?.toString().trim().nullIfEmpty;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension JoinWithLastSeparator on Iterable {
  String joinWithLastSeparator({String separator = ", ", String lastSeparator = " & "}) {
    if (this.isEmpty) {
      return "";
    }
    if (this.length == 1) {
      return this.first;
    }
    if (this.length == 2) {
      return this.toList().join(lastSeparator);
    }

    final list = this.toList();
    final lastTwo = list.sublist(list.length - 2).join(lastSeparator);
    final allButLastTwo = list.sublist(0, list.length - 2).join(separator);
    return "$allButLastTwo$separator$lastTwo";
  }
}

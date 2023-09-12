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
    final expression = RegExp(r"(?<=\B|[a-z])[A-Z0-9]");
    final result = this.replaceAllMapped(expression, (e) {
      return "_${e.group(0)}";
    }).toLowerCase();
    return result;
  }

  //
  //
  //

  String toCamelCase() {
    if (this.isEmpty) return "";
    final expression = RegExp(r"_([a-z0-9])");
    final result = this[0].toLowerCase() +
        this.substring(1).replaceAllMapped(
              expression,
              (e) => e.group(1)!.toUpperCase(),
            );
    return result;
  }

  //
  //
  //

  String toPascalCase() {
    return this.toCamelCase().capitalize();
  }

  //
  //
  //

  String capitalize() {
    if (this.isEmpty) return this;

    for (var n = 0; n < this.length; n++) {
      final char = this[n];
      if (char.toUpperCase() != char) {
        return this.substring(0, n) + char.toUpperCase() + this.substring(n + 1);
      }
    }
    return this;
  }

  //
  //
  //

  String decapitalize() {
    if (this.isEmpty) return this;

    for (var n = 0; n < this.length; n++) {
      final char = this[n];
      if (char.toLowerCase() != char) {
        return this.substring(0, n) + char.toLowerCase() + this.substring(n + 1);
      }
    }
    return this;
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
    final list = this.toList();
    if (this.length == 2) {
      return list.join(lastSeparator);
    }

    final lastTwo = list.sublist(list.length - 2).join(lastSeparator);
    final allButLastTwo = list.sublist(0, list.length - 2).join(separator);
    return "$allButLastTwo$separator$lastTwo";
  }
}

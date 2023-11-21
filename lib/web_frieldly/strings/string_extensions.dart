//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

// ignore_for_file: camel_case_extensions

import '../data/data.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension XyzUtilsStringExtensions on String {
  //
  //
  //

  String toSnakeCase() {
    if (this.isEmpty) return this;
    final result = StringBuffer(this[0]);
    for (var i = 1; i < this.length; i++) {
      if ((this[i - 1].isLowerCase && this[i].isUpperCase) ||
          (this[i - 1].isDigit && this[i].isLetter) ||
          (this[i - 1].isLetter && this[i].isDigit) ||
          (this[i - 1].isUpperCase &&
              this[i].isUpperCase &&
              (i + 1 < this.length && this[i + 1].isLowerCase))) {
        result.write("_");
      }
      result.write(this[i]);
    }
    return result.toString().toLowerCase();
  }

  //
  //
  //

  bool get isDigit => "0".compareTo(this) <= 0 && "9".compareTo(this) >= 0;
  bool get isUpperCase => this == this.toUpperCase() && this != this.toLowerCase();
  bool get isLowerCase => this == this.toLowerCase() && this != this.toUpperCase();
  bool get isLetter => this.toLowerCase() != this.toUpperCase();

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
    if (this.length == 1) return this.toUpperCase();
    return this[0].toUpperCase() + this.substring(1);
  }

  //
  //
  //

  String capitalizeWords() {
    return this
        .trim()
        .split(RegExp(r"[- ]+"))
        .map((final e) => e.trim().toLowerCase().capitalize())
        .join(" ");
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

extension ToTrimmedOrNull on Object {
  String? toTrimmedOrNull() {
    return trimmedOrNull(this);
  }
}

String? trimmedOrNull(Object? input) {
  return input?.toString().trim().nullIfEmpty;
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

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension String_replaceLast on String {
  String replaceLast(Pattern from, String to, [int startIndex = 0]) {
    final match = from.allMatches(this, startIndex).lastOrNull;
    if (match == null) return this;
    final lastIndex = match.start;
    final beforeLast = this.substring(0, lastIndex);
    final group0 = match.group(0);
    if (group0 == null) return this;
    final afterLast = this.substring(lastIndex + group0.length);
    return beforeLast + to + afterLast;
  }
}

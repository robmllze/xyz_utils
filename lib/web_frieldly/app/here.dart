//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import '../any_platform/any_platform.dart';
import '../data/data.dart';
import '../paths/paths.dart';
import 'rec.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Here {
  //
  //
  //

  final String? file;
  final String? scope;
  final int? lineNumber;
  final int? columnNumber;
  final Symbol? group;

  //
  //
  //

  const Here._(
    this.file,
    this.scope,
    this.lineNumber,
    this.columnNumber,
    this.group,
  );

  //
  //
  //

  String? get fileName {
    if (this.file != null) {
      final uri = Uri.tryParse(this.file!);
      if (uri != null && uri.pathSegments.isNotEmpty) {
        final last = uri.pathSegments.last;
        return "$last.dart";
      }
    }
    return null;
  }

  //Symbol? get _defaultGroup => this.group ?? (this.scope != null ? Symbol("#${this.scope}") : null);

  //
  //
  //

  factory Here([Symbol? group]) {
    final parts = AnyPlatform.instance.isWeb ? hereWeb(2) : here(2);
    return Here._(
      parts?[0],
      parts?[1],
      parts?[2],
      parts?[3],
      group,
    );
  }

  //
  //
  //

  Rec get _rec => Rec(this.scope, this.group);

  //
  //
  //

  void debugLog(e) => this._rec.debugLog(e);
  void debugLogAlert(e) => this._rec.debugLogAlert(e);
  void debugLogError(e) => this._rec.debugLogError(e);
  void debugLogIgnore(e) => this._rec.debugLogIgnore(e);
  void debugLogInfo(e) => this._rec.debugLogInfo(e);
  void debugLogMessage(e) => this._rec.debugLogMessage(e);
  void debugLogStart(e) => this._rec.debugLogStart(e);
  void debugLogStop(e) => this._rec.debugLogStop(e);
  void debugLogSuccess(e) => this._rec.debugLogSuccess(e);

  //
  //
  //

  @override
  String toString() {
    return "File: $file, Scope: $scope, Line: $lineNumber, Column: $columnNumber";
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

List<dynamic>? here([int start = 1]) {
  final results = <dynamic>[null, null, null, null];
  final stackTrace = StackTrace.current.toString().split("\n");
  for (var i = start; i < stackTrace.length; i++) {
    final line = stackTrace[i];
    final [a, b] = line.split(" (");
    final scope = a.split(RegExp(r"#\d+"))[1].trim();
    if (scope.contains("<anonymous closure>")) continue;
    final locationParts = b.substring(0, b.length - 1).split(":");
    final filePath = locationParts
        .tryFirstWhere((e) => e.contains(".dart"))
        ?.replaceAll(".dart", "")
        .replaceAll(".js", "");
    ;
    final file = filePath != null ? getBaseName(filePath) : null;
    int? lineNumber;
    int? columnNumber;
    for (final c in locationParts) {
      if (lineNumber == null) {
        if (c.contains(RegExp(r"\d+"))) {
          lineNumber = int.tryParse(c);
        }
      } else if (columnNumber == null) {
        if (c.contains(RegExp(r"\d+"))) {
          columnNumber = int.tryParse(c);
        }
      }
    }
    if (filePath != null && lineNumber != null && columnNumber != null) {
      results[0] = file;
      results[1] = scope;
      results[2] = lineNumber;
      results[3] = columnNumber;
      return results;
    }
  }
  return results;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

List<dynamic>? hereWeb([int start = 1]) {
  final stackTrace = StackTrace.current.toString().split("\n");

  for (var i = start + 1; i < stackTrace.length; i++) {
    final line = stackTrace[i];
    final parts = line.split(" ").where((e) => e.isNotEmpty).toList();

    final skipParts = <int>[];

    final filePath = () {
      for (var p = 0; p < parts.length; p++) {
        final part = parts[p];
        if (part.startsWith("packages") && part.contains(".dart")) {
          final a = part
              .replaceAll(RegExp("(packages)[\\/]"), "")
              .replaceAll(".dart", "")
              .replaceAll(".js", "");
          skipParts.add(p);
          return a;
        }
      }
    }();

    if (filePath == null) continue;

    int? lineNumber;
    int? columnNumber;
    for (var p = 0; p < parts.length; p++) {
      final pp = parts[p].split(":");
      if (pp.length == 2) {
        lineNumber = int.tryParse(pp[0]);
        columnNumber = int.tryParse(pp[1]);
        if (lineNumber != null && columnNumber != null) {
          skipParts.add(p);
          break;
        } else {
          lineNumber = null;
          columnNumber = null;
        }
      }
    }

    String? scope;
    for (var p = 0; p < parts.length; p++) {
      if (skipParts.contains(p)) continue;
      scope = parts[p];
    }

    if (scope == "new") scope = "<new>";
    final isAnonymous = parts.contains("<fn>");
    if (isAnonymous) continue;

    return [filePath, scope, null, null];
  }

  return [null, null, null, null];
}

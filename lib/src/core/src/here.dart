//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'rec.dart';

// External.
import '/src/core/src/paths.dart';
import '/src_any_platform/_any_platform_io.dart';
import '/src/collections/src/first_where_or_null.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A method to log a message to the console with the file, scope, line and
/// column number passed in as context.
class Here {
  //
  //
  //

  /// The file path of the file where the Here instance was created.
  final String? filePath;

  /// The scope where the Here instance was created.
  final String? scope;

  /// The line number where the Here instance was created.
  final int? lineNumber;

  /// The column number where the Here instance was created.
  final int? columnNumber;

  /// The group of the Here instance.
  final Symbol? group;

  //
  //
  //

  const Here._(
    this.filePath,
    this.scope,
    this.lineNumber,
    this.columnNumber,
    this.group,
  );

  //
  //
  //

  /// The file name of the file where the Here instance was created.
  String? get fileName {
    if (this.filePath != null) {
      final uri = Uri.tryParse(this.filePath!);
      if (uri != null && uri.pathSegments.isNotEmpty) {
        final last = uri.pathSegments.last;
        return '$last.dart';
      }
    }
    return null;
  }

  //Symbol? get _defaultGroup => this.group ?? (this.scope != null ? Symbol('#${this.scope}') : null);

  //
  //
  //

  factory Here([Symbol? group]) {
    final parts = AnyPlatform.instance.isWeb ? _hereWeb(2) : _here(2);
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

  /// ⚪️ Logs a message to the console.
  void debugLog(e) => this._rec.debugLog(e);

  /// 🔴 Logs an error message to the console.
  void debugLogError(e) => this._rec.debugLogError(e);

  /// 🟠 Logs an alert message to the console.
  void debugLogAlert(e) => this._rec.debugLogAlert(e);

  /// 🟡 Logs an ignore message to the console.
  void debugLogIgnore(e) => this._rec.debugLogIgnore(e);

  /// 🟢 Logs a success message to the console.
  void debugLogSuccess(e) => this._rec.debugLogSuccess(e);

  /// 🟣 Logs an info message to the console.
  void debugLogInfo(e) => this._rec.debugLogInfo(e);

  /// 🟤 Logs a debug message to the console.
  void debugLogMessage(e) => this._rec.debugLogMessage(e);

  /// 🔵 Logs a start message to the console.
  void debugLogStart(e) => this._rec.debugLogStart(e);

  /// ⚫ Logs a stop message to the console.
  void debugLogStop(e) => this._rec.debugLogStop(e);

  //
  //
  //

  @override
  String toString() {
    return [
      'File Path: $filePath',
      'Scope: $scope',
      'Line: $lineNumber',
      'Column: $columnNumber',
    ].join(', ');
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

List<dynamic>? _here([int start = 1]) {
  final results = <dynamic>[null, null, null, null];
  final stackTrace = StackTrace.current.toString().split('\n');
  for (var i = start; i < stackTrace.length; i++) {
    final line = stackTrace[i];
    final [a, b] = line.split(' (');
    final scope = a.split(RegExp(r'#\d+'))[1].trim();
    if (scope.contains('<anonymous closure>')) continue;
    final locationParts = b.substring(0, b.length - 1).split(':');
    final filePath = locationParts
        .firstWhereOrNull((e) => e.contains('.dart'))
        ?.replaceAll('.dart', '')
        .replaceAll('.js', '');
    final file = filePath != null ? getBaseName(filePath) : null;
    int? lineNumber;
    int? columnNumber;
    for (final c in locationParts) {
      if (lineNumber == null) {
        if (c.contains(RegExp(r'\d+'))) {
          lineNumber = int.tryParse(c);
        }
      } else if (columnNumber == null) {
        if (c.contains(RegExp(r'\d+'))) {
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

List<dynamic>? _hereWeb([int start = 1]) {
  final stackTrace = StackTrace.current.toString().split('\n');
  for (var i = start + 1; i < stackTrace.length; i++) {
    final line = stackTrace[i];
    final parts = line.split(' ').where((e) => e.isNotEmpty).toList();
    final skipParts = <int>[];
    final filePath = () {
      for (var p = 0; p < parts.length; p++) {
        final part = parts[p];
        if (part.startsWith('packages') && part.contains('.dart')) {
          final a = part
              .replaceAll(RegExp('(packages)[\\/]'), '')
              .replaceAll('.dart', '')
              .replaceAll('.js', '');
          skipParts.add(p);
          return a;
        }
      }
    }();
    if (filePath == null) continue;
    int? lineNumber;
    int? columnNumber;
    for (var p = 0; p < parts.length; p++) {
      final pp = parts[p].split(':');
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
    if (scope == 'new') scope = '<new>';
    final isAnonymous = parts.contains('<fn>');
    if (isAnonymous) continue;
    return [filePath, scope, null, null];
  }
  return [null, null, null, null];
}

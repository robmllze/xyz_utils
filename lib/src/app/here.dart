// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'rec.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Here {
  //
  //
  //

  final String? filePath;
  final String? className;
  final String? methodName;
  final String? lineNumber;
  final Symbol? group;

  //
  //
  //

  const Here._(
    this.filePath,
    this.className,
    this.methodName,
    this.lineNumber,
    this.group,
  );

  //
  //
  //

  String? get fileName {
    if (this.filePath != null) {
      final uri = Uri.tryParse(this.filePath!);
      if (uri != null && uri.pathSegments.isNotEmpty) {
        final last = uri.pathSegments.last;
        return last;
      }
    }
    return null;
  }

  Symbol? get _defaultGroup =>
      this.group ?? (this.className != null ? Symbol("#${this.className}") : null);

  //
  //
  //

  factory Here([Symbol? group]) {
    // Capture the current stack trace.
    final stackTrace = StackTrace.current;
    // Split the stack trace string by line for easier processing.
    final stackTraceLines = stackTrace.toString().split("\n");

    // Start iterating from the 2nd line of the stack trace to skip the current function.
    for (var i = 1; i < stackTraceLines.length; i++) {
      final e = stackTraceLines[i];
      // Use a regular expression to extract details from the stack trace line.
      final match = RegExp(r"#\d+\s+([^\s]+) \(([^\s]+):(\d+):(\d+)\)").firstMatch(e);
      if (match != null) {
        final fileName = match.group(2);

        // Filter out non-project stack trace lines (e.g., those from Dart SDK)
        if (fileName != null &&
            !fileName.startsWith("dart:") &&
            !fileName.startsWith("package:flutter")) {
          final fullMethodName = match.group(1);
          // Split the full method name into class and method parts.
          final parts = fullMethodName?.split('.');
          String? className;
          String? methodName;

          if (parts != null) {
            if (parts.length == 1) {
              // This means it's a standalone function.
              methodName = parts[0];
            } else if (parts.length > 1) {
              // This means it's a class method.
              className = parts[0];
              methodName = parts[1];
            }
          }

          // Check if the captured method or function is not an anonymous closure.
          if (methodName != null && methodName != "<anonymous closure>") {
            // Extract the line number.
            final lineNumber = match.group(3);
            // Return the captured details as an instance of CallDetails.
            return Here._(
              fileName,
              className,
              methodName,
              lineNumber,
              group,
            );
          }
        }
      }
    }
    // If no suitable caller details are found, return an instance of CallDetails with null values.
    return Here._(
      null,
      null,
      null,
      null,
      group,
    );
  }

  //
  //
  //

  Rec get _rec {
    final rec = Rec(
      this.fileName,
      this._defaultGroup ?? #debug,
    )(
      this.className,
    )(
      this.methodName,
    )(
      this.lineNumber,
    );
    print(rec.group);
    return rec;
  }

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
    return "File: $filePath, Class: $className, Method: $methodName, Line: $lineNumber";
  }
}

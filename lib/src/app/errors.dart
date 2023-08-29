// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

class _XyzError {
  final XyzErrorType type;
  final dynamic e;
  const _XyzError(this.e, this.type);
  @override
  String toString() {
    return e.toString();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ProgrammerError extends _XyzError {
  const ProgrammerError(dynamic e)
      : super(
          "Programmer error: $e",
          XyzErrorType.PROGRAMMER_ERROR,
        );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum XyzErrorType {
  PROGRAMMER_ERROR,
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MultiException implements Exception {
  final String scope;
  final _exceptions = List.empty(growable: true);
  List get exceptions => List.from(this._exceptions);
  MultiException(this.scope);
  void add(e) => this._exceptions.add(e);
  void remove(e) => this._exceptions.remove(e);
  void get throwIf {
    if (this._exceptions.isNotEmpty) {
      throw this;
    }
  }

  @override
  String toString() {
    return "MultiException [$scope]:\n\n${this._exceptions.join("\n")})}";
  }
}

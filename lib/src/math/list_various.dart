// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// LIST - VARIOUS
//
// Adds various methods Dart's stock List.
//
// By Robert Mollentze / @robmllze (2021).
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension List_Various<T> on List<T> {
  /// Sets value at `index` to `value`.
  void setAt(final int index, final T value) => this[index] = value;

  /// Compares all corresponding elements of this and `other` for equality.
  bool compare(final List<T> other) => this.length != other.length
      ? false
      : () {
          for (int n = 0; n < this.length; n++) if (this[n] != other[n]) return false;
          return true;
        }();

  /// Generates a new List of `length` whose factors are an `operation` of
  /// the factors of this List. If `length` is null, the length of the
  /// generated List is the length of this List.
  List<T> operate(
    final T Function(T? a, int n) operation, [
    final int? length,
  ]) {
    final List<T> _res = [];
    for (int n = 0; n < (length != null && length <= this.length ? length : this.length); n++) {
      _res.add(operation(this[n], n));
    }
    return _res;
  }

  /// Generates a new List of `length` whose factors are an `operation` of the
  /// corresponding factors of this List and `other`. If `length` is null, the
  /// length of the generated List is the length of the largest of this List
  /// and `other`.
  List<T> operate2(
    final List<T> other,
    final T Function(T? a, T? b, int n) operation, [
    final int? length,
  ]) {
    final _res = <T>[];
    late final _lenThis, _lenOther;
    if (length != null) {
      _lenThis = length <= this.length ? length : this.length;
      _lenOther = length <= other.length ? length : other.length;
    } else {
      _lenThis = this.length;
      _lenOther = other.length;
    }
    for (int n = 0;; n++) {
      final _a = n < _lenThis ? this[n] : null;
      final _b = n < _lenOther ? other[n] : null;
      if (_a == null && _b == null) break;
      _res.add(operation(_a, _b, n));
    }
    return _res;
  }

  /// Generates a new List from this one.
  ///
  /// The return values of `process` are added to the new List. Throw `false`
  /// in `process` to skip adding a return value.
  /// ```
  /// print([1, 2, 3].generate((__value) => __value * _value)); // 1, 4, 9
  ///
  /// print([1, 2, 3].generate((__value) {
  ///   if (__value != 2) return __value;
  ///   throw false;
  /// })); // 1, 3
  /// ```
  List<U> generate<U>(
    final U Function(T) process,
  ) {
    final _iterator = this.iterator;
    final _res = <U>[];
    while (_iterator.moveNext()) {
      try {
        _res.add(process(_iterator.current));
      } on bool catch (i) {
        if (i != false) rethrow;
      }
    }
    return _res;
  }

  /// Push-to-end / shift operator.
  ///
  /// 1, 2 >> 3, 4 equals 3, 4, 1, 2.
  //List operator <<(final List other) => [...this, ...other];

  /// Push-to-end / shift operator.
  ///
  /// 1, 2 << 3, 4 equals 1, 2, 3, 4
  //List operator >>(final List other) => [...other, ...this];
}

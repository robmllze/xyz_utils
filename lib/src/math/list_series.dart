// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// LIST - SERIES
//
// Adds methods regarding mathematical series to Dart's stock List.
//
// By Robert Mollentze / @robmllze (2021).
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'list_various.dart';
import 'utils.dart' show combineHashCodes;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension List_Series on List<num> {
  /// Computes the sum of the components of this Series.
  num sum() {
    num _res = 0;
    for (final component in this) _res += component;
    return _res;
  }

  /// Computes the product of the components this Series.
  num product() {
    num _res = 1;
    for (final component in this) _res *= component;
    return _res;
  }

  /// Computes the alternating "sum" of the components of this Series.
  ///
  /// e.g. (-1) + (2) + (-3) + (4) + (-5) = -3
  num altering() {
    num _res = 0;
    num _sign = -1;
    for (final component in this) {
      _res += _sign * component;
      _sign *= -1;
    }
    return _res;
  }

  /// Computes the alternating "sum" of the components of this Series.
  ///
  /// e.g. (1) + (-2) + (3) + (-4) + (5) = 3
  num altering1() {
    num _res = 0;
    num _sign = 1;
    for (final component in this) {
      _res += _sign * component;
      _sign *= -1;
    }
    return _res;
  }

  /// Computes the "fractile" of the Series at `i` where `i` is between 0 and 1
  /// exclusive. Set `asSmallToLarge` to true or false to sort components from
  /// small-to-large or large-to-small respectively.
  num fractile(
    final num i, [
    final bool asSmallToLarge = true,
  ]) {
    assert(i >= 0 && i <= 1);
    assert(this.isNotEmpty);
    final _last = this.length - 1;
    if (_last == 0) return this[0];
    final m = i * _last;
    final n = m.truncate();
    final _extent = m - n;
    final _sorted = asSmallToLarge ? this.asSmallToLarge() : this.asLargeToSmall();
    final _a = _sorted[n], _b = /*n == _last ? 0 :*/ _sorted[n + 1];
    return _a + _extent * (_b - _a);
  }

  /// Computes the percentile of the Series at `i` where `i` is between 0 and
  /// 100 exclusive.
  num percentile(final num i) => [0, ...this, 100].fractile(i / 100);

  /// Computes the 1st quartile of the Series.
  num quartile1() => this.fractile(0.25);

  /// Computes the median or 2nd quartile of the Series.
  num median() => this.fractile(0.5);

  /// Computes the 3rd quartile of the Series.
  num quartile3() => this.fractile(0.75);

  /// Computes the average of the components of this Series.
  num average() => this.sum() / this.length;

  /// Finds the largest number in this Series.
  double largest() {
    var _res = double.negativeInfinity;
    for (final component in this) if (component > _res) _res = component as double;
    return _res;
  }

  /// Finds the smallest number in this Series.
  double smallest() {
    var _res = double.infinity;
    for (final component in this) if (component < _res) _res = component as double;
    return _res;
  }

  /// Generates a new Series from this Series with components sorted from
  /// smallest to largest.
  List<num> asSmallToLarge() => List<num>.of(this)..sort((a, b) => a.compareTo(b));

  /// Generates a new Series from this Series with components sorted from
  /// largest to smallest.
  List<num> asLargeToSmall() => List<num>.of(this)..sort((a, b) => b.compareTo(a));

  /// Generates a new Series from this Series with each component increased
  /// by `increment`.
  List<num> operator +(final num increment) => this.operate((a, _) => a! + increment);

  /// Generates a new Series from this Series with each component decreased
  /// by `decrement`.
  List<num> operator -(final num decrement) => this.operate((a, _) => a! - decrement);

  /// Generates a new Series from this Series with each component multiplied
  /// by `factor`.
  List<num> operator *(final num factor) => this.operate((a, _) => a! * factor);

  /// Generates a new Series from this Series with each component divided by
  /// `denominator`.
  List<num> operator /(final num denominator) => this.operate((a, _) => a! / denominator);

  /// Generates a new Series from this Series with each component negated.
  List<num> operator -() => //
      this.operate((a, _) => -a!);

  /// Generates a new Series from this Series with each component inversed.
  ///
  /// e.g. 1, 2, 3 => 1/1, 1/2, 1/3
  List<num> inverse() => this.operate((a, _) => 1 / a!);

  /// Generates a new Series of `length` whose factors are the product of the
  /// corresponding factors of this Series and `other`. If `length` is null,
  /// the length of the generated Series is the length of the largest of
  /// this Series and `other`. Any factors that do not have corresponding
  /// factors are simply added to the new Series.
  List<num> product2(
    final List<num> other, [
    final int? length,
  ]) =>
      this.operate2(other, (a, b, _) => (a ?? 1) * (b ?? 1));

  /// Generates a new Series of `length` whose factors are the quotient of the
  /// corresponding factors of this Series and `other`. If `length` is null,
  /// the length of the generated Series is the length of the largest of this
  /// Series and `other`. Any factors that do not have corresponding factors
  /// are simply added to the new Series.
  List<num> quotient2(
    final List<num> other, [
    final int? length,
  ]) =>
      this.operate2(
        other,
        (a, b, _) => a == null
            ? b!
            : b == null
                ? a
                : a / b,
      );

  /// Generates a hash code from the components of this Series. Use this
  /// instead of the stock [hashCode] to compare the components of two Series.
  int hashCode1() {
    if (this.isEmpty) return 0;
    if (this.length == 1) return this[0].hashCode;
    int _combined = this[0].hashCode;
    for (int n = 1; n < this.length; n++) _combined = combineHashCodes(_combined, this[n].hashCode);

    return _combined;
  }

  /// Checks if the components of this Series are equal to the components of
  /// the `other` Series.
  ///
  /// Note: This is not the same as using the == operator.
  bool equals(final List<num> other) {
    if (this.length != other.length) return false;
    return this.hashCode1() == other.hashCode1();
  }
}

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// VEC
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:convert';
import 'dart:math';

import 'list_series.dart';
import 'list_various.dart';
import 'misc.dart';
import 'utils.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ListToVec on List<dynamic> {
  /// Constructs an unmodifiable Vec from this List<num>.
  Vec get vec => Vec._(List<num>.unmodifiable(this));
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Vec {
  //
  //
  //

  final List<num> components;
  const Vec._(this.components);

  /// Constructs a new vector of `dimension` from copying `other` components.
  /// The amount of components copied is less or equal to `dimension`. If
  /// `dimension` is larger than the dimension of `other`, `filler` components
  /// are copied until filled to `dimension`.
  factory Vec.copy(
    final Vec other,
    final int dimension, [
    final num filler = 0,
  ]) {
    final _extra = dimension - other.dimension;
    final _a = other.components.take(dimension).toList();
    final _b = _extra > 0 ? List<num>.filled(_extra, filler) : <num>[];
    return (_a..addAll(_b)).vec;
  }

  /// Constructs a vector of `dimension` with all components set to zero.
  factory Vec.zero(final int dimension) => List<num>.filled(dimension, 0).vec;

  factory Vec.fromString(final String src) =>
      (JsonDecoder().convert(src) as List<dynamic>).cast<num>().vec;

  /// The dimension or component length.
  int get dimension => this.components.length;

  Vec operator +(final Vec other) =>
      this.components.operate2(other.components, (__a, __b, _) => (__a ?? 0) + (__b ?? 0)).vec;

  Vec operator -(final Vec other) =>
      this.components.operate2(other.components, (__a, __b, _) => (__a ?? 0) - (__b ?? 0)).vec;

  Vec operator -() => this.components.generate((__component) => -__component).vec;

  Vec operator *(final num factor) =>
      this.components.generate((__component) => __component * factor).vec;

  Vec operator /(final num divisor) =>
      this.components.generate((__component) => __component / divisor).vec;

  Vec operator ^(final num exponent) =>
      this.components.generate((__component) => pow(__component, exponent)).vec;

  @override
  bool operator ==(final Object other) {
    return this.components.hashCode1() == (other as Vec).components.hashCode1();
  }

  num operator [](final int i) => this.components[i];

  /// Computes the unit vector.
  Vec get unit {
    final List<num> _values = [];
    for (final component in this.components) _values.add(component / this.norm);
    return _values.vec;
  }

  /// Computes the norm/magnitude of this Vec.
  num get norm {
    num _radicand = 0;
    for (final component in this.components) _radicand += component * component;
    return sqrt(_radicand);
  }

  /// Computes the dot product.
  num dot(final Vec other) => this.components.product2(other.components).sum();

  /// Computes the smallest of the two angles between this and `other`.
  num theta(final Vec other) => acos(this.dot(other) / (this.norm * other.norm));

  /// Computes the largest of the two angles between this and `other`.
  num alpha(final Vec other) => 2.0 * pi - this.theta(other);

  /// Computes the cross product. If the vectors aren't of the same dimension,
  /// the minumum dimension will be used, ignoring the extra components from
  /// the higher dimensional vector.
  Vec cross(final Vec other) {
    final int _max = smallest2(
      this.components.length,
      other.components.length,
    ) as int;
    var _temp = [].vec;
    int mm = 0, nn = 0;
    for (int m = 0; m < _max; m++) {
      nn = mm;
      for (int n = 0; n < _max; n++) {
        final d = n - m;
        final _sign = d.sign;
        final i = d.abs() > 1 ? -_sign : _sign;
        if (d != 0) {
          _temp += (List<num>.filled(_max, 0.0)..setAt(nn, i)).vec *
              this.components[m] *
              other.components[n];
        }
        nn = nn.normPrev(_max);
      }
      mm = mm.normPrev(_max);
    }
    return _temp;
  }

  /// Vec of same direction but with new `norm`.
  Vec renorm(final num norm) => this.unit * norm;

  /// Vec of same direction but new norm = this.norm * `scale`.
  Vec scale(final num scale) => this.unit * this.norm * scale;

  /// Vec of same direction but with half this norm.
  Vec get half => this.scale(0.5);

  @override
  String toString() => this.components.toString();
}

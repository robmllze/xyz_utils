// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// VEC2
//
// By Robert Mollentze AKA @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:math';

import 'vec.dart';
import 'pair.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ListToVec2 on List<double> {
  /// List to Vec2.
  Vec get vec2 {
    assert(this.length >= 2);
    return this.vec;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Vec2 {
  /// Vector from norm and rotation (0 to 2pi).
  static Vec fromRot(final double norm, final double rot) => [0, norm].vec.rotated2(rot);

  // Zero vector.
  static Vec get zero => [0, 0].vec;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension Vec_Vec2 on Vec {
  //
  //
  //

  bool get is2D => this.dimension == 2;

  /// **1D**+ only.
  ///
  /// The x-component.
  num get x {
    assert(this.dimension > 0);
    return components[0];
  }

  /// **2D**+ only.
  ///
  /// The y-component.
  num get y {
    assert(this.dimension > 1);
    return components[1];
  }

  /// **2D** only.
  Pair get toPair2 {
    assert(this.is2D);
    return Pair(this.x, this.y);
  }

  /// **2D** only.
  ///
  /// Computes the norm/magnitude of this Vec.
  double get norm2 {
    assert(this.is2D);
    return sqrt(this.x * this.x + this.y * this.y);
  }

  /// **2D** only.
  ///
  /// Computes the norm/magnitude of this Vector.
  Vec get unit2 {
    assert(this.is2D);
    return this / this.norm2;
  }

  /// **2D** only.
  ///
  /// Vector perpendicular to this Vec.
  Vec get perp2 {
    assert(this.is2D);
    return [-this.y, this.x].vec;
  }

  /// **2D** only.
  ///
  /// Vec of same direction but with new `norm`.
  Vec renorm2(final double norm) {
    assert(this.is2D);
    return this.unit2 * norm;
  }

  /// **2D** only.
  ///
  /// Vec of same direction but new norm = this.norm * `scale`.
  Vec scale2(final double scale) {
    assert(this.is2D);
    return this.unit2 * this.norm2 * scale;
  }

  /// **2D** only.
  ///
  /// Vec of same direction but with half this norm.
  Vec get half2 {
    assert(this.is2D);
    return this.scale2(0.5);
  }

  /// **2D** only.
  ///
  /// Computes the dot product.
  num dot2(final Vec other2) {
    assert(this.is2D);
    return this.x * other2.x + this.y + other2.y;
  }

  /// **2D** only.
  ///
  /// Computes the cross product.
  num cross2(final Vec other2) {
    assert(this.is2D);
    return this.x * other2.y - this.y * other2.x;
  }

  /// **2D** only.
  ///
  /// Gradient of this Vec.
  num get grad2 {
    assert(this.is2D);
    return this.y / this.x;
  }

  /// **2D** only.
  ///
  /// Quadrant of this Vec. Negative values indicate Vec sits on axis. Use
  /// quad2.abs() to ignore signs.
  int get quad2 {
    assert(this.is2D);
    if (this.x == 0.0) {
      if (this.y == 0.0) return 0;
      if (this.y > 0.0) return -2;
      if (this.y < 0.0) return -4;
    }
    if (this.y == 0.0) {
      if (this.x > 0.0) return -1;
      if (this.x < 0.0) return -3;
    }
    if (this.x > 0.0) {
      if (this.y > 0.0) return 1;
      return 4;
    }
    if (this.y > 0.0) return 2;
    return 3;
  }

  /// **2D** only.
  ///
  /// Vec rotated by `rotation` radians.
  Vec rotated2(final double rotation) {
    assert(this.is2D);
    final c = cos(rotation);
    final s = sin(rotation);
    return [
      this.x * c - this.y * s,
      this.x * s + this.y * c,
    ].vec;
  }

  /// **2D** only.
  ///
  /// Computes the full rotation of this Vec (0 to 2*pi).
  num get rotation2 {
    assert(this.is2D);
    // No Q.
    if (this.x == 0.0) {
      return this.y > 0.0
          ? 0.5 * pi
          : this.y != 0.0
              ? 1.5 * pi
              : 0.0;
    }
    if (this.y == 0) return (this.x >= 0) ? 0.0 : pi;
    final _r = atan(this.y / this.x);
    if (this.x > 0.0) {
      // Q1.
      if (this.y > 0.0) return _r;
      // Q4.
      if (this.y < 0.0) return 2.0 * pi + _r;
    }
    // Q3.
    if (this.y < 0.0) return pi + _r;
    // Q2.
    return pi + _r;
  }

  /// **2D** only.
  ///
  /// Computes the difference between the full [rotation2] of this Vec and
  /// `other2`.
  num angle2(final Vec other2) {
    assert(this.is2D);
    return (this.rotation2 - other2.rotation2).abs();
  }

  /// **2D** only.
  ///
  /// Computes the smallest of the two [angle2] between this Vec and `other2`.
  num theta2(final Vec other2) {
    assert(this.is2D);
    final _t0 = this.angle2(other2);
    final _t1 = 2.0 * pi - _t0;
    return _t0 < _t1 ? _t0 : _t1;
  }

  /// **2D** only.
  ///
  /// Computes the largest of the two [angle2] between this Vec and `other2`.
  num alpha2(final Vec other2) {
    assert(this.is2D);
    final _t0 = this.angle2(other2);
    final _t1 = 2.0 * pi - _t0;
    return _t0 > _t1 ? _t0 : _t1;
  }
}

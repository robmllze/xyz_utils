// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// VEC2
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

library math_ex;

import 'dart:math';

import 'pair.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Vec2 extends Pair {
  //
  //
  //

  //ignore:always_declare_return_types
  get x => super.t0;

  //ignore:always_declare_return_types
  get y => super.t1;

  /// Vector from components.
  const Vec2(final double x, final double y) : super(x, y);

  /// Vector from magnitude and rotation (0 to 2pi).
  factory Vec2.fromRot(final double mag, final double rot) =>
      Vec2(atan(rot), 1.0).unit * mag;

  /// Vector from sum of vectors.
  factory Vec2.fromSum(final List<Vec2> a) {
    var _res = Vec2(0.0, 0.0);
    for (final Vec2 b in a) _res += b;
    return _res;
  }

  /// Vector from Size.
  //factory Vec2.fromSize(final Size a) => Vec2(a.width, a.height);

  // Vector to Size.
  //Size toSize() => Size(this.x, this.y);

  /// Vector from Offset.
  //factory Vec2.fromOffset(final Offset a) => Vec2(a.dx, a.dy);

  /// Vector to Offset.
  //Offset toOffset() => Offset(this.x, this.y);

  /// Vector to Pair.
  Pair toPair() => Pair(this.x, this.y);

  /// Zero vector.
  factory Vec2.zero() => Vec2(0.0, 0.0);

  /// Can be used to import vector from database.
  @override
  factory Vec2.fromMap(
    final Map<String, Map<String, double>> a, [
    final String id = "",
  ]) =>
      Vec2(
        a[id]?["x"] ?? double.infinity,
        a[id]?["y"] ?? double.infinity,
      );

  /// Can be used to export vector to database.
  @override
  Map<String, Map<String, double>> toMap(final String id) => {
        id: {"x": this.x, "y": this.y}
      };

  // Basic operators.
  Vec2 operator /(final double a) => Vec2(this.x / a, this.y / a);
  Vec2 operator *(final double a) => Vec2(this.x * a, this.y * a);
  Vec2 operator +(final Vec2 b) => Vec2(this.x + b.x, this.y + b.y);
  Vec2 operator -(final Vec2 b) => Vec2(this.x - b.x, this.y - b.y);
  Vec2 operator -() => Vec2(-this.x, -this.y);

  /// Magnitude of vector.
  double get mag => sqrt(this.x * this.x + this.y * this.y);

  /// Unit vector.
  Vec2 get unit => this / this.mag;

  /// Perpendicular vector.
  Vec2 get perp => Vec2(-this.y, this.x);

  /// Vector of same direction but with magnitude that's fraction [a] of
  /// original.
  Vec2 frac(final double a) => this.unit * this.mag * a;

  /// Vector of same direction but with magnitude that's half of original.
  Vec2 get half => this.frac(0.5);

  /// Vector of same direction but with magnitude [a].
  Vec2 len(final double a) => this.unit * a;

  /// Dot product of vectors.
  double dot(final Vec2 b) => this.x * b.x + this.y + b.y;

  /// Cross product of vectors.
  double cross(final Vec2 b) => this.x * b.y - this.y * b.x;

  /// Gradient of vector.
  double get grad => this.y / this.x;

  /// Quadrant of vector. Negative values indicate vector sits on axis.
  /// Use quadrant().abs() to discard signs.
  int quadrant() {
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

  /// New vector from this vector rotated by [a] radians.
  Vec2 rotated(final double a) {
    final _ca = cos(a);
    final _sa = sin(a);
    return Vec2(
      this.x * _ca - this.y * _sa,
      this.x * _sa + this.y * _ca,
    );
  }

  /// Rotation of this vector from 0 to 2pi.
  double get rot {
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

  /// Difference between vector rotations.
  double angle(final Vec2 a) => (this.rot - a.rot).abs();

  /// Smallest of the angles between two vectors.
  double angleSmall(final Vec2 a) {
    final _t0 = this.angle(a);
    final _t1 = 2.0 * pi - _t0;
    return _t0 < _t1 ? _t0 : _t1;
  }

  /// Largest of the angles between two vectors.
  double angleLarge(final Vec2 a) {
    final _t0 = this.angle(a);
    final _t1 = 2.0 * pi - _t0;
    return _t0 > _t1 ? _t0 : _t1;
  }

  /// Basic details of vector for testing.
  // Map<String, dynamic> details() => {
  //       "x": this.x,
  //       "y": this.y,
  //       "rot": this.rot,
  //       "deg": radToDeg(this.rot),
  //       "mag": this.mag,
  //       "quadrant": this.quadrant(),
  //     };
}

extension ListToVec2 on List<double> {
  /// List to Vec2.
  Vec2 get asVec2 {
    assert(this.length >= 2);
    return Vec2(this[0], this[1]);
  }
}

extension ListToVec2List on List<List<double>> {
  /// List to Vec2 list.
  List<Vec2> get asVec2List {
    final List<Vec2> _res = [];
    this.forEach((__el) => _res.add(__el.asVec2));
    return _res;
  }
}

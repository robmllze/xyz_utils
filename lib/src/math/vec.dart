// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:convert';
import 'dart:math';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Vec {
  //
  //
  //

  final List<num> components;

  const Vec(this.components);

  factory Vec.copy(Vec other, int dimension, [num filler = 0]) {
    final extra = dimension - other.dimension;
    final a = other.components.take(dimension).toList();
    final b = extra > 0 ? List<num>.filled(extra, filler) : <num>[];
    return (a..addAll(b)).vec;
  }

  factory Vec.zero(int dimension) => List<num>.filled(dimension, 0).vec;

  factory Vec.fromString(String source) => (const JsonDecoder().convert(source) as List<num>).vec;

  //
  //
  //

  int get dimension => components.length;

  Vec operator +(Vec other) => _operateWithAnotherVector(other, (a, b) => a + b);

  Vec operator -(Vec other) => _operateWithAnotherVector(other, (a, b) => a - b);

  Vec operator -() => components.map((component) => -component).toList().vec;

  Vec operator *(num factor) => components.map((component) => component * factor).toList().vec;

  Vec operator /(num divisor) => components.map((component) => component / divisor).toList().vec;

  Vec operator ^(num exponent) =>
      components.map((component) => pow(component, exponent)).toList().vec;

  @override
  bool operator ==(Object other) => other is Vec && this.equals(other);

  bool equals(Vec other) => _equalsIterable(this.components, other.components);

  num operator [](int i) => components[i];

  Vec get unit => components.map((component) => component / norm).toList().vec;

  num get norm => sqrt(components.fold(0, (acc, c) => acc + c * c));

  num dot(Vec other) => components
      .asMap()
      .map((index, value) => MapEntry(index, value * other[index]))
      .values
      .reduce((a, b) => a + b);

  num theta(Vec other) => acos(dot(other) / (norm * other.norm));

  num alpha(Vec other) => 2.0 * pi - theta(other);

  Vec renorm(num norm) => unit * norm;

  Vec scale(num scale) => unit * this.norm * scale;

  Vec get half => scale(0.5);

  @override
  String toString() => components.toString();

  @override
  int get hashCode => combineHashCodes(components.map((e) => e.hashCode));

  Vec _operateWithAnotherVector(Vec other, num Function(num, num) operation) => components
      .asMap()
      .map((index, value) =>
          MapEntry(index, operation(value, other.components.length > index ? other[index] : 0)))
      .values
      .toList()
      .vec;

  Vec2 get vec2 => Vec2(components[0], components[1]);
  Vec3 get vec3 => Vec3(components[0], components[1], components[2]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ListToVec on List<num> {
  Vec get vec => Vec(List<num>.unmodifiable(this));
  Vec2 get vec2 => Vec2(this[0], this[1]);
  Vec3 get vec3 => Vec3(this[0], this[1], this[2]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

bool _equalsIterable(Iterable<num> a, Iterable<num> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a.elementAt(i) != b.elementAt(i)) return false;
  }
  return true;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

int combineHashCodes(Iterable<int> hashCodes) {
  var result = 0;
  for (var hashCode in hashCodes) {
    result = 0x1fffffff & (result + hashCode);
    result = 0x1fffffff & (result + ((0x0007ffff & result) << 10));
    result ^= result >> 6;
  }
  result = 0x1fffffff & (result + ((0x03ffffff & result) << 3));
  result ^= result >> 11;
  return 0x1fffffff & (result + ((0x00003fff & result) << 15));
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Vec2 extends Vec {
  //
  //
  //

  Vec2(num x, num y) : super([x, y]);

  //
  //
  //

  num get x => this[0];
  num get y => this[1];

  num cross(Vec2 other) => x * other.y - y * other.x;

  num get getRotation {
    var angle = atan2(y, x);
    if (angle < 0) angle += 2 * pi;
    return angle;
  }

  Vec2 rotate(num angle) {
    final cosA = cos(angle);
    final sinA = sin(angle);
    return Vec2(
      x * cosA - y * sinA,
      x * sinA + y * cosA,
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Vec3 extends Vec {
  //
  //
  //

  Vec3(num x, num y, num z) : super([x, y, z]);

  //
  //
  //

  num get x => this[0];
  num get y => this[1];
  num get z => this[2];

  Vec3 cross(Vec3 other) {
    return Vec3(
      y * other.z - z * other.y,
      z * other.x - x * other.z,
      x * other.y - y * other.x,
    );
  }

  Vec3 rotate(Vec3 axis, num angle) {
    final unit = axis.unit;
    final ux = unit[0];
    final uy = unit[1];
    final uz = unit[2];
    final cosA = cos(angle);
    final sinA = sin(angle);
    final rotatedX = (cosA + ux * ux * (1 - cosA)) * x +
        (ux * uy * (1 - cosA) - uz * sinA) * y +
        (ux * uz * (1 - cosA) + uy * sinA) * z;
    final rotatedY = (uy * ux * (1 - cosA) + uz * sinA) * x +
        (cosA + uy * uy * (1 - cosA)) * y +
        (uy * uz * (1 - cosA) - ux * sinA) * z;
    final rotatedZ = (uz * ux * (1 - cosA) - uy * sinA) * x +
        (uz * uy * (1 - cosA) + ux * sinA) * y +
        (cosA + uz * uz * (1 - cosA)) * z;
    return Vec3(
      rotatedX,
      rotatedY,
      rotatedZ,
    );
  }
}

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// CIRCLE
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:math';

import 'pair.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Solves f(x) for a circle. Returns a pair of y-coordinates.
///
/// - `x` f(x) parameter x representing x-coordinate.
/// - `r` Radius of circle.
/// - `x` Center x-coordinate.
/// - `y` Center y-coordinate.
Pair<double> circleFx({
  required final double x,
  required final double r,
  final double x0 = 0.0,
  final double y0 = 0.0,
}) {
  // Function of circle.
  // (x - x0)^2 + (y - y0)^2 = r^2
  // Solved for y.
  // y = sqrt((r + x - x0) * (r - x + x0)) + y0
  final _sqrt = sqrt((r + x - x0) * (r - x + x0));
  // Positive sqrt.
  final _fx0 = _sqrt + y0;
  // Negative sqrt.
  final _fx1 = (-_sqrt) + y0;
  return Pair<double>(_fx0, _fx1);
}

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// UTILS
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:math';

import 'utils.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

double normRad(final double a) => a.norm(2.0 * pi);
double normDeg(final double a) => a.norm(360.0);
double radToDeg(final double a) => 180.0 * a / pi;
double radToGrad(final double a) => tan(a);
double degToRad(final double a) => pi * a / 180.0;
double degToGrad(final double a) => radToGrad(degToRad(a));
double gradToRad(final double a) => atan(a);
double gradToDeg(final double a) => radToDeg(gradToRad(a));

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// PYTHAGORAS'S THEOREM.
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Pythagoras's theorem.
///
/// Returns x where `r`^2 = x^2 + `y`^2.
double pythX(final double y, final double r) => sqrt(r * r - y * y);

/// Pythagoras's theorem.
///
/// Returns y where `r`^2 = x^2 + `x`^2.
double pythY(final double x, final double r) => sqrt(r * r - x * x);

/// Pythagoras's theorem.
///
/// Returns r where r^2 = `x`^2 + `y`^2.
double pythR(final double x, final double y) => sqrt(x * x + y * y);

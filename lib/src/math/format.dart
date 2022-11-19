// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// FORMAT
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:math';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// ROUNDING AND TRUNCATING
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

double log10(num x) => log(x) / ln10;

/// Rounds `x` to significant `figures`, e.g. roundAt(5.1234567, 4) returns
/// 5.123.
double rountToFigures(final double x, final int figures) {
  assert(figures >= 0);
  if (x == 0) return 0;
  final double a = log10(x).truncateToDouble();
  final num y = pow(10, a + 1 - figures);
  return y * (x / y).roundToDouble();
}

double truncToFigures(final double x, final int figures) {
  assert(figures >= 0);
  if (x == 0) return 0;
  final double a = log10(x).truncateToDouble();
  final num y = pow(10, a + 1 - figures);
  return y * (x / y).truncateToDouble();
}

/// Rounds `x` at the figure `figures`, e.g. roundAt(5.1234567, 4) returns
/// 5.1235.
double roundAt(final double x, final int figures) {
  assert(figures >= 0);
  if (x == 0) return 0;
  final double y = pow(10, figures).toDouble();
  return (x * y).roundToDouble() / y;
}

double truncateAt(final double x, final int figures) {
  assert(figures >= 0);
  if (x == 0) return 0;
  final double y = pow(10, figures).toDouble();
  return (x * y).truncateToDouble() / y;
}

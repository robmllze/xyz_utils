// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// ELLIPSE
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:math';

import 'trig.dart';
import 'vec.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns the positive Y-intercept of a point on the perimeter of an ellipse
/// where:
///
/// 1. `x` is the point's X-intercept
/// 2. `a` is half the width of ellipse
/// 3. `b` is half the height of ellipse
///
/// Note: The condition -a <= x <= a must be true.
double ellipseY(
  final double x,
  final double a,
  final double b,
) {
  assert(a >= 0.0 && b >= 0.0);
  assert(x >= -a && x <= a);
  return b * sqrt(1.0 - (x * x) / (a * a));
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns the positive slope at a point on the perimeter of an ellipse where:
///
/// 1. `x` is the X-intercept of the point
/// 2. `a` is half the width of ellipse
/// 3. `b` is half the height of ellipse
double ellipseDyDx(
  final double x,
  final double a,
  final double b,
) {
  assert(a >= 0.0 && b >= 0.0);
  final _a2 = 2.0 * a;

  // 1. Determine range index _n of x.
  // i.e.
  // _n = 0 when -a <= x < a,
  // _n = 1 when a <= x < 2a,
  // _n = 2 when 2a <= x < 3a, etc.
  final _n = ((x + a) / _a2).floorToDouble();

  // 2. Cycle x between -a and a.
  final _xCycle = x - _n * _a2;

  // 3. Voila!
  return (b * _xCycle) / (a * a * sqrt(1.0 - (_xCycle * _xCycle) / (a * a)));
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns a vector pointing to a point on the perimeter of an ellipse where:
///
/// 1. `x` is the point's X-intercept
/// 2. `a` is half the width of ellipse
/// 3. `b` is half the height of ellipse
///
/// Note: If the inequality -a <= x <= a is not met, the returned vector's
/// X-component will be cycled so that the inequality is met for it.
Vec ellipseFxV(
  final double x,
  final double a,
  final double b,
) {
  assert(a >= 0.0 && b >= 0.0);
  final _a2 = 2.0 * a;

  // 1. Determine range index _n of x.
  final _n = ((x + a) / _a2).floorToDouble();

  // 2. Cycle x between -a and a.
  final _xCycle = x - _n * _a2;

  // 3. Find y-itercept with respect to _xCycle for ellipse.
  final _y = ellipseY(_xCycle, a, b);

  // 4. Determine whether _n is even or odd to determine whether y should be
  // positve or negative.
  final _nHalf = 0.5 * _n;
  final _isEven = _nHalf - _nHalf.truncateToDouble() == 0.0;

  // 5. Voila!
  return [_xCycle, _y].vec * (_isEven ? 1.0 : -1.0);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns a good estimate for the circumference of an ellipse where:
///
/// 1. `a` is half the width of ellipse
/// 2. `b` is half the height of ellipse
///
/// See: https://www.mathsisfun.com/geometry/ellipse-perimeter.html
double ellipseCircumRamanujan1(final double a, final double b) {
  assert(a >= 0.0 && b >= 0.0);
  return pi * (3.0 * (a + b) - sqrt((3 * a + b) * (a + 3 * b)));
}

/// Returns a good estimate for the circumference of an ellipse where:
///
/// 1. `a` is half the width of ellipse
/// 2. `b` is half the height of ellipse
///
/// See: https://www.mathsisfun.com/geometry/ellipse-perimeter.html
double ellipseCircumRamanujan2(final double a, final double b) {
  assert(a >= 0.0 && b >= 0.0);
  final _aa = a - b;
  final _bb = a + b;
  final _h = (_aa * _aa) / (_bb * _bb);
  return pi * _bb * (1.0 + (3.0 * _h) / (10.0 + sqrt(4.0 - 3.0 * _h)));
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns an approximation of the arc length of an ellipse between the two
/// X-intercepts [x0] and [x1] where:
///
/// 1. `x0` is the first X-intercept
/// 2. `x1` is the second X-intercept
/// 3. `a` is half the width of ellipse
/// 4. `b` is half the height of ellipse
/// 5. `parts` determines the accuracy of the approximation. The larger the
/// value the better the estimate but slower the function.
double ellipseArcParts(
  final double x0,
  final double x1,
  final double a,
  final double b,
  final int parts,
) {
  assert(a >= 0.0 && b >= 0.0);
  assert(x0 >= -a && x0 <= a);
  assert(x1 >= -a && x1 <= a);
  assert(parts > 0);
  final _xMin = x0 < x1 ? x0 : x1;
  final _xMax = x1 > x0 ? x1 : x0;
  final _xD = (_xMax - _xMin) / parts;
  double _xA = 0.0;
  double _xB = 0.0;
  double _length = 0.0;
  for (int n = 0; n < parts; n++) {
    _xA = _xMin + n * _xD;
    _xB = _xA + _xD;
    final _yA = ellipseY(_xA, a, b);
    final _yB = ellipseY(_xB, a, b);
    final _l = pythR(_xA - _xB, _yA - _yB);
    _length += _l;
  }
  return _length;
}

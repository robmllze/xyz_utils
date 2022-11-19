// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// LIST - SERIES - EXAMPLES
//
// By Robert Mollentze / @robmllze (2021).
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:math';

import 'misc.dart';
import 'list_series.dart';
import 'tables.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const piHalf = 0.5 * pi;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Generates pi using the Gregory–Leibniz series.
num example_piGregoryLeibniz([final int accuracy = 1000000]) {
  final a = List<num>.filled(accuracy, 4);
  final b = List<num>.generate(accuracy, (n) => 2 * n + 1);
  final _pi = a.quotient2(b).altering1();
  return _pi;
}

/// Generates pi using John Wallis's series from 1655.
num example_piJohnWallis([final int accuracy = 1000000]) {
  final _pi = 2.0 *
      List<num>.generate(
        accuracy,
        (n) {
          var a, b;
          if (n.isEven) {
            a = n + 1;
            b = n;
          } else {
            a = n;
            b = n + 1;
          }
          return (1 + a) / (1 + b);
        },
      ).product();
  return _pi;
}

/// Generates e using Jacob Bernoulli's series from 1683.
num example_eBernoulli([final int accuracy = 66]) =>
    List<num>.generate(accuracy, (n) => factorial(n)).inverse().sum();

/// Computes ζ(s).
num example_riemannZeta(final num s, [final int accuracy = 10]) =>
    List<num>.generate(accuracy, (n) => 1 / pow((n + 1), s)).sum();

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// - sin sec, tan
// - cos, csc, cot
// - asin, acos, atan
// - sinh, cosh, tanh
// - asinh, atanh (missing acosh)
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

num example_sin(final double a, [final int accuracy = 10]) {
  final _numerators = List<num>.generate(accuracy, (n) => pow(a, 2 * n + 1));
  final _denomenators = List<num>.generate(accuracy, (n) => factorial(2 * n + 1));
  return _numerators.quotient2(_denomenators).altering1();
}

num example_sec(final double a, [final int accuracy = 10]) => 1 / example_cos(a);

num example_tan(final double a, [final int accuracy = 10]) =>
    example_sin(a, accuracy) / example_cos(a, accuracy);

num example_cos(final double a, [final int accuracy = 10]) {
  final _numerators = List<num>.generate(accuracy, (n) => pow(a, 2 * n));
  final _denomenators = List<num>.generate(accuracy, (n) => factorial(2 * n));
  return _numerators.quotient2(_denomenators).altering1();
}

num example_csc(final double a, [final int accuracy = 10]) => example_sec(piHalf - a);

num example_cot(final double a, [final int accuracy = 10]) => example_tan(piHalf - a);

num example_asin(final double a, [final int accuracy = 10]) {
  assert(accuracy > 0 && accuracy <= 100);
  return List<num>.generate(accuracy, (n) {
    final c = 2 * n;
    final d = c + 1;
    return factorialT100(c) / (pow(4, n) * pow(factorialT100(n), 2) * d) * pow(a, d);
  }).sum();
}

num example_acos(final double a, [final int accuracy = 10]) => piHalf - example_asin(a, accuracy);

num example_atan(final double a, [final int accuracy = 10]) {
  final _numerators = List<num>.generate(accuracy, (n) => pow(a, 2 * n + 1));
  final _denomenators = List<num>.generate(accuracy, (n) => 2 * n + 1);
  return _numerators.quotient2(_denomenators).altering1();
}

num example_sinh(final double a, [final int accuracy = 10]) {
  final _numerators = List<num>.generate(accuracy, (n) => pow(a, 2 * n + 1));
  final _denomenators = List<num>.generate(accuracy, (n) => factorial(2 * n + 1));
  return _numerators.quotient2(_denomenators).sum();
}

num example_cosh(final double a, [final int accuracy = 10]) {
  final _numerators = List<num>.generate(accuracy, (n) => pow(a, 2 * n));
  final _denomenators = List<num>.generate(accuracy, (n) => factorial(2 * n));
  return _numerators.quotient2(_denomenators).sum();
}

num example_tanh(final double a, [final int accuracy = 10]) =>
    example_sinh(a, accuracy) / example_cosh(a, accuracy);

num example_asinh(final double a, [final int accuracy = 10]) {
  assert(accuracy > 0 && accuracy <= 100);
  return List<num>.generate(accuracy, (n) {
    final c = 2 * n;
    final d = c + 1;
    return pow(-1, n) * factorialT100(c) / (pow(4, n) * pow(factorialT100(n), 2) * d) * pow(a, d);
  }).sum();
}

num example_atanh(final double a, [final int accuracy = 10]) {
  return List<num>.generate(accuracy, (n) {
    final m = 2 * n + 1;
    return pow(a, m) / m;
  }).sum();
}

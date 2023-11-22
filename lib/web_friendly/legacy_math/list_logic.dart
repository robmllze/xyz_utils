// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// LIST - LOGIC
//
// Adds methods regarding binary logic to Dart's stock List.
//
// By Robert Mollentze / @robmllze (2021).
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'list_various.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension List_Logic on List<num> {
  //
  //
  //

  /// Generates a new Series by performing a logical `test` on eachcomponent. If
  /// a component passes the `test`, its value is added to the new Series (or
  /// rather `trueValue` if specified). Otherwise 0 is added (or rather
  /// `falseValue` if specified).
  List<num> logic(
    final bool Function(num) test, [
    final num? trueValue,
    final num? falseValue,
  ]) =>
      this.operate((a, _) => a == null
          ? falseValue ?? 0
          : test(a)
              ? trueValue ?? a
              : falseValue ?? 0);

  List<num> binary() => this.logic((n) => n != 0, 1, 0);
  List<num> not() => this.logic((n) => n == 0, 1);

  List<num> or(
    final List<num> other, {
    final bool Function(num)? test,
    final int? length,
  }) {
    assert(this.length == other.length);
    if (this.isEmpty) return [];
    final f = test ?? (n) => n != 0;
    return this.logic(f).operate2(
          other.logic(f),
          (a, b, _) => (a ?? 0) == 0 && (b ?? 0) == 0
              ? 0
              : ((a ?? 0) == 0 ? 1 : a!) * ((b ?? 0) == 0 ? 1 : b!),
          length,
        );
  }

  List<num> and(
    final List<num> other, {
    final bool Function(num)? test,
    final int? length,
  }) {
    assert(this.length == other.length);
    if (this.isEmpty) return [];
    final f = test ?? (n) => n != 0;
    return this.logic(f).operate2(
          other.logic(f),
          (a, b, _) => (a != 0 && b != 0 ? (a ?? 0) * (b ?? 0) : 0),
          length,
        );
  }

  //xor
  //nor
  //nand
  //xnor
}

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// PAIR
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'utils.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Pair<T> {
  //
  //
  //

  final T t0;
  final T t1;

  const Pair(this.t0, this.t1);

  /// NB: [list] must be valid.
  factory Pair.fromList(final List<T> list) {
    assert(list.length == 2);
    return Pair<T>(list[0], list[1]);
  }

  /// Can be used to import Pair to database.
  /// NB: [map] must be valid.
  factory Pair.fromMap(
    final Map<String, Map<String, T>> map, [
    final String id = "",
  ]) =>
      Pair(map[id]!["t0"]!, map[id]!["t1"]!);

  /// Can be used to export Pair to database.
  Map<String, Map<String, T>> toMap(final String id) => {
        id: {"t0": this.t0, "t1": this.t1}
      };

  /// Alternative way to access components.
  /// - `this.t0` = `this.t[0]`
  /// - `this.t1` = `this.t[1]`
  T operator [](final int i) => i == 0 ? this.t0 : this.t1;

  /// Compares hash codes.
  @override
  bool operator ==(final Object b) => this.hashCode == b.hashCode;

  @override
  int get hashCode => combineHashCodes(this.t0.hashCode, this.t1.hashCode);

  /// Returns new Pair but with components reversed.
  Pair<T> get reversed => Pair<T>(this.t1, this.t0);

  List<T> toList() => <T>[t0, t1];

  @override
  String toString() => "[${this.t0}, ${this.t1}]";
}

extension ListToPair<T> on List<T> {
  /// List to Pair.
  Pair get asPair {
    assert(this.length >= 2);
    return Pair(this[0], this[1]);
  }
}

extension PairListFromListList<T> on List<List<T>> {
  /// List to Pair List.
  List<Pair> get asPairList {
    final List<Pair> _res = [];
    this.forEach((__el) => _res.add(__el.asPair));
    return _res;
  }
}

//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// X|Y|Z & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

/// A tuple with one element.
class Tuple1<T1> {
  final T1 $1;

  const Tuple1(
    this.$1,
  );
}

/// Returns a tuple with one element.
Tuple1<T1> getAs1<T1>(Iterable<dynamic> source) {
  if (source.isEmpty) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple1<T1>(
    source.elementAt(0) as T1,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple with two elements.
class Tuple2<T1, T2> {
  final T1 $1;
  final T2 $2;

  const Tuple2(
    this.$1,
    this.$2,
  );
}

/// Returns a tuple with two elements.
Tuple2<T1, T2> getAs2<T1, T2>(Iterable<dynamic> source) {
  if (source.length < 2) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple2<T1, T2>(
    source.elementAt(0) as T1,
    source.elementAt(1) as T2,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple with three elements.
class Tuple3<T1, T2, T3> {
  final T1 $1;
  final T2 $2;
  final T3 $3;

  const Tuple3(
    this.$1,
    this.$2,
    this.$3,
  );
}

/// Returns a tuple with three elements.
Tuple3<T1, T2, T3> getAs3<T1, T2, T3>(Iterable<dynamic> source) {
  if (source.length < 3) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple3<T1, T2, T3>(
    source.elementAt(0) as T1,
    source.elementAt(1) as T2,
    source.elementAt(2) as T3,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple with four elements.
class Tuple4<T1, T2, T3, T4> {
  final T1 $1;
  final T2 $2;
  final T3 $3;
  final T4 $4;

  const Tuple4(
    this.$1,
    this.$2,
    this.$3,
    this.$4,
  );
}

/// Returns a tuple with four elements.
Tuple4<T1, T2, T3, T4> getAs4<T1, T2, T3, T4>(Iterable<dynamic> source) {
  if (source.length < 4) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple4<T1, T2, T3, T4>(
    source.elementAt(0) as T1,
    source.elementAt(1) as T2,
    source.elementAt(2) as T3,
    source.elementAt(3) as T4,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple with five elements.
class Tuple5<T1, T2, T3, T4, T5> {
  final T1 $1;
  final T2 $2;
  final T3 $3;
  final T4 $4;
  final T5 $5;

  const Tuple5(
    this.$1,
    this.$2,
    this.$3,
    this.$4,
    this.$5,
  );
}

/// Returns a tuple with five elements.
Tuple5<T1, T2, T3, T4, T5> getAs5<T1, T2, T3, T4, T5>(
  Iterable<dynamic> source,
) {
  if (source.length < 5) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple5<T1, T2, T3, T4, T5>(
    source.elementAt(0) as T1,
    source.elementAt(1) as T2,
    source.elementAt(2) as T3,
    source.elementAt(3) as T4,
    source.elementAt(4) as T5,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple with six elements.
class Tuple6<T1, T2, T3, T4, T5, T6> {
  final T1 $1;
  final T2 $2;
  final T3 $3;
  final T4 $4;
  final T5 $5;
  final T6 $6;

  const Tuple6(
    this.$1,
    this.$2,
    this.$3,
    this.$4,
    this.$5,
    this.$6,
  );
}

/// Returns a tuple with six elements.
Tuple6<T1, T2, T3, T4, T5, T6> getAs6<T1, T2, T3, T4, T5, T6>(
  Iterable<dynamic> source,
) {
  if (source.length < 6) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple6<T1, T2, T3, T4, T5, T6>(
    source.elementAt(0) as T1,
    source.elementAt(1) as T2,
    source.elementAt(2) as T3,
    source.elementAt(3) as T4,
    source.elementAt(4) as T5,
    source.elementAt(5) as T6,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple with seven elements.
class Tuple7<T1, T2, T3, T4, T5, T6, T7> {
  final T1 $1;
  final T2 $2;
  final T3 $3;
  final T4 $4;
  final T5 $5;
  final T6 $6;
  final T7 $7;

  const Tuple7(
    this.$1,
    this.$2,
    this.$3,
    this.$4,
    this.$5,
    this.$6,
    this.$7,
  );
}

/// Returns a tuple with seven elements.
Tuple7<T1, T2, T3, T4, T5, T6, T7> getAs7<T1, T2, T3, T4, T5, T6, T7>(
  Iterable<dynamic> source,
) {
  if (source.length < 7) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple7<T1, T2, T3, T4, T5, T6, T7>(
    source.elementAt(0) as T1,
    source.elementAt(1) as T2,
    source.elementAt(2) as T3,
    source.elementAt(3) as T4,
    source.elementAt(4) as T5,
    source.elementAt(5) as T6,
    source.elementAt(6) as T7,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple with eight elements.
class Tuple8<T1, T2, T3, T4, T5, T6, T7, T8> {
  final T1 $1;
  final T2 $2;
  final T3 $3;
  final T4 $4;
  final T5 $5;
  final T6 $6;
  final T7 $7;
  final T8 $8;

  const Tuple8(
    this.$1,
    this.$2,
    this.$3,
    this.$4,
    this.$5,
    this.$6,
    this.$7,
    this.$8,
  );
}

/// Returns a tuple with eight elements.
Tuple8<T1, T2, T3, T4, T5, T6, T7, T8> getAs8<T1, T2, T3, T4, T5, T6, T7, T8>(
  Iterable<dynamic> source,
) {
  if (source.length < 8) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>(
    source.elementAt(0) as T1,
    source.elementAt(1) as T2,
    source.elementAt(2) as T3,
    source.elementAt(3) as T4,
    source.elementAt(4) as T5,
    source.elementAt(5) as T6,
    source.elementAt(6) as T7,
    source.elementAt(7) as T8,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A tuple with nine elements.
class Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9> {
  final T1 $1;
  final T2 $2;
  final T3 $3;
  final T4 $4;
  final T5 $5;
  final T6 $6;
  final T7 $7;
  final T8 $8;
  final T9 $9;

  const Tuple9(
    this.$1,
    this.$2,
    this.$3,
    this.$4,
    this.$5,
    this.$6,
    this.$7,
    this.$8,
    this.$9,
  );
}

/// Returns a tuple with nine elements.
Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>
    getAs9<T1, T2, T3, T4, T5, T6, T7, T8, T9>(
  Iterable<dynamic> source,
) {
  if (source.length < 9) {
    throw ArgumentError("Source does not have enough elements");
  }
  return Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>(
    source.elementAt(0) as T1,
    source.elementAt(1) as T2,
    source.elementAt(2) as T3,
    source.elementAt(3) as T4,
    source.elementAt(4) as T5,
    source.elementAt(5) as T6,
    source.elementAt(6) as T7,
    source.elementAt(7) as T8,
    source.elementAt(8) as T9,
  );
}

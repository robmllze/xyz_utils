//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension SecondToNinthElementOnIterableExtension<T> on Iterable<T> {
  /// Returns the second element in the list or the element at index 1.
  T get second => elementAt(1);

  /// Returns the second element in the list or null if the list has less than 2 elements.
  T? get secondOrNull => elementAtOrNull(1);

  /// Returns the third element in the list or the element at index 2.
  T get third => elementAt(2);

  /// Returns the third element in the list or null if the list has less than 3 elements.
  T? get thirdOrNull => elementAtOrNull(2);

  /// Returns the fourth element in the list or the element at index 3.
  T get fourth => elementAt(3);

  /// Returns the fourth element in the list or null if the list has less than 4 elements.
  T? get fourthOrNull => elementAtOrNull(3);

  /// Returns the fifth element in the list or the element at index 4.
  T get fifth => elementAt(4);

  /// Returns the fifth element in the list or null if the list has less than 5 elements.
  T? get fifthOrNull => elementAtOrNull(4);

  /// Returns the sixth element in the list or the element at index 5.
  T get sixth => elementAt(5);

  /// Returns the sixth element in the list or null if the list has less than 6 elements.
  T? get sixthOrNull => elementAtOrNull(5);

  /// Returns the seventh element in the list or the element at index 6.
  T get seventh => elementAt(6);

  /// Returns the seventh element in the list or null if the list has less than 7 elements.
  T? get seventhOrNull => elementAtOrNull(6);

  /// Returns the eighth element in the list or the element at index 7.
  T get eighth => elementAt(7);

  /// Returns the eighth element in the list or null if the list has less than 8 elements.
  T? get eighthOrNull => elementAtOrNull(7);

  /// Returns the ninth element in the list or the element at index 8.
  T get ninth => elementAt(8);

  /// Returns the ninth element in the list or null if the list has less than 9 elements.
  T? get ninthOrNull => elementAtOrNull(8);
}

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

extension JoinWithLastSeparatorOnIterableExtension on Iterable {
  /// Joins the elements of the iterable into a single string with the given
  /// [separator] and [lastSeparator]. The [lastSeparator] is used to join the
  /// last two elements of the iterable.
  String joinWithLastSeparator({
    String separator = ', ',
    String lastSeparator = ' & ',
  }) {
    if (this.isEmpty) {
      return '';
    }
    if (this.length == 1) {
      return this.first;
    }
    final list = this.toList();
    if (this.length == 2) {
      return list.join(lastSeparator);
    }

    final lastTwo = list.sublist(list.length - 2).join(lastSeparator);
    final allButLastTwo = list.sublist(0, list.length - 2).join(separator);
    return '$allButLastTwo$separator$lastTwo';
  }
}

//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension XyzIterableExtensions on Iterable<String> {
  //
  //
  //

  String toCommaSeparatedString({
    String seperator = ", ",
    String seperatorLast = " or ",
  }) {
    assert(this.isNotEmpty);
    var result = "";
    if (this.length == 1) {
      result = this.first;
    } else if (this.length == 2) {
      result = this.first + seperatorLast + this.elementAt(1);
    } else {
      final m = this.length - 2;
      for (var n = 0; n < m; n++) {
        result += this.elementAt(n) + seperator;
      }
      result += this.elementAt(m) + seperatorLast + this.last;
    }
    return result;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ß

// extension ExtendedList<T> on Iterable<T> {
//   //
//   //
//   //

//   T? tryElementAt(int index) {
//     try {
//       return this.elementAt(index);
//     } catch (_) {
//       return null;
//     }
//   }

//   //
//   //
//   //

//   T? tryElementAtReversed(int index) {
//     final length = this.length;
//     return this.tryElementAt(length - index);
//   }
// }

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class UnorderedDeepCollectionEquality {
  //
  //
  //

  const UnorderedDeepCollectionEquality();

  //
  //
  //

  bool equals(dynamic a, dynamic b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.runtimeType != b.runtimeType) return false;

    if (a is Map) {
      if (a.length != b.length) return false;

      for (var key in a.keys) {
        if (!b.containsKey(key)) return false;
        if (!equals(a[key], b[key])) return false;
      }

      return true;
    } else if (a is Iterable) {
      if (a.length != b.length) return false;

      var aList = a.toList();
      var bList = b.toList();

      for (var item in aList) {
        int index = bList.indexWhere((e) => equals(e, item));
        if (index == -1) return false;
        bList.removeAt(index); // Ensure duplicate items are considered.
      }

      return true;
    } else {
      return a == b;
    }
  }
}

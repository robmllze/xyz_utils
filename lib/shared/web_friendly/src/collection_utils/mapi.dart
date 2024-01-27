//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension IterableMapI<A> on Iterable<A> {
  Iterable<B> mapi<B, C>(
    B Function(A x, int index, C? option) mapper, {
    List<C> options = const [],
  }) {
    var index = 0;
    return this.map((x) {
      final option = options.length > index ? options[index] : null;
      return mapper(x, index++, option);
    });
  }
}

extension ListMapI<A> on List<A> {
  Iterable<B> mapi<B, C>(
    B Function(A x, int index, C? option) mapper, {
    List<C> options = const [],
  }) {
    var index = 0;
    return this.map((x) {
      final option = options.length > index ? options[index] : null;
      return mapper(x, index++, option);
    });
  }
}

extension SetMapI<A> on Set<A> {
  Iterable<B> mapi<B, C>(
    B Function(A x, int index, C? option) mapper, {
    List<C> options = const [],
  }) {
    var index = 0;
    return this.map((x) {
      final option = options.length > index ? options[index] : null;
      return mapper(x, index++, option);
    });
  }
}

extension MapMapI<A1, A2> on Map<A1, A2> {
  Map<B1, B2> mapi<B1, B2, C>(
    MapEntry<B1, B2> Function(A1 x1, A2 x2, int index, C? option) mapper, {
    List<C> options = const [],
  }) {
    var index = 0;
    return this.map((x1, x2) {
      final option = options.length > index ? options[index] : null;
      return mapper(x1, x2, index++, option);
    });
  }
}

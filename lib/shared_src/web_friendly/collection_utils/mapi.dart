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

extension MapIOnIterableExtension<A> on Iterable<A> {
  Iterable<B> mapi<B, C>(
    B Function(A e, int index, C? option) mapper, {
    List<C> options = const [],
  }) {
    var index = 0;
    return this.map((e) {
      final option = options.length > index ? options[index] : null;
      return mapper(e, index++, option);
    });
  }
}

extension MapIOnListExtension<A> on List<A> {
  Iterable<B> mapi<B, C>(
    B Function(A e, int index, C? option) mapper, {
    List<C> options = const [],
  }) {
    var index = 0;
    return this.map((e) {
      final option = options.length > index ? options[index] : null;
      return mapper(e, index++, option);
    });
  }
}

extension MapIOnSetExtension<A> on Set<A> {
  Iterable<B> mapi<B, C>(
    B Function(A e, int index, C? option) mapper, {
    List<C> options = const [],
  }) {
    var index = 0;
    return this.map((e) {
      final option = options.length > index ? options[index] : null;
      return mapper(e, index++, option);
    });
  }
}

extension MapIOnMapExtension<A1, A2> on Map<A1, A2> {
  Map<B1, B2> mapi<B1, B2, C>(
    MapEntry<B1, B2> Function(A1 e1, A2 e2, int index, C? option) mapper, {
    List<C> options = const [],
  }) {
    var index = 0;
    return this.map((e1, e2) {
      final option = options.length > index ? options[index] : null;
      return mapper(e1, e2, index++, option);
    });
  }
}

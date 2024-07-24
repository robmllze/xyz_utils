// //.title
// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
// //
// // 🇽🇾🇿 & Dev
// //
// // Copyright Ⓒ Robert Mollentze
// //
// // Licensing details can be found in the LICENSE file in the root directory.
// //
// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
// //.title~

// import '/src/core/src/let.dart';

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// extension FirstAsOrNullOnIterableExtension<T extends Object?> on Iterable<T>? {
//   A? firstAsOrNull<A>() => letAsOrNull<A>(this?.firstOrNull);
// }

// extension LastAsOrNullOnIterableExtension<T extends Object?> on Iterable<T>? {
//   A? lastAsOrNull<A>() => letAsOrNull<A>(this?.lastOrNull);
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// List<Object?> chain<B, C, D, E, F, G, H, I, J, K>([
//   B Function(Null e)? t1,
//   C Function(B e)? t2,
//   D Function(C e)? t3,
//   E Function(D e)? t4,
//   F Function(E e)? t5,
//   G Function(F e)? t6,
//   H Function(G e)? t7,
//   I Function(H e)? t8,
//   J Function(I e)? t9,
//   K Function(J e)? t10,
// ]) {
//   return null.chain(
//     t1,
//     t2,
//     t3,
//     t4,
//     t5,
//     t6,
//     t7,
//     t8,
//     t9,
//     t10,
//   );
// }

// extension ChainOnObjectExtension<A extends Object?> on A {
//   //
//   //
//   //

//   List<Object?> chain<B, C, D, E, F, G, H, I, J, K>([
//     B Function(A e)? t1,
//     C Function(B e)? t2,
//     D Function(C e)? t3,
//     E Function(D e)? t4,
//     F Function(E e)? t5,
//     G Function(F e)? t6,
//     H Function(G e)? t7,
//     I Function(H e)? t8,
//     J Function(I e)? t9,
//     K Function(J e)? t10,
//   ]) =>
//       this.chainable.chain(
//             t1,
//             t2,
//             t3,
//             t4,
//             t5,
//             t6,
//             t7,
//             t8,
//             t9,
//             t10,
//           );

//   //
//   //
//   //

//   Chainable<A> get chainable => Chainable<A>(this);
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// class Chainable<A> {
//   //
//   //
//   //

//   final List<A> a;
//   final List<Object?> b;

//   //
//   //
//   //

//   Chainable(A first)
//       : this.a = [first],
//         this.b = const [];

//   const Chainable._internal(this.a, [this.b = const []]);

//   //
//   //
//   //

//   Chainable<B>? call<B>(B Function(A e)? transform) {
//     final last = this.a.last;
//     final transformed = transform?.call(last);
//     return transformed != null ? Chainable._internal([transformed], [...this.a, ...this.b]) : null;
//   }

//   //
//   //
//   //

//   List<Object?> chain<B, C, D, E, F, G, H, I, J, K>([
//     B Function(A e)? t1,
//     C Function(B e)? t2,
//     D Function(C e)? t3,
//     E Function(D e)? t4,
//     F Function(E e)? t5,
//     G Function(F e)? t6,
//     H Function(G e)? t7,
//     I Function(H e)? t8,
//     J Function(I e)? t9,
//     K Function(J e)? t10,
//   ]) {
//     final results = <Object?>[];
//     final res1 = t1 != null ? this.call(t1) : null;
//     final res2 = res1 != null && t2 != null ? res1.call(t2) : null;
//     final res3 = res2 != null && t3 != null ? res2.call(t3) : null;
//     final res4 = res3 != null && t4 != null ? res3.call(t4) : null;
//     final res5 = res4 != null && t5 != null ? res4.call(t5) : null;
//     final res6 = res5 != null && t6 != null ? res5.call(t6) : null;
//     final res7 = res6 != null && t7 != null ? res6.call(t7) : null;
//     final res8 = res7 != null && t8 != null ? res7.call(t8) : null;
//     final res9 = res8 != null && t9 != null ? res8.call(t9) : null;
//     final res10 = res9 != null && t10 != null ? res9.call(t10) : null;
//     if (res1 != null) results.add(res1.a);
//     if (res2 != null) results.add(res2.a);
//     if (res3 != null) results.add(res3.a);
//     if (res4 != null) results.add(res4.a);
//     if (res5 != null) results.add(res5.a);
//     if (res6 != null) results.add(res6.a);
//     if (res7 != null) results.add(res7.a);
//     if (res8 != null) results.add(res8.a);
//     if (res9 != null) results.add(res9.a);
//     if (res10 != null) results.add(res10.a);
//     return results;
//   }

//   //
//   //
//   //

//   @override
//   String toString() => this.a.toString();
// }

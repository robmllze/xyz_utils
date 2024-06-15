//.red
// Not needed. There are better ways to do this. I kept this here because it's interesting.
//.red~

// //.title
// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
// //
// // 🇽🇾🇿 & Dev
// //
// // Licencing details are in the LICENSE file in the root directory.
// //
// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
// //.title~

// import 'dart:async';

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// class StreamMapper<A> {
//   //
//   //
//   //

//   final Stream<A> stream;

//   //
//   //
//   //

//   const StreamMapper(this.stream);

//   //
//   //
//   //

//   StreamMapper<B> map<B>(
//     Stream<B> Function(A result1) mapper,
//   ) {
//     return StreamMapper(
//       _firstToSecondStream(this.stream, mapper),
//     );
//   }
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// /// Combines two streams into one. The first stream is used to create the second stream.
// Stream<B> _firstToSecondStream<A, B>(
//   Stream<A> stream1,
//   Stream<B> Function(A result1) stream2Creator,
// ) {
//   late StreamController<B> controller;
//   StreamSubscription<A?>? subscription1;
//   StreamSubscription<B>? subscription2;
//   controller = StreamController<B>(
//     onListen: () {
//       subscription1 = stream1.asyncMap((e) async {
//         await subscription2?.cancel();
//         return e;
//       }).listen(
//         (result1) {
//           final stream2 = stream2Creator(result1!);
//           subscription2 = stream2.listen(
//             controller.add,
//             onError: controller.addError,
//             onDone: controller.close,
//           );
//           subscription1?.cancel();
//         },
//         onError: controller.addError,
//         onDone: controller.close,
//         cancelOnError: true,
//       );
//     },
//     onCancel: () => Future.wait(
//       [
//         subscription2?.cancel(),
//         subscription1?.cancel(),
//       ].nonNulls,
//     ),
//   );
//   return controller.stream;
// }

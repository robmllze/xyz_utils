//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:async';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<T> streamToFuture<T>(
  Stream<T> stream, {
  bool cancelOnDone = false,
}) {
  final completer = Completer<T>();
  StreamSubscription<T>? subscription;
  var isCompleted = false;
  subscription = stream.listen(
    (data) {
      if (!isCompleted) {
        completer.complete(data);
        if (cancelOnDone) {
          subscription?.cancel();
        }
        isCompleted = true;
      }
    },
    onError: (e) {
      if (!isCompleted) {
        completer.completeError(e);
        if (cancelOnDone) {
          subscription?.cancel();
        }
        isCompleted = true;
      }
    },
    onDone: () {
      if (!isCompleted) {
        completer.completeError(-1);
      }
    },
    cancelOnError: true,
  );
  return completer.future;
}

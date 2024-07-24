//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:async' show Completer, StreamSubscription;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Waits for the first value from the [Stream] and returns it as a [Future].
Future<T> streamToFuture<T>(Stream<T> stream) {
  final completer = Completer<T>();
  StreamSubscription<T>? subscription;

  subscription = stream.listen(
    (data) {
      if (!completer.isCompleted) {
        completer.complete(data);
        subscription?.cancel();
      }
    },
    onError: (e) {
      if (!completer.isCompleted) {
        completer.completeError(e);
        subscription?.cancel();
      }
    },
    onDone: () {
      if (!completer.isCompleted) {
        completer.completeError(
          StateError(
            '[streamToFuture] Stream completed without emitting any values',
          ),
        );
      }
    },
    cancelOnError: true,
  );

  return completer.future;
}

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

/// A queue that executes functions in order, one at a time.
///
/// Each function is wrapped in a [_Queueable] object that contains a completer
/// and the function itself. When a new function is added to the queue via the
/// [add] method, it is wrapped in a new [_Queueable] object and added to the
/// end of the queue. If the first function in the queue is finished executing,
/// the [_execute] method runs the next function in the queue. The [_execute]
/// method continues to execute functions until it reaches a function that is
/// still running, or until the queue is empty.
///
/// Functions can be buffered by providing a [buffer] duration. When a function
/// is added to the queue with a buffer, the function is wrapped in a new
/// function that waits for the buffer to complete before executing the
/// original function. This is useful for batching up changes to a Firestore
/// document, for example.
class FunctionQueue {
  //
  //
  //

  final _queue = <_Queueable<dynamic>>[];

  //
  //
  //

  /// Adds a new function to the queue and returns a completer for the result.
  ///
  /// If the [buffer] parameter is provided, the function is wrapped in a new
  /// function that waits for the buffer duration before executing the
  /// original function.
  Future<T> add<T>(
    Future<T> Function() f, {
    Duration? buffer,
  }) async {
    final q = _Queueable<T>(
      buffer == null
          ? f
          : () async => (await Future.wait([
                f(),
                Future.delayed(buffer),
              ]))
                  .first,
    );
    this._queue.add(q);
    await this._execute();
    return q._completer.future;
  }

  //
  //
  //

  /// Executes the next function in the queue, if the queue is not empty and
  /// no other function is currently running.
  Future<void> _execute() async {
    for (final l in this._queue
      ..removeWhere(
        (final l) => l._status == _QueueableStatus.RAN,
      )) {
      final status = l._status;
      if (status == _QueueableStatus.RUNNING) break;
      if (status == _QueueableStatus.READY) {
        l._status = _QueueableStatus.RUNNING;
        l._completer.complete(l._function());
        l._status = _QueueableStatus.RAN;
        await this._execute();
        break;
      }
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// This class represents a single function that has been added to the queue.
// It contains a completer that will be used to return the result of the
// function, as well as a status that indicates whether the function has
// been run yet.
class _Queueable<T> {
  final _completer = Completer<T>();
  var _status = _QueueableStatus.READY;
  final Future<T> Function() _function;
  _Queueable(this._function);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum _QueueableStatus { READY, RUNNING, RAN }

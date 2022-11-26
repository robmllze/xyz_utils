// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

class FunctionQueue {
  //
  //
  //

  final _queue = <_Queueable<dynamic>>[];

  //
  //
  //

  Future<T?> add<T>(
    Future<T> Function() f, {
    Duration? buffer,
  }) async {
    final f1 = _Queueable<T>(
      buffer == null
          ? f
          : (await Future.wait([
              f(),
              Future.delayed(buffer),
            ]))
              .first,
    );
    this._queue.add(f1);
    await execute();
    return f1._completer.future;
  }

  //
  //
  //

  Future<void> execute() async {
    this._queue.removeWhere((final l) => l._status == _QueueableStatus.RAN);
    for (final l in this._queue) {
      final status = l._status;
      if (status == _QueueableStatus.RUNNING) break;
      if (status == _QueueableStatus.READY) {
        l._status = _QueueableStatus.RUNNING;
        l._completer.complete(await l._function());
        l._status = _QueueableStatus.RAN;
        await execute();
        break;
      }
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _Queueable<T> {
  final _completer = Completer<T>();
  var _status = _QueueableStatus.READY;
  final Future<T> Function() _function;
  _Queueable(this._function);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum _QueueableStatus { READY, RUNNING, RAN }

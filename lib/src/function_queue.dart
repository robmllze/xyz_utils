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

class _Queueable<T> {
  final _completer = Completer<T>();
  var _status = _QueueableStatus.READY;
  final Future<T> Function() _function;
  _Queueable(this._function);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum _QueueableStatus { READY, RUNNING, RAN }

//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:isolate';
import 'dart:math' as math;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> runFunctionsInIsolates(
  List<Future<void> Function()> functions,
  int chunkSize,
) async {
  final chunks = <List<Future<void> Function()>>[];
  for (var i = 0; i < functions.length; i += chunkSize) {
    final j = math.min(i + chunkSize, functions.length);
    chunks.add(functions.sublist(i, j));
  }

  // Process each chunk in a separate isolate
  final tasks = chunks.map(_runChunkInIsolate);
  await Future.wait(tasks);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> _runChunkInIsolate(List<Future<void> Function()> chunk) async {
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _isolateWorker,
    _IsolateArgs(sendPort: receivePort.sendPort, functions: chunk),
  );

  // Await completion message from the isolate
  await receivePort.first;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _IsolateArgs {
  final SendPort sendPort;
  final List<Future<void> Function()> functions;

  _IsolateArgs({required this.sendPort, required this.functions});
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void _isolateWorker(_IsolateArgs args) async {
  for (final function in args.functions) {
    await function();
  }
  args.sendPort.send('done');
}

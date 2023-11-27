//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:io';

import 'dart:async';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<double> runConsoleLoadingAnimation(
  Future<void> Function() onComplete, {
  String loadingText = "><",
  String doneText = "[DONE]\n",
  Duration interval = const Duration(milliseconds: 100),
}) async {
  var dotCount = 0;
  final animationCompleter = Completer<void>();
  final timer = Timer.periodic(interval, (final timer) {
    stdout.write(loadingText[(dotCount++) % loadingText.length]);
    if (animationCompleter.isCompleted) {
      timer.cancel();
    }
  });
  await onComplete();
  animationCompleter.complete();
  timer.cancel();
  stdout.write(doneText);
  return dotCount * 500.0 / 1000.0;
}

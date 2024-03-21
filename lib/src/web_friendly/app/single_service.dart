//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:async';
import 'package:meta/meta.dart';

import '/src/web_friendly/_all_web_friendly.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// An abstract class that provides a way to manage an application service.
abstract class SingleService {
  //
  //
  //

  final SingleServiceCreator creator;
  final void Function(Object?)? onError;

  //
  //
  //

  const SingleService({
    required this.creator,
    required this.onError,
  });

  //
  //
  //

  /// Override this method with the init logic for the service.
  Future<void> init() async {}

  //
  //
  //

  /// Override this method with the dispose logic for the service.
  Future<void> dispose();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// An abstract class that provides a convenient way create a [SingleService]
/// instance.
abstract class SingleServiceCreator<T extends SingleService> {
  //
  //
  //

  /// The id of the service.
  final String? id;

  /// A callback that is called when an error occurs.
  late final void Function(Object?)? onError;

  /// The instance of the service.
  T? _instance;

  //
  //
  //

  SingleServiceCreator({
    this.id,
    required void Function(Object?)? onError,
  }) {
    this.onError = onError ??
        (e) {
          // Handle error silently.
          Here().debugLogError(e);
        };
  }

  //
  //
  //

  /// Override this method with the logic to create the service.
  @mustCallSuper
  Future<void> createService(T? instance) async {
    await (this._instance = instance)?.init();
    Here().debugLog(
      'Created service of type $T${this.id != null ? ' for ${this.id}' : ''}',
    );
  }

  //
  //
  //

  /// Returns the service instance or creates it if it doesn't exist.
  @mustCallSuper
  Future<T> getService() async {
    if (this._instance == null) {
      await createService(null);
    }
    return this._instance!;
  }

  //
  //
  //

  /// Disposes the service instance.
  @mustCallSuper
  Future<void> dispose() async {
    await this._instance?.dispose();
    this._instance = null;
    Here().debugLog(
      'Disposed service of type $T${this.id != null ? ' for ${this.id}' : ''}',
    );
  }
}

//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// X|Y|Z & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:async';

import '/shared_src/web_friendly/_all_web_friendly.g.dart';
import '/src/web_friendly/_all_web_friendly.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// An abstract class that provides a way to manage a [SingleService]
/// collection.
abstract class CollectiveService<T extends SingleService> {
  //
  //
  //

  /// A callback that is called when an error occurs.
  final void Function(Object?)? onError;

  //
  //
  //

  CollectiveService({
    required this.onError,
  });

  //
  //
  //

  /// Holds all the services in the collection.
  final allServices = <String, T>{};

  //
  //
  //

  /// Returns all the service keys in the collection.
  Set<String> get keys => this.allServices.keys.toSet();

  /// Returns all the services in the collection.
  Iterable<T> get values => this.allServices.values;

  //
  //
  //

  /// Updates the collection with the services and removes services.
  Future<void> update(Set<String> oldKeys, Set<String> newKeys) async {
    final addedKeys = getSetDifference(oldKeys, newKeys);
    final removedKeys = getSetDifference(newKeys, oldKeys);
    await Future.forEach(addedKeys, (final key) async {
      final temp = await this.addService(key);
      if (temp != null) this.allServices[key] = temp;
    });
    await this.removeServices(removedKeys);
  }

  //
  //
  //

  /// Adds a new service by [key] to the collection and returns the service.
  Future<T?> addService(String key);

  //
  //
  //

  /// Removes a service by [key] from the collection.
  Future<void> removeServices(Iterable<String> keys) async {
    await Future.forEach(
      keys,
      (String key) async => await this.allServices[key]?.dispose(),
    );
    this.allServices.removeWhere((final key, _) => keys.contains(key));
  }

  //
  //
  //

  /// Removes all services from the collection.
  Future<void> dispose() => this.removeServices(this.allServices.keys);
}

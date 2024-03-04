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

import '/src/shared/web_friendly/_all_web_friendly.g.dart';
import '/src/web_friendly/_all_web_friendly.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class CollectiveService<T extends SingleService> {
  //
  //
  //

  final void Function(Object?)? onError;

  //
  //
  //

  CollectiveService({required this.onError});

  //
  //
  //

  final allServices = <String, T>{};

  //
  //
  //

  Set<String> get keys => this.allServices.keys.toSet();
  Iterable<T> get values => this.allServices.values;

  //
  //
  //

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

  Future<T?> addService(String key);

  //
  //
  //

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

  Future<void> dispose() => this.removeServices(this.allServices.keys);
}

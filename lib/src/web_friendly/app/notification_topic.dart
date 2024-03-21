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

import 'package:equatable/equatable.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A method to help manage blocking and unblocking of notification topics for
/// Firebase Cloud Messaging or similar services.
class NotificationTopic extends Equatable {
  //
  //
  //

  final String? name;
  final String? subjectUid;
  final bool blocked;

  //
  //
  //

  const NotificationTopic({
    this.name,
    this.subjectUid,
    this.blocked = false,
  });

  factory NotificationTopic.fromString(String? input) {
    final a = input?.split(':');
    final b = a?.elementAtOrNull(0)?.split('__');
    final name = b?.elementAtOrNull(0);
    final subjectUid = a?.elementAtOrNull(1);
    final blocked = b?.elementAtOrNull(1) == 'BLOCKED';
    return NotificationTopic(
      name: name,
      subjectUid: subjectUid,
      blocked: blocked,
    );
  }

  //
  //
  //

  /// Copies the current instance and replaces the provided values.
  NotificationTopic copyWith({
    String? name,
    String? subjectUid,
    bool? blocked,
  }) {
    return NotificationTopic(
      name: name ?? this.name,
      subjectUid: subjectUid ?? this.subjectUid,
      blocked: blocked ?? this.blocked,
    );
  }

  //
  //
  //

  /// Returns a new instance with the provided [uid] blocked.
  NotificationTopic toBlocked([String? uid]) {
    return NotificationTopic(
      name: this.name,
      subjectUid: uid ?? this.subjectUid,
      blocked: true,
    );
  }

  /// Returns a new instance with the provided [uid] unblocked.
  NotificationTopic toUnblocked([String? uid]) {
    return NotificationTopic(
      name: this.name,
      subjectUid: uid ?? this.subjectUid,
      blocked: false,
    );
  }

  //
  //
  //

  @override
  String toString() {
    return "${this.name != null ? "${this.name}${this.blocked ? "__" : ""}" : ""}"
        "${this.blocked ? "BLOCKED" : ""}"
        "${this.subjectUid != null ? ":${this.subjectUid}" : ""}";
  }

  //
  //
  //

  @override
  List<Object?> get props {
    return [
      this.name,
      this.subjectUid,
      this.blocked,
    ];
  }
}

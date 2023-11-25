//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:equatable/equatable.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

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
    final a = input?.split(":");
    final b = a?.elementAtOrNull(0)?.split("__");
    final name = b?.elementAtOrNull(0);
    final subjectUid = a?.elementAtOrNull(1);
    final blocked = b?.elementAtOrNull(1) == "BLOCKED";
    return NotificationTopic(name: name, subjectUid: subjectUid, blocked: blocked);
  }

  //
  //
  //

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

  NotificationTopic toBlocked([String? subjectUid]) {
    return NotificationTopic(
      name: this.name,
      subjectUid: subjectUid ?? this.subjectUid,
      blocked: true,
    );
  }

  NotificationTopic toUnblocked() {
    return NotificationTopic(
      name: this.name,
      subjectUid: this.subjectUid,
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
  List<Object?> get props => [this.name, this.subjectUid, this.blocked];
}

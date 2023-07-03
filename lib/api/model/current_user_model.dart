// To parse this JSON data, do
//
//     final currentUser = userFromJson(jsonString);

import 'dart:convert';

CurrentUser currentUserFromJson(String str) =>
    CurrentUser.fromJson(json.decode(str));

String currentUserToJson(CurrentUser data) => json.encode(data.toJson());

class CurrentUser {
  int domainId;
  int moduleVersionId;
  int modulePhaseId;
  int cohortPhaseId;
  int currentUserId;

  CurrentUser({
    required this.domainId,
    required this.moduleVersionId,
    required this.modulePhaseId,
    required this.cohortPhaseId,
    required this.currentUserId,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
        domainId: json["domain_id"],
        moduleVersionId: json["module_version_id"],
        modulePhaseId: json["module_phase_id"],
        cohortPhaseId: json["cohort_phase_id"],
        currentUserId: json["current_user_id"],
      );

  Map<String, dynamic> toJson() => {
        "domain_id": domainId,
        "module_version_id": moduleVersionId,
        "module_phase_id": modulePhaseId,
        "cohort_phase_id": cohortPhaseId,
        "current_user_id": currentUserId,
      };
}

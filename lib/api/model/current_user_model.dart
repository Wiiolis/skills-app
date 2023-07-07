// To parse this JSON data, do
//
//     final currentUser = currentUserFromJson(jsonString);

import 'dart:convert';

CurrentUser currentUserFromJson(String str) =>
    CurrentUser.fromJson(json.decode(str));

String currentUserToJson(CurrentUser data) => json.encode(data.toJson());

class CurrentUser {
  Avatars avatars;
  String bio;
  dynamic birthDate;
  ClinicalRotation clinicalRotation;
  String countryId;
  DateTime createdAt;
  String firstName;
  String jobTitle;
  String lastName;
  ClinicalRotation links;
  String postNominalTitle;
  DateTime ppAcceptedAt;
  String preNominalTitle;
  Role role;
  String slug;
  dynamic studentId;
  String systemLanguage;
  bool teachingStaff;
  List<dynamic> teams;
  DateTime tosAcceptedAt;
  int userId;

  CurrentUser({
    required this.avatars,
    required this.bio,
    this.birthDate,
    required this.clinicalRotation,
    required this.countryId,
    required this.createdAt,
    required this.firstName,
    required this.jobTitle,
    required this.lastName,
    required this.links,
    required this.postNominalTitle,
    required this.ppAcceptedAt,
    required this.preNominalTitle,
    required this.role,
    required this.slug,
    this.studentId,
    required this.systemLanguage,
    required this.teachingStaff,
    required this.teams,
    required this.tosAcceptedAt,
    required this.userId,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
        avatars: Avatars.fromJson(json["avatars"]),
        bio: json["bio"],
        birthDate: json["birth_date"],
        clinicalRotation: ClinicalRotation.fromJson(json["clinical_rotation"]),
        countryId: json["country_id"],
        createdAt: DateTime.parse(json["created_at"]),
        firstName: json["first_name"],
        jobTitle: json["job_title"],
        lastName: json["last_name"],
        links: ClinicalRotation.fromJson(json["links"]),
        postNominalTitle: json["post_nominal_title"],
        ppAcceptedAt: DateTime.parse(json["pp_accepted_at"]),
        preNominalTitle: json["pre_nominal_title"],
        role: Role.fromJson(json["role"]),
        slug: json["slug"],
        studentId: json["student_id"],
        systemLanguage: json["system_language"],
        teachingStaff: json["teaching_staff"],
        teams: List<dynamic>.from(json["teams"].map((x) => x)),
        tosAcceptedAt: DateTime.parse(json["tos_accepted_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "avatars": avatars.toJson(),
        "bio": bio,
        "birth_date": birthDate,
        "clinical_rotation": clinicalRotation.toJson(),
        "country_id": countryId,
        "created_at": createdAt.toIso8601String(),
        "first_name": firstName,
        "job_title": jobTitle,
        "last_name": lastName,
        "links": links.toJson(),
        "post_nominal_title": postNominalTitle,
        "pp_accepted_at": ppAcceptedAt.toIso8601String(),
        "pre_nominal_title": preNominalTitle,
        "role": role.toJson(),
        "slug": slug,
        "student_id": studentId,
        "system_language": systemLanguage,
        "teaching_staff": teachingStaff,
        "teams": List<dynamic>.from(teams.map((x) => x)),
        "tos_accepted_at": tosAcceptedAt.toIso8601String(),
        "user_id": userId,
      };
}

class Avatars {
  String normal;
  String small;

  Avatars({
    required this.normal,
    required this.small,
  });

  factory Avatars.fromJson(Map<String, dynamic> json) => Avatars(
        normal: json["normal"],
        small: json["small"],
      );

  Map<String, dynamic> toJson() => {
        "normal": normal,
        "small": small,
      };
}

class ClinicalRotation {
  ClinicalRotation();

  factory ClinicalRotation.fromJson(Map<String, dynamic> json) =>
      ClinicalRotation();

  Map<String, dynamic> toJson() => {};
}

class Role {
  String code;
  String color;
  String label;
  bool primary;

  Role({
    required this.code,
    required this.color,
    required this.label,
    required this.primary,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        code: json["code"],
        color: json["color"],
        label: json["label"],
        primary: json["primary"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "color": color,
        "label": label,
        "primary": primary,
      };
}

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
  String cityOfResidence;
  ClinicalRotation clinicalRotation;
  String countryId;
  DateTime createdAt;
  String firstName;
  String jobTitle;
  String lastName;
  Links links;
  String personalQuote;
  DateTime ppAcceptedAt;
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
    required this.cityOfResidence,
    required this.clinicalRotation,
    required this.countryId,
    required this.createdAt,
    required this.firstName,
    required this.jobTitle,
    required this.lastName,
    required this.links,
    required this.personalQuote,
    required this.ppAcceptedAt,
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
        cityOfResidence: json["city_of_residence"],
        clinicalRotation: ClinicalRotation.fromJson(json["clinical_rotation"]),
        countryId: json["country_id"],
        createdAt: DateTime.parse(json["created_at"]),
        firstName: json["first_name"],
        jobTitle: json["job_title"],
        lastName: json["last_name"],
        links: Links.fromJson(json["links"]),
        personalQuote: json["personal_quote"],
        ppAcceptedAt: DateTime.parse(json["pp_accepted_at"]),
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
        "city_of_residence": cityOfResidence,
        "clinical_rotation": clinicalRotation.toJson(),
        "country_id": countryId,
        "created_at": createdAt.toIso8601String(),
        "first_name": firstName,
        "job_title": jobTitle,
        "last_name": lastName,
        "links": links.toJson(),
        "personal_quote": personalQuote,
        "pp_accepted_at": ppAcceptedAt.toIso8601String(),
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
  String groupName;
  int hospitalId;
  String hospitalName;
  int userGroupId;

  ClinicalRotation({
    required this.groupName,
    required this.hospitalId,
    required this.hospitalName,
    required this.userGroupId,
  });

  factory ClinicalRotation.fromJson(Map<String, dynamic> json) =>
      ClinicalRotation(
        groupName: json["group_name"],
        hospitalId: json["hospital_id"],
        hospitalName: json["hospital_name"],
        userGroupId: json["user_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "group_name": groupName,
        "hospital_id": hospitalId,
        "hospital_name": hospitalName,
        "user_group_id": userGroupId,
      };
}

class Links {
  String linkedinUrl;

  Links({
    required this.linkedinUrl,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        linkedinUrl: json["linkedin_url"],
      );

  Map<String, dynamic> toJson() => {
        "linkedin_url": linkedinUrl,
      };
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

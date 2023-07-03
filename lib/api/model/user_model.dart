// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  Avatars avatars;
  String bio;
  dynamic birthDate;
  String cityOfResidence;
  ClinicalRotation clinicalRotation;
  String countryId;
  DateTime createdAt;
  String firstName;
  String gender;
  String jobTitle;
  String lastName;
  ClinicalRotation links;
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

  User({
    required this.avatars,
    required this.bio,
    this.birthDate,
    required this.cityOfResidence,
    required this.clinicalRotation,
    required this.countryId,
    required this.createdAt,
    required this.firstName,
    required this.gender,
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

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatars: Avatars.fromJson(json["avatars"]),
        bio: json["bio"],
        birthDate: json["birth_date"],
        cityOfResidence: json["city_of_residence"],
        clinicalRotation: ClinicalRotation.fromJson(json["clinical_rotation"]),
        countryId: json["country_id"],
        createdAt: DateTime.parse(json["created_at"]),
        firstName: json["first_name"],
        gender: json["gender"],
        jobTitle: json["job_title"],
        lastName: json["last_name"],
        links: ClinicalRotation.fromJson(json["links"]),
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
        "gender": gender,
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

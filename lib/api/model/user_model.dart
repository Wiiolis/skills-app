import 'dart:convert';

class User {
  Avatars? avatars;
  String? bio;
  dynamic birthDate;
  String? cityOfResidence;
  ClinicalRotation? clinicalRotation;
  String? countryId;
  DateTime? createdAt;
  String? firstName;
  String? jobTitle;
  String? lastName;
  Links? links;
  String? personalQuote;
  DateTime? ppAcceptedAt;
  Role? role;
  String? slug;
  dynamic studentId;
  String? systemLanguage;
  bool? teachingStaff;
  List<dynamic>? teams;
  DateTime? tosAcceptedAt;
  int? userId;

  User({
    this.avatars,
    this.bio,
    this.birthDate,
    this.cityOfResidence,
    this.clinicalRotation,
    this.countryId,
    this.createdAt,
    this.firstName,
    this.jobTitle,
    this.lastName,
    this.links,
    this.personalQuote,
    this.ppAcceptedAt,
    this.role,
    this.slug,
    this.studentId,
    this.systemLanguage,
    this.teachingStaff,
    this.teams,
    this.tosAcceptedAt,
    this.userId,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatars:
            json["avatars"] == null ? null : Avatars.fromJson(json["avatars"]),
        bio: json["bio"],
        birthDate: json["birth_date"],
        cityOfResidence: json["city_of_residence"],
        clinicalRotation: json["clinical_rotation"] == null
            ? null
            : ClinicalRotation.fromJson(json["clinical_rotation"]),
        countryId: json["country_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        firstName: json["first_name"],
        jobTitle: json["job_title"],
        lastName: json["last_name"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        personalQuote: json["personal_quote"],
        ppAcceptedAt: json["pp_accepted_at"] == null
            ? null
            : DateTime.parse(json["pp_accepted_at"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        slug: json["slug"],
        studentId: json["student_id"],
        systemLanguage: json["system_language"],
        teachingStaff: json["teaching_staff"],
        teams: json["teams"] == null
            ? []
            : List<dynamic>.from(json["teams"]!.map((x) => x)),
        tosAcceptedAt: json["tos_accepted_at"] == null
            ? null
            : DateTime.parse(json["tos_accepted_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "avatars": avatars?.toJson(),
        "bio": bio,
        "birth_date": birthDate,
        "city_of_residence": cityOfResidence,
        "clinical_rotation": clinicalRotation?.toJson(),
        "country_id": countryId,
        "created_at": createdAt?.toIso8601String(),
        "first_name": firstName,
        "job_title": jobTitle,
        "last_name": lastName,
        "links": links?.toJson(),
        "personal_quote": personalQuote,
        "pp_accepted_at": ppAcceptedAt?.toIso8601String(),
        "role": role?.toJson(),
        "slug": slug,
        "student_id": studentId,
        "system_language": systemLanguage,
        "teaching_staff": teachingStaff,
        "teams": teams == null ? [] : List<dynamic>.from(teams!.map((x) => x)),
        "tos_accepted_at": tosAcceptedAt?.toIso8601String(),
        "user_id": userId,
      };
}

class Avatars {
  String? normal;
  String? small;

  Avatars({
    this.normal,
    this.small,
  });

  factory Avatars.fromRawJson(String str) => Avatars.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
  String? groupName;
  int? hospitalId;
  String? hospitalName;
  int? userGroupId;
  String? hospitalEmail;
  String? hospitalContact;

  ClinicalRotation({
    this.groupName,
    this.hospitalId,
    this.hospitalName,
    this.userGroupId,
    this.hospitalEmail,
    this.hospitalContact,
  });

  factory ClinicalRotation.fromRawJson(String str) =>
      ClinicalRotation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicalRotation.fromJson(Map<String, dynamic> json) =>
      ClinicalRotation(
        groupName: json["group_name"],
        hospitalId: json["hospital_id"],
        hospitalName: json["hospital_name"],
        userGroupId: json["user_group_id"],
        hospitalEmail: json["hospital_email"],
        hospitalContact: json["hospital_contact"],
      );

  Map<String, dynamic> toJson() => {
        "group_name": groupName,
        "hospital_id": hospitalId,
        "hospital_name": hospitalName,
        "user_group_id": userGroupId,
        "hospital_email": hospitalEmail,
        "hospital_contact": hospitalContact,
      };
}

class Links {
  String? instagramUrl;

  Links({
    this.instagramUrl,
  });

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        instagramUrl: json["instagram_url"],
      );

  Map<String, dynamic> toJson() => {
        "instagram_url": instagramUrl,
      };
}

class Role {
  String? code;
  String? color;
  String? label;
  bool? primary;

  Role({
    this.code,
    this.color,
    this.label,
    this.primary,
  });

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

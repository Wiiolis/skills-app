import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class User extends HiveObject {
  @HiveField(0)
  Avatars? avatars;
  @HiveField(1)
  String? bio;
  @HiveField(2)
  dynamic birthDate;
  @HiveField(3)
  String? cityOfResidence;
  @HiveField(4)
  ClinicalRotation? clinicalRotation;
  @HiveField(5)
  String? countryId;
  @HiveField(6)
  DateTime? createdAt;
  @HiveField(7)
  String? firstName;
  @HiveField(8)
  String? jobTitle;
  @HiveField(9)
  String? lastName;
  @HiveField(10)
  Links? links;
  @HiveField(11)
  String? personalQuote;
  @HiveField(12)
  DateTime? ppAcceptedAt;
  @HiveField(13)
  Role? role;
  @HiveField(14)
  String? slug;
  @HiveField(15)
  dynamic studentId;
  @HiveField(16)
  String? systemLanguage;
  @HiveField(17)
  bool? teachingStaff;
  @HiveField(18)
  List<dynamic>? teams;
  @HiveField(19)
  DateTime? tosAcceptedAt;
  @HiveField(20)
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

@HiveType(typeId: 5)
class Avatars {
  @HiveField(0)
  String? normal;
  @HiveField(1)
  String? small;

  Avatars({
    this.normal,
    this.small,
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

@HiveType(typeId: 6)
class ClinicalRotation {
  @HiveField(0)
  String? groupName;
  @HiveField(1)
  int? hospitalId;
  @HiveField(2)
  String? hospitalName;
  @HiveField(3)
  int? userGroupId;
  @HiveField(4)
  String? hospitalEmail;
  @HiveField(5)
  String? hospitalContact;

  ClinicalRotation({
    this.groupName,
    this.hospitalId,
    this.hospitalName,
    this.userGroupId,
    this.hospitalEmail,
    this.hospitalContact,
  });

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

@HiveType(typeId: 7)
class Links {
  @HiveField(0)
  String? instagramUrl;

  Links({
    this.instagramUrl,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        instagramUrl: json["instagram_url"],
      );

  Map<String, dynamic> toJson() => {
        "instagram_url": instagramUrl,
      };
}

@HiveType(typeId: 8)
class Role {
  @HiveField(0)
  String? code;
  @HiveField(1)
  String? color;
  @HiveField(2)
  String? label;
  @HiveField(3)
  bool? primary;

  Role({
    this.code,
    this.color,
    this.label,
    this.primary,
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

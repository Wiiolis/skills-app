// To parse this JSON data, do
//
//     final clinicalSkills = clinicalSkillsFromJson(jsonString);

import 'dart:convert';

class ClinicalSkills {
  String? name;
  Assessment? assessment;
  int? clinicalSkillId;

  ClinicalSkills({
    this.name,
    this.assessment,
    this.clinicalSkillId,
  });

  factory ClinicalSkills.fromRawJson(String str) =>
      ClinicalSkills.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicalSkills.fromJson(Map<String, dynamic> json) => ClinicalSkills(
        name: json["name"],
        assessment: json["assessment"] == null
            ? null
            : Assessment.fromJson(json["assessment"]),
        clinicalSkillId: json["clinical_skill_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "assessment": assessment?.toJson(),
        "clinical_skill_id": clinicalSkillId,
      };
}

class Assessment {
  String? level;
  Instructor? instructor;
  DateTime? assessmentDate;
  int? moduleVersionId;

  Assessment({
    this.level,
    this.instructor,
    this.assessmentDate,
    this.moduleVersionId,
  });

  factory Assessment.fromRawJson(String str) =>
      Assessment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        level: json["level"],
        instructor: json["instructor"] == null
            ? null
            : Instructor.fromJson(json["instructor"]),
        assessmentDate: json["assessment_date"] == null
            ? null
            : DateTime.parse(json["assessment_date"]),
        moduleVersionId: json["module_version_id"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "instructor": instructor?.toJson(),
        "assessment_date":
            "${assessmentDate!.year.toString().padLeft(4, '0')}-${assessmentDate!.month.toString().padLeft(2, '0')}-${assessmentDate!.day.toString().padLeft(2, '0')}",
        "module_version_id": moduleVersionId,
      };
}

class Instructor {
  String? fullName;
  String? department;
  int? hospitalId;

  Instructor({
    this.fullName,
    this.department,
    this.hospitalId,
  });

  factory Instructor.fromRawJson(String str) =>
      Instructor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        fullName: json["full_name"],
        department: json["department"],
        hospitalId: json["hospital_id"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "department": department,
        "hospital_id": hospitalId,
      };
}

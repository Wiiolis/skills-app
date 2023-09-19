import 'dart:convert';

class ClinicalSkills {
  String? name;
  String? level;
  String? module;
  Assessment? assessment;
  int? clinicalSkillId;

  ClinicalSkills({
    this.name,
    this.level,
    this.module,
    this.assessment,
    this.clinicalSkillId,
  });

  factory ClinicalSkills.fromRawJson(String str) =>
      ClinicalSkills.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicalSkills.fromJson(Map<String, dynamic> json) => ClinicalSkills(
        name: json["name"],
        level: json["level"],
        module: json["module"],
        assessment: json["assessment"] == null
            ? null
            : Assessment.fromJson(json["assessment"]),
        clinicalSkillId: json["clinical_skill_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "level": level,
        "module": module,
        "assessment": assessment?.toJson(),
        "clinical_skill_id": clinicalSkillId,
      };
}

class Assessment {
  String? level;
  InstructorCR? instructor;
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
            : InstructorCR.fromJson(json["instructor"]),
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

class InstructorCR {
  String? fullName;
  String? department;
  int? hospitalId;
  int? instructorId;

  InstructorCR({
    this.fullName,
    this.department,
    this.hospitalId,
    this.instructorId,
  });

  factory InstructorCR.fromRawJson(String str) =>
      InstructorCR.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InstructorCR.fromJson(Map<String, dynamic> json) => InstructorCR(
        fullName: json["full_name"],
        department: json["department"],
        hospitalId: json["hospital_id"],
        instructorId: json["instructor_id"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "department": department,
        "hospital_id": hospitalId,
        "instructor_id": instructorId,
      };
}

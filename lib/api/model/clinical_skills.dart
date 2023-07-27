// To parse this JSON data, do
//
//     final clinicalSkills = clinicalSkillsFromJson(jsonString);

import 'dart:convert';

class ClinicalSkills {
  String name;
  int clinicalSkillId;

  ClinicalSkills({
    required this.name,
    required this.clinicalSkillId,
  });

  factory ClinicalSkills.fromRawJson(String str) =>
      ClinicalSkills.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClinicalSkills.fromJson(Map<String, dynamic> json) => ClinicalSkills(
        name: json["name"],
        clinicalSkillId: json["clinical_skill_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "clinical_skill_id": clinicalSkillId,
      };
}

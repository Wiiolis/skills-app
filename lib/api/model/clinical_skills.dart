import 'dart:convert';

class ClinicalSkills {
  String? name;
  String? level;
  String? module;
  dynamic assessment;
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
        assessment: json["assessment"],
        clinicalSkillId: json["clinical_skill_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "level": level,
        "module": module,
        "assessment": assessment,
        "clinical_skill_id": clinicalSkillId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

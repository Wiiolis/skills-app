// To parse this JSON data, do
//
//     final Modules = ModulesFromJson(jsonString);

import 'dart:convert';

class Modules {
  int? moduleVersionId;
  int? version;
  dynamic description;
  String? name;
  String? slug;
  DateTime? startDate;
  DateTime? endDate;
  bool? disableUnits;

  Modules({
    this.moduleVersionId,
    this.version,
    this.description,
    this.name,
    this.slug,
    this.startDate,
    this.endDate,
    this.disableUnits,
  });

  factory Modules.fromRawJson(String str) => Modules.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Modules.fromJson(Map<String, dynamic> json) => Modules(
        moduleVersionId: json["module_version_id"],
        version: json["version"],
        description: json["description"],
        name: json["name"],
        slug: json["slug"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        disableUnits: json["disable_units"],
      );

  Map<String, dynamic> toJson() => {
        "module_version_id": moduleVersionId,
        "version": version,
        "description": description,
        "name": name,
        "slug": slug,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "disable_units": disableUnits,
      };
}

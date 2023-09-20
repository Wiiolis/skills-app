import 'package:hive/hive.dart';

@HiveType(typeId: 9)
class Modules extends HiveObject {
  @HiveField(0)
  int? moduleVersionId;
  @HiveField(1)
  int? version;
  @HiveField(2)
  dynamic description;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? slug;
  @HiveField(5)
  DateTime? startDate;
  @HiveField(6)
  DateTime? endDate;
  @HiveField(7)
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

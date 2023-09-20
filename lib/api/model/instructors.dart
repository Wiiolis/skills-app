// instructors.dart
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Instructors {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? instructorId;

  Instructors({
    this.name,
    this.instructorId,
  });

  factory Instructors.fromJson(Map<String, dynamic> json) => Instructors(
        name: json["full_name"],
        instructorId: json["instructor_id"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": name,
        "instructor_id": instructorId,
      };
}

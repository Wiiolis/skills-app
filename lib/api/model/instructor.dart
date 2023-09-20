import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Instructor extends HiveObject {
  @HiveField(0)
  int? instructorId;

  Instructor({
    this.instructorId,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        instructorId: json["instructor_id"],
      );

  Map<String, dynamic> toJson() => {
        "instructor_id": instructorId,
      };
}

import 'dart:convert';

class Instructor {
  int? instructorId;

  Instructor({
    this.instructorId,
  });

  factory Instructor.fromRawJson(String str) =>
      Instructor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        instructorId: json["instructor_id"],
      );

  Map<String, dynamic> toJson() => {
        "instructor_id": instructorId,
      };
}

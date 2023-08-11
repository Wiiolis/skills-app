// To parse this JSON data, do
//
//     final instructors = instructorsFromJson(jsonString);

import 'dart:convert';

class Instructors {
  String? name;
  int? instructorId;

  Instructors({
    this.name,
    this.instructorId,
  });

  factory Instructors.fromRawJson(String str) =>
      Instructors.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Instructors.fromJson(Map<String, dynamic> json) => Instructors(
        name: json["full_name"],
        instructorId: json["instructor_id"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": name,
        "instructor_id": instructorId,
      };
}

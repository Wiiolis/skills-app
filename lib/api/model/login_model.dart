// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  int userId;
  String state;
  List<UserRole> userRoles;

  Login({
    required this.userId,
    required this.state,
    required this.userRoles,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        userId: json["user_id"],
        state: json["state"],
        userRoles: List<UserRole>.from(
            json["user_roles"].map((x) => UserRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "state": state,
        "user_roles": List<dynamic>.from(userRoles.map((x) => x.toJson())),
      };
}

class UserRole {
  String roleCode;
  bool isPrimary;
  bool teachingRole;

  UserRole({
    required this.roleCode,
    required this.isPrimary,
    required this.teachingRole,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        roleCode: json["role_code"],
        isPrimary: json["is_primary"],
        teachingRole: json["teaching_role"],
      );

  Map<String, dynamic> toJson() => {
        "role_code": roleCode,
        "is_primary": isPrimary,
        "teaching_role": teachingRole,
      };
}

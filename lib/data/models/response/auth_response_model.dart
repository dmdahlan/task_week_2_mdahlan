import 'package:meta/meta.dart';
import 'dart:convert';

class AuthResponseModel {
  final User user;
  final String role;
  final String token;

  AuthResponseModel({
    required this.user,
    required this.role,
    required this.token,
  });

  factory AuthResponseModel.fromRawJson(String str) =>
      AuthResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        user: User.fromJson(json["user"]),
        role: json["role"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "role": role,
        "token": token,
      };
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final DateTime emailVerifiedAt;
  final dynamic createdAt;
  final DateTime updatedAt;
  final List<Role> roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}

class Role {
  final int id;
  final String name;
  final String guardName;
  final dynamic createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  final String modelType;
  final int modelId;
  final int roleId;

  Pivot({
    required this.modelType,
    required this.modelId,
    required this.roleId,
  });

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelType: json["model_type"],
        modelId: json["model_id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "model_type": modelType,
        "model_id": modelId,
        "role_id": roleId,
      };
}

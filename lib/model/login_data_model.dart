import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) => LoginDataModel.fromJson(json.decode(str));

String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  String? status;
  User? user;

  LoginDataModel({
    this.status,
    this.user,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
    status: json["status"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user?.toJson(),
  };
}

class User {
  String? phone;
  bool? active;
  DateTime? createdAt;
  String? role;
  DateTime? updatedAt;
  String? id;

  User({
    this.phone,
    this.active,
    this.createdAt,
    this.role,
    this.updatedAt,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    phone: json["phone"],
    active: json["active"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    role: json["role"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "active": active,
    "createdAt": createdAt?.toIso8601String(),
    "role": role,
    "updatedAt": updatedAt?.toIso8601String(),
    "id": id,
  };
}

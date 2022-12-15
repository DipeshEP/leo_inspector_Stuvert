// To parse this JSON data, do
//
//     final adminModel = adminModelFromJson(jsonString);

import 'dart:convert';

AdminModel adminModelFromJson(String str) => AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  AdminModel({
    this.admin,
  });

  Admin? admin;

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
  );

  Map<String, dynamic> toJson() => {
    "admin": admin == null ? null : admin!.toJson(),
  };
}

class Admin {
  Admin({
    this.adminId,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.empId,
    this.createdAt,
    this.updatedAt,
    this.cmpId,
    this.profileImageUrl,
  });

  String? adminId;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? empId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? cmpId;
  String? profileImageUrl;


  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    adminId: json["adminId"] == null ? null : json["adminId"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    empId: json["empId"] == null ? null : json["empId"],
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    cmpId: json["cmpId"] == null ? null : json["cmpId"],
  );

  Map<String, dynamic> toJson() => {
    "adminId": adminId == null ? null : adminId,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
    "empId": empId == null ? null : empId,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "cmpId": cmpId == null ? null : cmpId,
  };
}

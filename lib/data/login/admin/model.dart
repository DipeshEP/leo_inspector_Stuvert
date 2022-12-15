// To parse this JSON data, do
//
//     final adminLoginModel = adminLoginModelFromJson(jsonString);

import 'dart:convert';

AdminLoginModel adminLoginModelFromJson(String str) => AdminLoginModel.fromJson(json.decode(str));

String adminLoginModelToJson(AdminLoginModel data) => json.encode(data.toJson());

class AdminLoginModel {
  AdminLoginModel({
    this.jwtAccessToken,
    this.jwtRefreshToken,
    this.userId,
    this.name,
  });

  String? jwtAccessToken;
  String? jwtRefreshToken;
  String? userId;
  String? name;

  factory AdminLoginModel.fromJson(Map<String, dynamic> json) => AdminLoginModel(
    jwtAccessToken: json["jwtAccessToken"] == null ? null : json["jwtAccessToken"],
    jwtRefreshToken: json["jwtRefreshToken"] == null ? null : json["jwtRefreshToken"],
    userId: json["userId"] == null ? null : json["userId"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "jwtAccessToken": jwtAccessToken,
    "jwtRefreshToken": jwtRefreshToken,
    "userId": userId,
    "name": name,
  };
}

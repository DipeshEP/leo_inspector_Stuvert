// To parse this JSON data, do
//
//     final adminLoginModel = adminLoginModelFromJson(jsonString);

import 'dart:convert';

InspectorLoginModel inspectorLoginModelFromJson(String str) => InspectorLoginModel.fromJson(json.decode(str));

String inspectorLoginModelToJson(InspectorLoginModel data) => json.encode(data.toJson());

class InspectorLoginModel {
  InspectorLoginModel({
    this.jwtAccessToken,
    this.jwtRefreshToken,
    this.userId,
    this.name,
  });

  String? jwtAccessToken;
  String? jwtRefreshToken;
  String? userId;
  String? name;

  factory InspectorLoginModel.fromJson(Map<String, dynamic> json) => InspectorLoginModel(
    jwtAccessToken: json["jwtAccessToken"] == null ? null : json["jwtAccessToken"],
    jwtRefreshToken: json["jwtRefreshToken"] == null ? null : json["jwtRefreshToken"],
    userId: json["userId"] == null ? null : json["userId"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "jwtAccessToken": jwtAccessToken == null ? null : jwtAccessToken,
    "jwtRefreshToken": jwtRefreshToken == null ? null : jwtRefreshToken,
    "userId": userId == null ? null : userId,
    "name": name == null ? null : name,
  };
}

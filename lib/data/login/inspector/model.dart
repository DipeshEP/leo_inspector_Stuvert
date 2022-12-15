/*
// To parse this JSON data, do
//
//     final inspectorLogin = inspectorLoginFromJson(jsonString);

import 'dart:convert';

InspectorLoginModel inspectorLoginFromJson(String str) => InspectorLoginModel.fromJson(json.decode(str));

String inspectorLoginToJson(InspectorLoginModel data) => json.encode(data.toJson());

class InspectorLoginModel {
  InspectorLoginModel({
    required this.jwtAccessToken,
    required this.jwtRefreshToken,
  });

  String jwtAccessToken;
  String jwtRefreshToken;

  factory InspectorLoginModel.fromJson(Map<String, dynamic> json) => InspectorLoginModel(
    jwtAccessToken: json["jwtAccessToken"],
    jwtRefreshToken: json["jwtRefreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "jwtAccessToken": jwtAccessToken,
    "jwtRefreshToken": jwtRefreshToken,
  };
}
*/

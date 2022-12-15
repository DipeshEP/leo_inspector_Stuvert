// To parse this JSON data, do
//
//     final clientLogin = clientLoginFromJson(jsonString);

import 'dart:convert';

ClientLoginModel clientLoginFromJson(String str) => ClientLoginModel.fromJson(json.decode(str));

String clientLoginToJson(ClientLoginModel data) => json.encode(data.toJson());

class ClientLoginModel {
  ClientLoginModel({
    required this.jwtAccessToken,
    required this.jwtRefreshToken,
  });

  String jwtAccessToken;
  String jwtRefreshToken;

  factory ClientLoginModel.fromJson(Map<String, dynamic> json) => ClientLoginModel(
    jwtAccessToken: json["jwtAccessToken"],
    jwtRefreshToken: json["jwtRefreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "jwtAccessToken": jwtAccessToken,
    "jwtRefreshToken": jwtRefreshToken,
  };
}

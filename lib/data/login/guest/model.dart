// To parse this JSON data, do
//
//     final guestLogin = guestLoginFromJson(jsonString);

import 'dart:convert';

GuestLoginModel guestLoginFromJson(String str) => GuestLoginModel.fromJson(json.decode(str));

String guestLoginToJson(GuestLoginModel data) => json.encode(data.toJson());

class GuestLoginModel {
  GuestLoginModel({
    required this.jwtAccessToken,
    required this.jwtRefreshToken,
  });

  String jwtAccessToken;
  String jwtRefreshToken;

  factory GuestLoginModel.fromJson(Map<String, dynamic> json) => GuestLoginModel(
    jwtAccessToken: json["jwtAccessToken"],
    jwtRefreshToken: json["jwtRefreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "jwtAccessToken": jwtAccessToken,
    "jwtRefreshToken": jwtRefreshToken,
  };
}

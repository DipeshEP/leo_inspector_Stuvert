// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

import 'company_model.dart';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  ClientModel({
    this.client,
  });

  List<Client>? client;

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    client: json["client"] == null ? null : List<Client>.from(json["client"].map((x) => Client.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "client": client == null ? null : List<dynamic>.from(client!.map((x) => x.toJson())),
  };
}


ClientListModel clientListModelFromJson(String str) => ClientListModel.fromJson(json.decode(str));

String clientListModelToJson(ClientListModel data) => json.encode(data.toJson());

class ClientListModel {
  ClientListModel({
    this.client,
  });

  Client? client;

  factory ClientListModel.fromJson(Map<String, dynamic> json) => ClientListModel(
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "client": client == null ? null : client!.toJson(),
  };
}


class Client {
  Client({
    this.clientId,
    this.email,
    this.password,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.cmpId,
    this.profileImageUrl,
    this.company,
  });

  String? clientId;
  String? email;
  String? password;
  String? name;
  String? phone;
  DateTime? createdAt;
  String? profileImageUrl;
  DateTime? updatedAt;
  String? cmpId;
  Company? company;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    clientId: json["clientId"] == null ? null : json["clientId"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
    cmpId: json["cmpId"] == null ? null : json["cmpId"],
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId == null ? null : clientId,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "cmpId": cmpId == null ? null : cmpId,
    "company": company == null ? null : company!.toJson(),
  };
}

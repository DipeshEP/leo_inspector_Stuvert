// To parse this JSON data, do
//
//     final inspectorModel = inspectorModelFromJson(jsonString);

import 'dart:convert';

import 'package:leo_inspector/Model/company_model.dart';

InspectorModel inspectorModelFromJson(String str) => InspectorModel.fromJson(json.decode(str));

String inspectorModelToJson(InspectorModel data) => json.encode(data.toJson());

class InspectorModel {
  InspectorModel({
    this.inspector,
  });

  Inspector? inspector;

  factory InspectorModel.fromJson(Map<String, dynamic> json) => InspectorModel(
    inspector: json["inspector"] == null ? null : Inspector.fromJson(json["inspector"]),
  );

  Map<String, dynamic> toJson() => {
    "inspector": inspector == null ? null : inspector!.toJson(),
  };
}

class Inspector {
  Inspector({
    this.inspectorId,
    this.empId,
    this.name,
    this.phone,
    this.signatureUrl,
    this.profileImageUrl,
    this.email,
    this.password,
    this.inspectorType,
    this.createdAt,
    this.updatedAt,
    this.cmpId,
    this.company,
  });

  String? inspectorId;
  String? empId;
  String? name;
  String? phone;
  String? signatureUrl;
  String? profileImageUrl;
  String? email;
  String? password;
  String? inspectorType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? cmpId;
  Company? company;

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
    inspectorId: json["inspectorId"] == null ? null : json["inspectorId"],
    empId: json["empId"] == null ? null : json["empId"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    signatureUrl: json["signatureUrl"] == null ? null : json["signatureUrl"],
    profileImageUrl: json["profileImageUrl"] == null ? null : json["profileImageUrl"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    inspectorType: json["inspectorType"] == null ? null : json["inspectorType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    cmpId: json["cmpId"] == null ? null : json["cmpId"],
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "inspectorId": inspectorId == null ? null : inspectorId,
    "empId": empId == null ? null : empId,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "signatureUrl": signatureUrl == null ? null : signatureUrl,
    "profileImageUrl": profileImageUrl == null ? null : profileImageUrl,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "inspectorType": inspectorType == null ? null : inspectorType,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "cmpId": cmpId == null ? null : cmpId,
    "company": company == null ? null : company!.toJson(),
  };
}

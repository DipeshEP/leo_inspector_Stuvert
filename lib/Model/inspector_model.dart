// To parse this JSON data, do
//
//     final inspectorModel = inspectorModelFromJson(jsonString);

import 'dart:convert';

import 'company_model.dart';
import 'inspector_model2.dart';

InspectorListModel inspectorListModelFromJson(String str) => InspectorListModel.fromJson(json.decode(str));

String inspectorListModelToJson(InspectorListModel data) => json.encode(data.toJson());

class InspectorListModel {
  InspectorListModel({
    this.inspectors,
  });

  List<Inspector>? inspectors;

  factory InspectorListModel.fromJson(Map<String, dynamic> json) => InspectorListModel(
    inspectors: json["inspector"] == null ? null : List<Inspector>.from(json["inspector"].map((x) => Inspector.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "inspector": inspectors == null ? null : List<dynamic>.from(inspectors!.map((x) => x.toJson())),
  };
}

/*InspectorModel inspectorModelFromJson(String str) => InspectorModel.fromJson(json.decode(str));

String inspectorModelToJson(InspectorModel data) => json.encode(data.toJson());

class InspectorModel {
  InspectorModel({
    this.inspector
  });

  Inspector? inspector;

  factory InspectorModel.fromJson(Map<String, dynamic> json) => InspectorModel(
    inspector: json["inspector"] == null ? null : Inspector.fromJson(json["inspector"]),
  );

  Map<String, dynamic> toJson() => {
    "inspector": inspector!.toJson(),
  };
}*/

/*
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
    this.question,
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
  List<QuestionOption>? question;
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
    question: json["question"] == null ? null : List<QuestionOption>.from(json["question"].map((x) => Inspector.fromJson(x))),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "inspectorId": inspectorId,
    "empId": empId,
    "name": name,
    "phone": phone,
    "signatureUrl": signatureUrl,
    "profileImageUrl": profileImageUrl,
    "email": email,
    "password": password,
    "inspectorType": inspectorType,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "cmpId": cmpId,
    "question": List<dynamic>.from(question!.map((x) => x)),
    "company": company!.toJson(),
  };
}
*/


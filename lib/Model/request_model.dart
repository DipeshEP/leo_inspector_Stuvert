// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

import 'company_model.dart';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  RequestModel({
    this.manegeRequest,
  });

  List<ManegeRequest>? manegeRequest;

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
    manegeRequest: List<ManegeRequest>.from(json["manegeRequest"].map((x) => ManegeRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "manegeRequest": manegeRequest == null ? null : List<dynamic>.from(manegeRequest!.map((x) => x.toJson())),
  };
}

class ManegeRequest {
  ManegeRequest({
    this.manegeRequestId,
    this.inspectionLocation,
    this.inspectionDate,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.cmpId,
    this.company
  });

  String? manegeRequestId;
  String? inspectionLocation;
  DateTime? inspectionDate;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? cmpId;
  Company? company;


  factory ManegeRequest.fromJson(Map<String, dynamic> json) => ManegeRequest(
    manegeRequestId: json["manegeRequestId"] == null ? null : json["manegeRequestId"],
    inspectionLocation: json["inspectionLocation"] == null ? null : json["inspectionLocation"],
    inspectionDate: json["inspectionDate"] == null ? null : DateTime.parse(json["inspectionDate"]),
    phone: json["phone"] == null ? null : json["phone"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    cmpId: json["cmpId"] == null ? null : json["cmpId"],
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "manegeRequestId": manegeRequestId == null ? null : manegeRequestId,
    "inspectionLocation": inspectionLocation == null ? null : inspectionLocation,
    "inspectionDate": "${inspectionDate!.year.toString().padLeft(4, '0')}-${inspectionDate!.month.toString().padLeft(2, '0')}-${inspectionDate!.day.toString().padLeft(2, '0')}",
    "phone": phone == null ? null : phone,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "cmpId": cmpId == null ? null : cmpId,
    "company": company == null ? null : company!.toJson(),
  };
}

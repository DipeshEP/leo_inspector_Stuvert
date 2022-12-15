/*
import 'dart:convert';
import 'inspector_model.dart';

CertificateModel certificateModelFromJson(String str) => CertificateModel.fromJson(json.decode(str));

String certificateModelToJson(CertificateModel data) => json.encode(data.toJson());

class CertificateModel {
  CertificateModel({
    this.certificate,
  });

  List<Certificate>? certificate;

  factory CertificateModel.fromJson(Map<String, dynamic> json) => CertificateModel(
    certificate: List<Certificate>.from(json["certificate"].map((x) => Certificate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "certificate": List<dynamic>.from(certificate!.map((x) => x.toJson())),
  };
}

class Certificate {
  Certificate({
    this.certificateId,
    this.certificatePdf,
    this.certificateVersion,
    this.certificateRowData,
    this.createdAt,
    this.updatedAt,
    this.inspectorId,
    this.inspector,
  });

  String? certificateId;
  String? certificatePdf;
  String? certificateVersion;
  String? certificateRowData;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? inspectorId;
  Inspector? inspector;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    certificateId: json["certificateId"] == null ? null : json["certificateId"],
    certificatePdf: json["certificatePdf"] == null ? null : json["certificatePdf"],
    certificateVersion: json["certificateVersion"] == null ? null : json["certificateVersion"],
    certificateRowData: json["certificateRowData"] == null ? null : json["certificateRowData"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    inspectorId: json["inspectorId"] == null ? null : json["inspectorId"],
    inspector: json["inspector"] == null ? null : Inspector.fromJson(json["inspector"]),
  );

  Map<String, dynamic> toJson() => {
    "certificateId": certificateId,
    "certificatePdf": certificatePdf,
    "certificateVersion": certificateVersion,
    "certificateRowData": certificateRowData,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "inspectorId": inspectorId,
    "inspector": inspector!.toJson(),
  };
}
*/

import 'dart:convert';

import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Model/inspector_model.dart';

import 'client_model.dart';
import 'inspector_model2.dart';

CertificateModel certificateModelFromJson(String str) => CertificateModel.fromJson(json.decode(str));

String certificateModelToJson(CertificateModel data) => json.encode(data.toJson());

class CertificateModel {
  CertificateModel({
    this.certificate,
  });

  List<Certificate>? certificate;

  factory CertificateModel.fromJson(Map<String, dynamic> json) => CertificateModel(
    certificate: json["certificate"] == null ? null : List<Certificate>.from(json["certificate"].map((x) => Certificate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "certificate": certificate == null ? null : List<dynamic>.from(certificate!.map((x) => x.toJson())),
  };
}

class Certificate {
  Certificate({
    this.certificateId,
    this.certificatePdf,
    this.certificateVersion,
    this.certificateRowData,
    this.details,
    this.createdAt,
    this.updatedAt,
    this.inspectorId,
    this.cmpId,
    this.clientId,
    this.authorizerId,
    this.inspectionStatus,
    this.inspector,
    this.client,
    this.company,
  });

  String? certificateId;
  String? certificatePdf;
  String? certificateVersion;
  String? certificateRowData;
  String? details;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? inspectorId;
  String? cmpId;
  String? clientId;
  String? authorizerId;
  String? inspectionStatus;
  Inspector? inspector;
  Client? client;
  Company? company;

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    certificateId: json["certificateId"] == null ? null : json["certificateId"],
    certificatePdf: json["certificatePdf"] == null ? null : json["certificatePdf"],
    certificateVersion: json["certificateVersion"] == null ? null : json["certificateVersion"],
    certificateRowData: json["certificateRowData"] == null ? null : json["certificateRowData"],
    details: json["details"] == null ? null : json["details"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    inspectorId: json["inspectorId"] == null ? null : json["inspectorId"],
    cmpId: json["cmpId"] == null ? null : json["cmpId"],
    clientId: json["clientId"] == null ? null : json["clientId"],
    authorizerId: json["authorizerId"] == null ? null : json["authorizerId"],
    inspectionStatus: json["inspectionStatus"] == null ? null : json["inspectionStatus"],
    inspector: json["inspector"] == null ? null : Inspector.fromJson(json["inspector"]),
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "certificateId": certificateId == null ? null : certificateId,
    "certificatePdf": certificatePdf == null ? null : certificatePdf,
    "certificateVersion": certificateVersion == null ? null : certificateVersion,
    "certificateRowData": certificateRowData == null ? null : certificateRowData,
    "details": details == null ? null : details,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "inspectorId": inspectorId == null ? null : inspectorId,
    "cmpId": cmpId == null ? null : cmpId,
    "clientId": clientId == null ? null : clientId,
    "authorizerId": authorizerId == null ? null : authorizerId,
    "inspectionStatus": inspectionStatus == null ? null : inspectionStatus,
    "inspector": inspector == null ? null : inspector!.toJson(),
    "client": client == null ? null : client!.toJson(),
    "company": company == null ? null : company!.toJson(),
  };
}


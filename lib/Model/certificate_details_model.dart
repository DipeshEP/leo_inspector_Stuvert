import 'dart:convert';

import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Model/inspector_model.dart';

import 'inspector_model2.dart';

CertificateDetailsModel certificateDetailsModelFromJson(String str) => CertificateDetailsModel.fromJson(json.decode(str));

String certificateDetailsModelToJson(CertificateDetailsModel data) => json.encode(data.toJson());

class CertificateDetailsModel {
  CertificateDetailsModel({
    this.questionOption,
    this.certificateNo,
    this.authInspector,
    this.surveyInspector
  });

  QuestionOption? questionOption;
  String? certificateNo;
  Inspector? surveyInspector;
  Inspector? authInspector;

  factory CertificateDetailsModel.fromJson(Map<String, dynamic> json) => CertificateDetailsModel(
    questionOption: json["questionOption"] == null ? null : QuestionOption.fromJson(json["questionOption"]),
    surveyInspector: json["surveyor"] == null ? null : Inspector.fromJson(json["surveyor"]),
    authInspector: json["authorised"] == null ? null : Inspector.fromJson(json["authorised"]),
    certificateNo: json["certificateNo"] == null ? null : json["certificateNo"],
  );

  Map<String, dynamic> toJson() => {
    "questionOption": questionOption == null ? null : questionOption!.toJson(),
    "surveyor": surveyInspector == null ? null : surveyInspector!.toJson(),
    "authorised": authInspector == null ? null : authInspector!.toJson(),
    "certificateNo": certificateNo == null ? null : certificateNo,
  };
}

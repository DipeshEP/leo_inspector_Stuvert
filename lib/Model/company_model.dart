// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

CompanyListModel companyModelFromJson(String str) => CompanyListModel.fromJson(json.decode(str));

String companyModelToJson(CompanyListModel data) => json.encode(data.toJson());

class CompanyListModel {
  CompanyListModel({
    this.companies,
    this.company
  });

  List<Company>? companies;
  Company? company;

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
    companies: json["company"] == null ? null : List<Company>.from(json["company"].map((x) => Company.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "company": companies == null ? null :List<dynamic>.from(companies!.map((x) => x.toJson())),
  };
}

class CompanyModel {
  CompanyModel({
    this.company
  });

  Company? company;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "company": company == null ? null :company!.toJson(),
  };
}

class Company {
  Company({
    this.companyId,
    this.name,
    this.email,
    this.phone,
    this.logoUrl,
    this.address,
    this.contactPerson,
    this.createdAt,
    this.updatedAt,
    this.admin,
    this.client,
    this.inspector,
    this.license,
    this.questionOption,
    this.count,
  });

  String? companyId;
  String? name;
  String? email;
  String? phone;
  String? logoUrl;
  String? address;
  String? contactPerson;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Admin>? admin;
  List<Admin>? client;
  List<Admin>? inspector;
  List<dynamic>? license;
  List<QuestionOption>? questionOption;
  Count? count;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    companyId: json["companyId"] == null ? null : json["companyId"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    logoUrl: json["logoUrl"] == null ? null : json["logoUrl"],
    address: json["address"] == null ? null : json["address"],
    contactPerson: json["contactPerson"] == null ? null : json["contactPerson"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    admin: json["admin"] == null ? null : List<Admin>.from(json["admin"].map((x) => Admin.fromJson(x))),
    client: json["client"] == null ? null : List<Admin>.from(json["client"].map((x) => Admin.fromJson(x))),
    inspector: json["inspector"] == null ? null : List<Admin>.from(json["inspector"].map((x) => Admin.fromJson(x))),
    license: json["license"] == null ? null : List<dynamic>.from(json["license"].map((x) => x)),
    questionOption: json["questionOption"] == null ? null : List<QuestionOption>.from(json["questionOption"].map((x) => QuestionOption.fromJson(x))),
    count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
  );

  Map<String, dynamic> toJson() => {
    "companyId": companyId == null ? null : companyId,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "logoUrl": logoUrl == null ? null : logoUrl,
    "address": address == null ? null : address,
    "contactPerson": contactPerson == null ? null : contactPerson,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "admin": admin == null ? null : List<dynamic>.from(admin!.map((x) => x.toJson())),
    "client": client == null ? null : List<dynamic>.from(client!.map((x) => x.toJson())),
    "inspector": inspector == null ? null : List<dynamic>.from(inspector!.map((x) => x.toJson())),
    "license": license == null ? null : List<dynamic>.from(license!.map((x) => x)),
    "questionOption": questionOption == null ? null : List<dynamic>.from(questionOption!.map((x) => x.toJson())),
    "_count": count == null ? null : count!.toJson(),
  };
}

class Admin {
  Admin({
    this.adminId,
    this.name,
    this.email,
    this.phone,
    this.cmpId,
    this.empId,
    this.createdAt,
    this.updatedAt,
    this.clientId,
    this.inspectorId,
    this.question,
  });

  String? adminId;
  String? name;
  String? email;
  String? phone;
  String? cmpId;
  dynamic empId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? clientId;
  String? inspectorId;
  List<dynamic>? question;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    adminId: json["adminId"] == null ? null : json["adminId"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    cmpId: json["cmpId"] == null ? null : json["cmpId"],
    empId: json["empId"] == null ? null : json["empId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    clientId: json["clientId"] == null ? null : json["clientId"],
    inspectorId: json["inspectorId"] == null ? null : json["inspectorId"],
    question: json["question"] == null ? null : List<dynamic>.from(json["question"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "adminId": adminId == null ? null : adminId,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "cmpId": cmpId == null ? null : cmpId,
    "empId": empId == null ? null : empId,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "clientId": clientId == null ? null : clientId,
    "inspectorId": inspectorId == null ? null : inspectorId,
    "question": question == null ? null : List<dynamic>.from(question!.map((x) => x)),
  };
}

class Count {
  Count({
    this.admin,
    this.client,
    this.inspector,
    this.license,
    this.questionOption,
    this.notification,
  });

  int? admin;
  int? client;
  int? inspector;
  int? license;
  int? questionOption;
  int? notification;

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    admin: json["admin"] == null ? null : json["admin"],
    client: json["client"] == null ? null : json["client"],
    inspector: json["inspector"] == null ? null : json["inspector"],
    license: json["license"] == null ? null : json["license"],
    questionOption: json["questionOption"] == null ? null : json["questionOption"],
    notification: json["notification"] == null ? null : json["notification"],
  );

  Map<String, dynamic> toJson() => {
    "admin": admin == null ? null : admin,
    "client": client == null ? null : client,
    "inspector": inspector == null ? null : inspector,
    "license": license == null ? null : license,
    "questionOption": questionOption == null ? null : questionOption,
    "notification": notification == null ? null : notification,
  };
}

class QuestionOption {
  QuestionOption({
    this.cmpId,
    this.question,
    this.equipmentName,
    this.equipmentType,
    this.questionOptionId,
  });

  String? cmpId;
  List<Question>? question;
  String? equipmentName;
  String? equipmentType;
  String? questionOptionId;

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
    cmpId: json["cmpId"] == null ? null : json["cmpId"],
    question: json["question"] == null ? null : List<Question>.from(json["question"].map((x) => Question.fromJson(x))),
    equipmentName: json["equipmentName"] == null ? null : json["equipmentName"],
    equipmentType: json["equipmentType"] == null ? null : json["equipmentType"],
    questionOptionId: json["questionOptionId"] == null ? null : json["questionOptionId"],
  );

  Map<String, dynamic> toJson() => {
    "cmpId": cmpId == null ? null : cmpId,
    "question": question == null ? null : List<dynamic>.from(question!.map((x) => x.toJson())),
    "equipmentName": equipmentName == null ? null : equipmentName,
    "equipmentType": equipmentType == null ? null : equipmentType,
    "questionOptionId": questionOptionId == null ? null : questionOptionId,
  };
}

class Question {
  Question({
    this.questionId,
    this.question,
    this.answer,
    this.type,
    this.dropdownOptions,
  });

  String? questionId;
  String? question;
  String? answer;
  String? type;
  List<DropdownOption>? dropdownOptions;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["questionId"] == null ? null : json["questionId"],
    question: json["question"] == null ? null : json["question"],
    answer: json["answer"] == null ? null : json["answer"],
    type: json["type"] == null ? null : json["type"],
    dropdownOptions: json["dropdownOptions"] == null ? null : List<DropdownOption>.from(json["dropdownOptions"].map((x) => DropdownOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId == null ? null : questionId,
    "question": question == null ? null : question,
    "answer": answer == null ? null : answer,
    "type": type == null ? null : type,
    "dropdownOptions": dropdownOptions == null ? null : List<dynamic>.from(dropdownOptions!.map((x) => x.toJson())),
  };
}

class DropdownOption {
  DropdownOption({
    this.option,
    this.downOptionsId,
  });

  String? option;
  String? downOptionsId;

  factory DropdownOption.fromJson(Map<String, dynamic> json) => DropdownOption(
    option: json["option"] == null ? null : json["option"],
    downOptionsId: json["downOptionsId"] == null ? null : json["downOptionsId"],
  );

  Map<String, dynamic> toJson() => {
    "option": option == null ? null :option,
    "downOptionsId": downOptionsId == null ? null :downOptionsId,
  };
}

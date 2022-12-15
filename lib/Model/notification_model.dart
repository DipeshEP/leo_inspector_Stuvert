// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

import 'company_model.dart';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.notification,
  });

  List<Notification>? notification;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    notification: List<Notification>.from(json["notification"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notification": notification == null ? null : List<dynamic>.from(notification!.map((x) => x.toJson())),
  };
}

class Notification {
  Notification({
    this.message,
    this.notificationId,
    this.notificationType,
    this.company,
    this.createdAt,

  });

  String? message;
  String? notificationId;
  String? notificationType;
  Company? company;
  DateTime? createdAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    message: json["message"],
    notificationId: json["notificationId"],
    notificationType: json["notificationType"],
    company: Company.fromJson(json["company"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "notificationId": notificationId == null ? null : notificationId,
    "notificationType": notificationType == null ? null : notificationType,
    "company": company == null ? null : company!.toJson(),
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
  };

  static Map<String, dynamic> toMap(Notification notificationModel) => {
    "message": notificationModel.message!,
    "notificationId": notificationModel.notificationId,
    "notificationType": notificationModel.notificationType,
    "company": notificationModel.company,
    "createdAt": notificationModel.createdAt,
  };


  static List<Notification>? decodeNotificationList(String notifications) =>
      (json.decode(notifications) as List<dynamic>)
          .map<Notification>((item) => Notification.fromJson(item))
          .toList();

  static String encodeNotificationList(List<Notification> notifications) =>
      json.encode(
        notifications
            .map<Map<String, dynamic>>((music) => Notification.toMap(music))
            .toList(),
      );
}



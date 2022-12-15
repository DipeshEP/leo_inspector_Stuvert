import 'package:flutter/material.dart';

class Constants{

  static const primaryColor = Color(0XFF075E94);
  static const buttonColor = Color(0XFF075E94);

  //static const String baseUrl = '';
  //static const String baseUrl = "http://3.111.98.51:3000";
  static const String baseUrl = "https://api.leoinspector.com";

  //api names
  static const String apiLogin = 'token';
  static const String apiLogout = 'token';

  static const String apiAdminLogin = '/dev/api/v1/auth/login/admin';
  static const String apiInspector = '/dev/api/v1/inspector';
  static const String apiAdmin = '/dev/api/v1/admin';
  static const String apiClient = '/dev/api/v1/client';
  static const String apiCompany = '/dev/api/v1/company';
  static const String apiCertificate = '/dev/api/v1/certificate';
  static const String apiManageRequest = '/dev/api/v1/manege-request';
  static const String apiNotifications = '/dev/api/v1/notifications';
 // static const String apiNotifications='/dev/api/v1/notifications?adminId=cla10ttf60006b1pjh94u893h';

  static const String apiInspectorLogin = '/dev/api/v1/auth/login/inspector';



  static const double fontSize1 = 15.0;
  static const Color fontColor1 = Color.fromRGBO(8,117,181, 1);

  static const double fontSize2 = 15.0;
  static const Color fontColor2 = Color.fromRGBO(8,117,181, 1);

  static const double fontSize3 = 15.0;
  static const Color fontColor3 = Color.fromRGBO(94, 114, 228, 1);
  static const Color fontColor4 = Color.fromRGBO(23, 43, 77, 1);

  static const Color errorColor = Color.fromRGBO(239, 83, 80, 1);
  static const Color disabledTextColor = Color.fromRGBO(238, 238, 238, 1);

  static const Color backgroundColor1 = Color.fromRGBO(242, 242, 242, 1);
  static const Color backgroundColor2 = Color.fromRGBO(239, 239, 239, 1);


  //fonts styles
  static const String fontRegular = 'Barlow-Regular';
  static const String fontSemiBold = 'Barlow-SemiBold';
  static const String fontMedium = 'Barlow-Medium';
  static const String fontBold = 'Barlow-Bold';


}
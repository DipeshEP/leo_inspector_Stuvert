import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:leo_inspector/Model/company_model.dart' ;
import 'package:leo_inspector/Model/inspector_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/inspector_login_response_model.dart';
import '../../Model/inspector_model2.dart';
import '../../Model/notification_model.dart';
import '../../data/constants.dart';
import '../api_query.dart';


class InspectorRepository {

  ApiQuery apiQuery = ApiQuery();

  // ignore: constant_identifier_names
  static const String IS_INSPECTOR_LOGGED_IN = "IS_INSPECTOR_LOGGED_IN";

  // ignore: constant_identifier_names
  static const String INSPECTOR_LOGIN_RESPONSE = "INSPECTOR_LOGIN_RESPONSE";

  // ignore: constant_identifier_names
  static const String INSPECTOR_DETAILS = "INSPECTOR_DETAILS";

  // ignore: constant_identifier_names
  static const String COMPANY_DETAILS = "COMPANY_DETAILS";

  // ignore: constant_identifier_names
  static const String IS_NOT_NEW_USER = "IS_NOT_NEW_USER";

  // ignore: constant_identifier_names
  static const String USER_RESPONSE = "USER_RESPONSE";

  // ignore: constant_identifier_names
  static const String TRASH_NOTIFICATIONS = "TRASH_NOTIFICATIONS";

  // ignore: constant_identifier_names
  static const String USER_PROFILE = "USER_PROFILE";

  // ignore: constant_identifier_names
  static const String USER_TOKEN = "USER_TOKEN";

  // ignore: constant_identifier_names
  static const String LANGUAGE_CODE = "LANGUAGE_CODE";

  // ignore: constant_identifier_names
  static const String DEVICE_NAME = "DEVICE_NAME";

  // ignore: constant_identifier_names
  static const String DEVICE_PLATFORM = "DEVICE_PLATFORM";

  // ignore: constant_identifier_names
  static const String DEVICE_MAN = "DEVICE_MAN";

  // ignore: constant_identifier_names
  static const String DEVICE_ID = "DEVICE_ID";

  // ignore: constant_identifier_names
  static const String DEVICE_VERSION = "DEVICE_VERSION";

  Future<Response?> logOut() async {
    try {
      Response? response =
      await apiQuery.logoutQuery(Constants.apiLogout, 'LogoutApi');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //login inspector
  Future<Response?> loginInspector(String username, String password) async {
    try {

      Map<String, String> data = {
        "email": username,
        "password": password,
      };

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      print(data);

      Response? response = await apiQuery.postQuery(
          Constants.apiInspectorLogin, headers, data, 'InspectorLoginApi');
      print(response!.data);
      print(response.statusMessage);
      print(response.statusCode);

      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //get inspector details
  Future<Response?> getInspectorDetails() async {
    try {
      print('getInspectorDetails');

      String token,id;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();

      token = responseModel!.jwtAccessToken!;
      id = responseModel.userId!;

      Map<String, dynamic> data = {};
      //print(data);

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);

      Response? response = await apiQuery.getQuery(
          Constants.apiInspector+'/$id',
          headers,
          data,
          'getInspectorApi$id',
          false,
          true,
          true);

      print(response!.statusCode);
      print(response.data);
      print(response.statusMessage);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.getQuery(
            Constants.apiInspector+'/$id',
            headers2,
            data,
            'getInspectorApi$id',
            false,
            true,
            true);

        return response;
      }
      else{
        return response;
      }

    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //get inspector list
  Future<Response?> getInspectorList(String? inspectorType,String? cmpId) async {
    try {
      print('getInspectorList');

      String token;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {};
      //print(data);

      if(inspectorType != null){
        data = {
          "inspectorType" : inspectorType
        };
      }

      if(cmpId != null){
        data['cmpId'] = cmpId;
      }


      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);

      Response? response = await apiQuery.getQuery(
          Constants.apiInspector,
          headers,
          data,
          'getInspectorListApi',
          false,
          true,
          true);

      print(response!.statusCode);
      print(response.data);
      print(response.statusMessage);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.getQuery(
            Constants.apiInspector,
            headers2,
            data,
            'getInspectorListApi',
            false,
            true,
            true);
        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //get client list
  Future<Response?> getClientList(String? inspectorId,String? companyId) async {
    try {
      print('getClientList');
      String token, employeeId;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {};
      //print(data);
      if(inspectorId != null){
        data['inspectorId'] = inspectorId;
      }

      if(companyId != null){
        data['cmpId'] = companyId;
      }

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      print(data);

      Response? response = await apiQuery.getQuery(
          Constants.apiClient,
          headers,
          data,
          'getClientListApi',
          false,
          true,
          true);

      print(response!.statusCode);
      print(response.data);
      print(response.statusMessage);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.getQuery(
            Constants.apiClient,
            headers2,
            data,
            'getClientListApi',
            false,
            true,
            true);

        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //get certificate list
  Future<Response?> getCertificateList(String? inspectorId,String? status,String? authId,String? clientId) async {
    try {
      print('getCertificateList $inspectorId');
      String token, employeeId;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {};
      if(status != null){
        data['inspectionStatus'] = status;
      }

      if(authId != null){
        data['authorizerId'] = authId;
      }
      if(inspectorId != null){
        data['inspectorId'] = inspectorId;
      }
      if(clientId != null){
        data['clientId'] = clientId;
      }
      print(data);

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);

      Response? response = await apiQuery.getQuery(
          Constants.apiCertificate,
          headers,
          data,
          'getCertificateListApi$inspectorId',
          false,
          true,
          true);

      print(response!.statusCode);
      print(response.data);
      print(response.statusMessage);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.getQuery(
            Constants.apiCertificate,
            headers2,
            data,
            'getCertificateListApi$inspectorId',
            false,
            true,
            true);

        return response;
      }
      else{
        return response;
      }

    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //get company list
  Future<Response?> getCompanyList() async {
    try {
      print('getCompanyList');
      String token, employeeId;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {};
      //print(data);

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);

      Response? response = await apiQuery.getQuery(
          Constants.apiCompany,
          headers,
          data,
          'getCompanyListApi',
          false,
          true,
          true);

      print(response!.statusCode);
      print(response.data);
      print(response.statusMessage);


      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.getQuery(
            Constants.apiCompany,
            headers2,
            data,
            'getCompanyListApi',
            false,
            true,
            true);

        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //get one company
  Future<Response?> getOneCompany(String inspectorId) async {
    try {
      print('getOneCompany');
      String token, employeeId;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {
        "inspectorId" : inspectorId
      };
      //print(data);

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);

      Response? response = await apiQuery.getQuery(
          Constants.apiCompany,
          headers,
          data,
          'getOneCompanyApi$inspectorId',
          false,
          true,
          true);

      print(response!.statusCode);
      print(response.data);
      print(response.statusMessage);


      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.getQuery(
            Constants.apiCompany,
            headers2,
            data,
            'getOneCompanyApi$inspectorId',
            false,
            true,
            true);

        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //get notification list
  Future<Response?> getNotificationList(String? inspectorId) async {
    try {
      print('getNotificationList');
      String token, employeeId;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {
        "inspectorId" :inspectorId
      };
      print(data);

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);

      Response? response = await apiQuery.getQuery(
          Constants.apiNotifications,
          headers,
          data,
          'getNotificationListApi',
          false,
          true,
          true);

      print(response!.statusCode);
      print(response.data);
      print(response.statusMessage);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.getQuery(
            Constants.apiNotifications,
            headers2,
            data,
            'getNotificationListApi',
            false,
            true,
            true);

        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //delete notification
  Future<Response?> deleteNotification(String notificationId) async {
    try {
      print('deleteNotification');
      String token;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {};
      print(data);

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);


      Response? response = await apiQuery.deleteQuery(
          Constants.apiNotifications + '/$notificationId', headers, data, 'NotificationApi',true);
      print(response!.data);
      print(response.statusMessage);
      print(response.statusCode);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.deleteQuery(
            Constants.apiNotifications + '/$notificationId', headers2, data, 'NotificationApi',true);

        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //change password
  Future<Response?> changePassword(String email, String oldPassword, String newPassword) async {
    try {
      print('changePassword');

      String token,inspectorId;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();
      Inspector? inspector = await getInspectorDetailsLocal();

      token = responseModel!.jwtAccessToken!;
      inspectorId = inspector!.inspectorId!;

      Map<String, String> data = {
        "password": newPassword,
      };

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      print(data);

      Response? response = await apiQuery.putQuery(
          Constants.apiInspector+'/'+inspectorId, headers, data, 'InspectorApi');
      print(response!.data);
      print(response.statusMessage);
      print(response.statusCode);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.postQuery(
            Constants.apiInspector+'/'+inspectorId, headers, data, 'InspectorApi');

        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //upload certificate
  Future<Response?> uploadCertificate(String? certificateVersion, String? certificateRowData,File certificatePdf,
      String? inspectorId,String? cmpId,String? clientId,String? details,String? authorizerId,String? inspectionStatus) async {
    try {
      print('uploadCertificate');

      String token;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();
      token = responseModel!.jwtAccessToken!;


      print('---------- uploadCertificate -------------');
      print(certificatePdf.path);

      String fileName = "";
      String dateTime = DateTime.now().toString().trim();
      if(inspectorId != null){
        fileName += inspectorId.toString();
      }
      if(authorizerId != null){
        fileName += authorizerId.toString();
      }
      if(certificateVersion != null){
        fileName += certificateVersion.toString();
      }
      fileName += dateTime;
      fileName =  fileName.replaceAll(":", "");
      fileName = fileName.replaceAll(" ", "");
      fileName = fileName.replaceAll(".", "");
      fileName = fileName.replaceAll("-", "");
      fileName += 'output.pdf';


      MultipartFile? pdfFile;
      var cert = File(certificatePdf.path);
      pdfFile = await MultipartFile.fromFile(cert.path, filename: fileName);


      Map<String, dynamic> data = {
        "certificateVersion": certificateVersion,
        "inspectorId": inspectorId,
        "authorizerId": authorizerId,
        "inspectionStatus": inspectionStatus,
        "certificateRowData": certificateRowData,
        "certificatePdf": pdfFile,
        "cmpId": cmpId,
        "clientId": clientId,
        "details": details
      };

      FormData formData = FormData.fromMap(data);

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };

      print(data);

      Response? response = await apiQuery.postQuery(
          Constants.apiCertificate, headers, formData, 'CertificateApi');
      print(response!.data);
      print(response.statusMessage);
      print(response.statusCode);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.postQuery(
            Constants.apiCertificate, headers2, formData, 'CertificateApi');

        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }


  //approve certificate
  Future<Response?> approveCertificate(String? certificateVersion, String? certificateRowData,File certificatePdf,
      String? inspectorId,String? cmpId,String? clientId,String? details,String? authorizerId,String? inspectionStatus,String? certificateId) async {
    try {
      print('uploadCertificate');

      String token;
      InspectorLoginModel? responseModel = await getInspectorLoginResponse();
      token = responseModel!.jwtAccessToken!;


      print('---------- uploadCertificate -------------');
      print(certificatePdf.path);

      String fileName = "";
      String dateTime = DateTime.now().toString().trim();
      if(inspectorId != null){
        fileName += inspectorId.toString();
      }
      if(authorizerId != null){
        fileName += authorizerId.toString();
      }
      if(certificateVersion != null){
        fileName += certificateVersion.toString();
      }
      fileName += dateTime;
      fileName =  fileName.replaceAll(":", "");
      fileName = fileName.replaceAll(" ", "");
      fileName = fileName.replaceAll(".", "");
      fileName = fileName.replaceAll("-", "");
      fileName += 'output.pdf';


      MultipartFile? pdfFile;
      var cert = File(certificatePdf.path);
      pdfFile = await MultipartFile.fromFile(cert.path, filename: fileName);


      Map<String, dynamic> data = {
        "certificateVersion": certificateVersion,
        "inspectorId": inspectorId,
        "authorizerId": authorizerId,
        "inspectionStatus": inspectionStatus,
        "certificateRowData": certificateRowData,
        "certificatePdf": pdfFile,
        "cmpId": cmpId,
        "clientId": clientId,
        "details": details
      };

      FormData formData = FormData.fromMap(data);

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };

      print(data);

      Response? response = await apiQuery.putQuery(
          Constants.apiCertificate+'/$certificateId', headers, formData, 'CertificateApi');
      print(response!.data);
      print(response.statusMessage);
      print(response.statusCode);

      if(response != null && (response.statusCode == 303 || response.statusCode == 401 )){
        token = responseModel.jwtRefreshToken!;
        Map<String, String> headers2 = {};
        headers2 = {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token',
        };

        //print(data);

        Response? response = await apiQuery.putQuery(
            Constants.apiCertificate+'/$certificateId', headers2, formData, 'CertificateApi');

        return response;
      }
      else{
        return response;
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }



  ////////////////// shared pref //////////////////

  Future<InspectorLoginModel?> getInspectorLoginResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(INSPECTOR_LOGIN_RESPONSE) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(INSPECTOR_LOGIN_RESPONSE);
      return InspectorLoginModel.fromJson(json.decode(userResponse!));
    }
  }

  storeInspectorLoginResponse(InspectorLoginModel userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfileJson = json.encode(userData);
    prefs.setString(INSPECTOR_LOGIN_RESPONSE, userProfileJson);
  }

  Future<Inspector?> getInspectorDetailsLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(INSPECTOR_DETAILS) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(INSPECTOR_DETAILS);
      InspectorModel inspectorModel = InspectorModel.fromJson(json.decode(userResponse!));
      return inspectorModel.inspector;
    }
  }

/*  Future<InspectorModel?> getInspectorDetailsLocal2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(INSPECTOR_DETAILS) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(INSPECTOR_DETAILS);
      return InspectorModel.fromJson(json.decode(userResponse!));
    }
  }*/

  storeInspectorDetails(String? userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('--------storeInspectorDetails--------');
    print('inspectorModel.inspector!.inspectorId');
    print(userData);
    //String userProfileJson = jsonEncode(userData);

    //json.encode(userData);
    prefs.setString(INSPECTOR_DETAILS, userData!);
  }

  Future<Company?> getCompanyDetailsLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(COMPANY_DETAILS) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(COMPANY_DETAILS);
      return Company.fromJson(json.decode(userResponse!));
    }
  }

  storeCompanyDetails(Company userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfileJson = json.encode(userData);
    prefs.setString(COMPANY_DETAILS, userProfileJson);
  }

  //user login
  Future<bool> isInspectorLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_INSPECTOR_LOGGED_IN) ?? false;
  }

  setInspectorLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(IS_INSPECTOR_LOGGED_IN, isLoggedIn);
  }

  // to store user token
  Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_TOKEN);
  }

  storeUserToken(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(USER_TOKEN, code);
  }

  Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LANGUAGE_CODE);
  }

  setLanguage(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(LANGUAGE_CODE, code);
  }

  /////////// DEVICE INFO /////////////
  //NAME
  Future<String> getDeviceName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DEVICE_NAME) ?? '';
  }

  setDeviceName(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(DEVICE_NAME, code);
  }

  //MANUFACTURER
  Future<String> getDeviceMan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DEVICE_MAN) ?? '';
  }

  setDeviceMan(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(DEVICE_MAN, code);
  }

  //VERSION
  Future<String> getDeviceVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DEVICE_VERSION) ?? '';
  }

  setDeviceVersion(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(DEVICE_VERSION, code);
  }

  //PLATFORM
  Future<String> getDevicePlatform() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DEVICE_PLATFORM) ?? '';
  }

  setDevicePlatform(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(DEVICE_PLATFORM, code);
  }

  //DEVICE ID
  Future<String> getDeviceID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DEVICE_ID) ?? '';
  }

  setDeviceID(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(DEVICE_ID, code);
  }

  Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<List<Notification>> getTrashNotificationList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(TRASH_NOTIFICATIONS) == null) {
      return [];
    } else {
      return Notification.decodeNotificationList(
          prefs.getString(TRASH_NOTIFICATIONS)!)!;
    }
  }

  Future<void> storeTrashNotificationList(List<Notification> trashList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newTripResponseJson =
    Notification.encodeNotificationList(trashList);
    prefs.setString(TRASH_NOTIFICATIONS, newTripResponseJson);
  }
}

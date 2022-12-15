import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:leo_inspector/Model/admin_model.dart' as a;
import 'package:leo_inspector/Model/company_model.dart' as c;
import 'package:leo_inspector/data/login/admin/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/notification_model.dart';
import '../../data/constants.dart';
import '../api_query.dart';


class AdminRepository {

  ApiQuery apiQuery = ApiQuery();

  // ignore: constant_identifier_names
  static const String IS_ADMIN_LOGGED_IN = "IS_ADMIN_LOGGED_IN";

  // ignore: constant_identifier_names
  static const String ADMIN_LOGIN_RESPONSE = "ADMIN_LOGIN_RESPONSE";

  // ignore: constant_identifier_names
  static const String ADMIN_DETAILS = "ADMIN_DETAILS";

  // ignore: constant_identifier_names
  static const String COMPANY_DETAILS = "COMPANY_DETAILS";

  // ignore: constant_identifier_names
  static const String IS_NOT_NEW_USER = "IS_NOT_NEW_USER";

  // ignore: constant_identifier_names
  static const String USER_RESPONSE = "USER_RESPONSE";

  // ignore: constant_identifier_names
  static const String USER_PROFILE = "USER_PROFILE";

  // ignore: constant_identifier_names
  static const String TRASH_NOTIFICATIONS = "TRASH_NOTIFICATIONS";

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

  //login admin
  Future<Response?> loginAdmin(String username, String password) async {
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
          Constants.apiAdminLogin, headers, data, 'LoginApi');
      print(response!.data);
      print(response.statusMessage);
      print(response.statusCode);

      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  //get admin details
  Future<Response?> getAdminDetails() async {
    try {
      print('getAdminDetails');

      String token,id;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

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
          Constants.apiAdmin+'/$id',
          headers,
          data,
          'getAdminApi$id',
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
            Constants.apiAdmin+'/$id',
            headers2,
            data,
            'getAdminApi$id',
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
  Future<Response?> getInspectorList(String? companyId) async {
    try {
      print('getInspectorList');

      String token;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {};
      //print(data);

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

  //add new inspector
  Future<Response?> addInspector(String name, String phone,File signature,
      File profileImg,String email,String empId,String type) async {
    try {
      print('addInspector');

      String token,adminId,companyId;
      AdminLoginModel? responseModel = await getAdminLoginResponse();
      a.Admin? admin = await getAdminDetailsLocal();

      token = responseModel!.jwtAccessToken!;
      adminId = admin!.adminId!;
      companyId = admin.cmpId!;

      DateTime now = DateTime.now();
      String time = now.toString().trim();
      time = time.replaceAll(".", "");
      time = time.replaceAll("-", "");
      time = time.replaceAll(":", "");

      MultipartFile? imgFile1;
      var image1 = File(signature.path);
      imgFile1 = await MultipartFile.fromFile(image1.path, filename: "$name$empId$time-signature.jpg");
      MultipartFile? imgFile2;
      var image2 = File(profileImg.path);
      imgFile2 = await MultipartFile.fromFile(image2.path, filename: "$name$empId$time-profileImage.jpg");


      Map<String, dynamic> data = {
        "name": name,
        "phone": phone,
        "signatureUrl": imgFile1,
        "profileImageUrl": imgFile2,
        "email": email,
        "inspectorType": type,
        "empId": empId,
        "cmpId": companyId,
        "password": '12345678'
      };

      FormData formData = FormData.fromMap(data);

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };

      print(data);

      Response? response = await apiQuery.postQuery(
          Constants.apiInspector, headers, formData, 'InspectorApi');
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
            Constants.apiInspector, headers2, formData, 'InspectorApi');

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

  //delete inspector
  Future<Response?> deleteInspector(String inspectorId) async {
    try {
      print('deleteInspector');
      String token;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

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
          Constants.apiInspector + '/$inspectorId', headers, data, 'InspectorApi',true);
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
            Constants.apiInspector + '/$inspectorId', headers2, data, 'InspectorApi',true);

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
  Future<Response?> getClientList(String? q,String? companyId) async {
    try {
      print('getClientList');
      String token, employeeId;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {};
      //print(data);

      if(q != null){
        data['q'] = q;
      }

      if(companyId != null){
        data['cmpId'] = companyId;
      }

      print(data);

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);

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

  //add new client
  Future<Response?> addClient(String name, String phone, String email,
      String address, File profileImg) async {
    try {
      print('addClient');

      String token,adminId,companyId;
      AdminLoginModel? responseModel = await getAdminLoginResponse();
      a.Admin? admin = await getAdminDetailsLocal();

      token = responseModel!.jwtAccessToken!;
      adminId = admin!.adminId!;
      companyId = admin.cmpId!;

      DateTime now = DateTime.now();
      String time = now.toString().trim();
      time = time.replaceAll(".", "");
      time = time.replaceAll("-", "");
      time = time.replaceAll(":", "");

      MultipartFile? imgFile2;
      var image2 = File(profileImg.path);
      imgFile2 = await MultipartFile.fromFile(image2.path, filename: "$name$companyId$time-profileImage.jpg");

      Map<String, dynamic> data = {
        "name": name,
        "phone": phone,
        "email": email,
        // "address": address,
        "profileImageUrl": imgFile2,
        "password": "12345678",
        "cmpId": companyId,
        // "nameOfContact" : nameOfContact
      };

      FormData formData = FormData.fromMap(data);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      print(data);

      Response? response = await apiQuery.postQuery(
          Constants.apiClient, headers, formData, 'ClientApi');
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
            Constants.apiClient, headers2, formData, 'ClientApi');

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

  //delete client
  Future<Response?> deleteClient(String clientId) async {
    try {
      print('deleteClient');
      String token;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {
      };
      print(data);

      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //print(data);

      Response? response = await apiQuery.deleteQuery(
          Constants.apiClient + '/$clientId', headers, data, 'ClientApi',true);

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
            Constants.apiClient + '/$clientId', headers2, data, 'ClientApi',true);

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
      AdminLoginModel? responseModel = await getAdminLoginResponse();

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
  Future<Response?> getOneCompany(String adminId) async {
    try {
      print('getOneCompany');
      String token, employeeId;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {
        "adminId" : adminId
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
          'getOneCompanyApi$adminId',
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
            'getOneCompanyApi$adminId',
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
  Future<Response?> getCertificateList(String clientId,String? q) async {
    try {
      print('getCertificateList $clientId');
      String token, employeeId;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {
        "q" : q,
        "clientId" : clientId
      };
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
          'getCertificateListApi',
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
            'getCertificateListApi',
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

  //get request list
  Future<Response?> getRequestList(String? q,String? companyId) async {
    try {
      print('getRequestList');
      String token, employeeId;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {
        "q" : q
      };


      if(companyId != null){
        data['cmpId'] = companyId;
      }

      //print(data);


      Map<String, String> headers = {};
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      print(data);

      Response? response = await apiQuery.getQuery(
          Constants.apiManageRequest,
          headers,
          data,
          'getRequestListApi',
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
            Constants.apiManageRequest,
            headers2,
            data,
            'getRequestListApi',
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
  Future<Response?> getNotificationList(String? adminId) async {
    try {
      print('getNotificationList');
      String token, employeeId;
      AdminLoginModel? responseModel = await getAdminLoginResponse();

      token = responseModel!.jwtAccessToken!;

      Map<String, dynamic> data = {
        "adminId" : adminId
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
print(".............$response .....................");
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
      AdminLoginModel? responseModel = await getAdminLoginResponse();

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

      String token,adminId,companyId;
      AdminLoginModel? responseModel = await getAdminLoginResponse();
      a.Admin? admin = await getAdminDetailsLocal();

      token = responseModel!.jwtAccessToken!;
      adminId = admin!.adminId!;
      companyId = admin.cmpId!;

      Map<String, String> data = {
        "password": newPassword,
      };

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      print(data);

      Response? response = await apiQuery.putQuery(
          Constants.apiAdmin+'/'+adminId, headers, data, 'AdminApi');
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
            Constants.apiAdmin+'/'+adminId, headers2, data, 'AdminApi');

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

  Future<AdminLoginModel?> getAdminLoginResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(ADMIN_LOGIN_RESPONSE) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(ADMIN_LOGIN_RESPONSE);
      return AdminLoginModel.fromJson(json.decode(userResponse!));
    }
  }

  storeAdminLoginResponse(AdminLoginModel userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfileJson = json.encode(userData);
    prefs.setString(ADMIN_LOGIN_RESPONSE, userProfileJson);
  }

  Future<a.Admin?> getAdminDetailsLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(ADMIN_DETAILS) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(ADMIN_DETAILS);
      return a.Admin.fromJson(json.decode(userResponse!));
    }
  }

  storeAdminDetails(a.Admin userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfileJson = json.encode(userData);
    prefs.setString(ADMIN_DETAILS, userProfileJson);
  }

  Future<c.Company?> getCompanyDetailsLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(COMPANY_DETAILS) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(COMPANY_DETAILS);
      return c.Company.fromJson(json.decode(userResponse!));
    }
  }

  storeCompanyDetails(c.Company userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfileJson = json.encode(userData);
    prefs.setString(COMPANY_DETAILS, userProfileJson);
  }

/*  Future<UserProfileModel?> getUserProfileLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(USER_PROFILE) == null) {
      return null;
    } else {
      String? userResponse = prefs.getString(USER_PROFILE);
      return UserProfileModel.fromJson(json.decode(userResponse!));
    }
  }

  storeUserProfile(UserProfileModel userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfileJson = json.encode(userData);
    prefs.setString(USER_PROFILE, userProfileJson);
  }*/

  //user login
  Future<bool> isAdminLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_ADMIN_LOGGED_IN) ?? false;
  }

  setAdminLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(IS_ADMIN_LOGGED_IN, isLoggedIn);
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

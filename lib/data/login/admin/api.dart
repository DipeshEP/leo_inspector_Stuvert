import 'package:dio/dio.dart';
import 'package:leo_inspector/services/dio/dioservices.dart';

class AdminLoginApi {
  DioClient _dioClient;
  AdminLoginApi(this._dioClient);

  Future<Response> postAdminLoginApi(String email, String password) async {

    Map<String, dynamic> credential = {"email": email, "password": password};

    try {
      Response response =
          await _dioClient.post("/dev/api/v1/auth/login/admin", credential);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

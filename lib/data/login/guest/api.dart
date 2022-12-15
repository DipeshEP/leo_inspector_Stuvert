import 'package:dio/dio.dart';
import 'package:leo_inspector/services/dio/dioservices.dart';

class GuestLoginApi {
  DioClient _dioClient;
  GuestLoginApi(this._dioClient);

  Future<Response> postGuestLoginApi(String email, String password) async {

    Map<String, dynamic> credential = {"email": email, "password": password};

    try {
      Response response =
      await _dioClient.post("/dev/api/v1/auth/login/guest", credential);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

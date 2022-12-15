import 'package:dio/dio.dart';
import 'package:leo_inspector/services/dio/dioservices.dart';

class ClientLoginApi {
  DioClient _dioClient;
  ClientLoginApi(this._dioClient);

  Future<Response> postClientLoginApi(String email, String password) async {

    Map<String, dynamic> credential = {"email": email, "password": password};

    try {
      Response response =
      await _dioClient.post("/dev/api/v1/auth/login/client", credential);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

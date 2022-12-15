import 'package:dio/dio.dart';
import 'package:leo_inspector/services/dio/dioservices.dart';

class InspectorLoginApi {
  DioClient _dioClient;
  InspectorLoginApi(this._dioClient);

  Future<Response> postInspectorLoginApi(String email, String password) async {

    Map<String, dynamic> credential = {"email": email, "password": password};

    try {
      Response response =
      await _dioClient.post("/dev/api/v1/auth/login/inspector", credential);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}

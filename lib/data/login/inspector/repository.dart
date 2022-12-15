import 'package:dio/dio.dart';
import 'package:leo_inspector/data/login/inspector/api.dart';
import 'package:leo_inspector/data/login/inspector/model.dart';

import '../../../Model/inspector_login_response_model.dart';

class InspectorLoginRepository {
  InspectorLoginApi _inspectorLoginApi;

  InspectorLoginRepository(this._inspectorLoginApi);

  Future<InspectorLoginModel>postInspectorLoginRepo(String email, String password) async {
    try {
      Response response =
      await _inspectorLoginApi.postInspectorLoginApi(email, password);
      return InspectorLoginModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }
}

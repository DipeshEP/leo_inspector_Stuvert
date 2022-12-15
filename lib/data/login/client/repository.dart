import 'package:dio/dio.dart';
import 'package:leo_inspector/data/login/client/api.dart';
import 'package:leo_inspector/data/login/client/model.dart';

class ClientLoginRepository {
  ClientLoginApi _clientLoginApi;

  ClientLoginRepository(this._clientLoginApi);

  Future<ClientLoginModel>postClientLoginRepo(String email, String password) async {
    try {
      Response response =
      await _clientLoginApi.postClientLoginApi(email, password);
      return ClientLoginModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }
}

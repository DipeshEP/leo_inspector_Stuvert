import 'package:dio/dio.dart';
import 'package:leo_inspector/data/login/admin/api.dart';
import 'package:leo_inspector/data/login/admin/model.dart';

class AdminLoginRepository {
  AdminLoginApi _adminLoginApi;

  AdminLoginRepository(this._adminLoginApi);

  Future<AdminLoginModel>postAdminLoginRepo(String email, String password) async {
    try {
      Response response =
          await _adminLoginApi.postAdminLoginApi(email, password);
      return AdminLoginModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }
}

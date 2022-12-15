import 'package:dio/dio.dart';
import 'package:leo_inspector/data/login/guest/api.dart';
import 'package:leo_inspector/data/login/guest/model.dart';

class GuestLoginRepository {
  GuestLoginApi _guestLoginApi;

  GuestLoginRepository(this._guestLoginApi);

  Future<GuestLoginModel>postGuestLoginRepo(String email, String password) async {
    try {
      Response response =
      await _guestLoginApi.postGuestLoginApi(email, password);
      return GuestLoginModel.fromJson(response.data);
    } catch (ex) {
      rethrow;
    }
  }
}

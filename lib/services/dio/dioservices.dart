import 'package:dio/dio.dart';

class DioClient {

  String baseUrl = "http://3.111.98.51:3000";

  Future<Response> post(String endUrl, Map<String, dynamic> data,
      {String? token}) async {
    var dio = Dio();
    String url = baseUrl + endUrl;
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);
        return response;
      }
      else{
        Response response = await dio.post(
          url,
          data: data,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        print(data);
        return response;
      }
    } catch (e) {
      throw Exception('please enter userid & password');
    }
  }

  get(String endUrl, {String? token}) async {
    var dio = Dio();
    String url = baseUrl + endUrl;
    try {
      if (token == null) {
        Response response = await dio.get(url);
        return response.data;
      }
      if (token != null) {
        Response response = await dio.get(url,
            options: Options(headers: {'Authorization': 'Bearer $token'}));
        return response.data;
      }
    } catch (e) {
      print(e);
      throw Exception("......");
    }
  }

  put(endUrl, data, {String? token}) async {
    var dio = Dio();
    String url = baseUrl + endUrl;
    try {
      if (token == null) {
        Response response = await dio.put(url, data: data);
        return response.data;
      }
      if (token != null) {
        Response response = await dio.put(url,
            data: data,
            options: Options(headers: {'Authorization': 'Bearer $token'}));
        return response.data;
      }
    } catch (e) {}
  }

  Future<dynamic> patch(endUrl, data, {String? token}) async {
    var dio = Dio();
    String url = baseUrl + endUrl;

    try {
      if (token == null) {
        Response response = await dio.patch(url, data: data);
        return response.data;
      }

      if (token != null) {
        Response response = await dio.patch(url,
            data: data,
            options: Options(headers: {'Authorization': 'Bearer $token'}));
        return response.data;
      }
    } catch (e) {}
  }
}

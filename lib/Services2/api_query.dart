import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:path_provider/path_provider.dart';

import '../data/constants.dart';


class ApiQuery {
  var dio = Dio();

  final DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());

  //post query
  Future<Response?> postQuery(String url, Map<String, String> headers,
      dynamic data, String apiName) async {
    Response response;
    try {
      print(headers);

      Options options = Options(headers: headers);

      //dio.options.headers = headers;
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); //continue
        },
        onError: (DioError e, handler) {
          return handler.next(e); //continue
        },
      ));
      print(Constants.baseUrl + url);
      response =
      await dio.post(Constants.baseUrl + url, data: data, options: options);
      return response;
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        return exception.response;
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return exception.response;
      } else {
        return exception.response;
      }
    }
  }

  //put query
  Future<Response?> putQuery(String url, Map<String, String> headers,
      dynamic data, String apiName) async {
    Response response;
    try {
      print(headers);

      Options options = Options(headers: headers);

      //dio.options.headers = headers;
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); //continue
        },
        onError: (DioError e, handler) {
          return handler.next(e); //continue
        },
      ));
      print(Constants.baseUrl + url);
      response =
      await dio.put(Constants.baseUrl + url, data: data, options: options);
      return response;
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        return exception.response;
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return exception.response;
      } else {
        return exception.response;
      }
    }
  }

  Future<Response?> getQuery(
      String url,
      Map<String, String> headers,
      Map<String, dynamic>? query,
      String apiName,
      bool isCached,
      bool isBaseUrlToBeAdded,
      bool forceRefresh,
      ) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    Options _cacheOptions = buildCacheOptions(const Duration(days: 1),
        forceRefresh: forceRefresh, primaryKey: apiName);
    var cookieJar = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    Response? response;

    try {
      print(headers);

      Options options = Options(headers: headers);

      //dio.interceptors.add(CookieManager(cookieJar));
      if (isCached) {
        dio.interceptors.add(_dioCacheManager.interceptor);
      }
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          print(options.uri);
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); //continue
        },
        onError: (DioError e, handler) {
          print(e.toString());
          return handler.next(e); //continue
        },
      ));
      if (isBaseUrlToBeAdded) {
        if (isCached) {
          print(Constants.baseUrl + url);
          response = await dio.get(Constants.baseUrl + url,
              options: options, queryParameters: query);
        } else {
          response = await dio.get(Constants.baseUrl + url,
              options: options,
              queryParameters: (query != null) ? query : null);
        }
      } else {
        if (isCached) {
          response = await dio.get(url,
              options: options,
              queryParameters: (query != null) ? query : null);
        } else {
          response = await dio.get(url,
              options: options,
              queryParameters: (query != null) ? query : null);
        }
      }
      return response;
    } on DioError catch (exception) {
      print(exception.response!.data);
      if (exception.toString().contains('SocketException')) {
        return exception.response;
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return exception.response;
      } else {
        return exception.response;
      }
    }
  }

  //patch query
  Future<Response?> patchQuery(
      String url, dynamic data, String apiName, bool isBaseUrlToBeAdded) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var cookieJar = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); //continue
        },
        onError: (DioError e, handler) {
          return handler.next(e); //continue
        },
      ));
      if (isBaseUrlToBeAdded) {
        response = await dio.patch(Constants.baseUrl + url, data: data);
      } else {
        response = await dio.patch(url, data: data);
      }
      return response;
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        return exception.response;
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return exception.response;
      } else {
        return exception.response;
      }
    }
  }

  //logout query
  Future<Response?> logoutQuery(String url, dynamic data) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var cookieJar = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    cookieJar.deleteAll();
    Response response;
    try {
      dio.interceptors.add(CookieManager(cookieJar));
      dio.interceptors.clear();
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); //continue
        },
        onError: (DioError e, handler) {
          return handler.next(e); //continue
        },
      ));
      response = await dio.post(Constants.baseUrl + url, data: data);
      dio.clear();
      _dioCacheManager.clearAll();
      return response;
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        return exception.response;
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return exception.response;
      } else {
        return exception.response;
      }
    }
  }

  //delete query
  Future<Response?> deleteQuery(
      String url, Map<String, String> headers, dynamic data, String apiName, bool isBaseUrlToBeAdded) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(headers);

    Options options = Options(headers: headers);
    Response response;
    try {
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          print(options.path);
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          return handler.next(response); //continue
        },
        onError: (DioError e, handler) {
          return handler.next(e); //continue
        },
      ));
      if (isBaseUrlToBeAdded) {
        response = await dio.delete(Constants.baseUrl + url, queryParameters: data,options: options);
      } else {
        response = await dio.delete(url, queryParameters: data,options: options);
      }
      return response;
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        return exception.response;
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        return exception.response;
      } else {
        return exception.response;
      }
    }
  }
}

import 'package:dio/dio.dart';

import '../end_points.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 20*1000,// 20 seconds
          receiveTimeout: 20*1000,
          ),
    );
  }

  static Future<Response> postData(
      {
        required String url,
        required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ,
    };
    return dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return dio.get(
      url,
      queryParameters: query,
    );
  }

}

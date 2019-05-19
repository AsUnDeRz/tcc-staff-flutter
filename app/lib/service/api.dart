import 'dart:io';

import 'package:app/model/authen_entity.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class UserApiProvider {
  final String endpoint = "https://alpha-api.theconcert.co.th/staffs/authen";
  final Dio _dio = Dio();

  Future<AuthenEntity> authen(String username, String password) async {
    _dio.interceptors..add(CookieManager(CookieJar()))..add(LogInterceptor(requestBody: true));
    _dio.options.contentType = ContentType.json;
    try {
      Response response =
          await _dio.post(endpoint, data: {"username": username, "password": password});
      return new AuthenEntity.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.data != null) {
        //try handle status code
        if (e.response.statusCode == 404) {
          return new AuthenEntity.fromJson(e.response.data);
        } else {
          return new AuthenEntity.fromJson(e.response.data);
        }
      } else {
        return new AuthenEntity.withError(e.message);
      }
    }
  }
}

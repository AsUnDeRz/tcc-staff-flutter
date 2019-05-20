import 'dart:io';

import 'package:app/model/authen_entity.dart';
import 'package:app/model/concert_entity.dart';
import 'package:app/service/share_preference.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import '../locator.dart';

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

class ConcertApiProvider {
  final String endpoint = "https://alpha-api.theconcert.co.th/staffs/products";
  final Dio _dio = Dio();
  SharePrefInterface sharePrefInterface = SharePrefInterface();

  ConcertApiProvider() {
    initHeader();
  }

  void initHeader() async {
    final type = sharePrefInterface.tokenType();
    final token = sharePrefInterface.accessToken();
    _dio.options.headers = {
      HttpHeaders.authorizationHeader: "$type $token",
      HttpHeaders.acceptLanguageHeader: "th"
    };
    _dio.interceptors..add(CookieManager(CookieJar()))..add(LogInterceptor(requestBody: true));
    _dio.options.contentType = ContentType.json;
  }

  Future<ConcertEntity> getConcertList() async {
    try {
      Response response = await _dio.get(endpoint, queryParameters: {
        "type": "event",
        "show_status": "on-time",
        "status": "true",
        "order": "show_start",
        "sort": "asc"
      });
      print(response);
      return new ConcertEntity.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response.data != null) {
        //try handle status code
        if (e.response.statusCode == 404) {
          return new ConcertEntity.fromJson(e.response.data);
        } else {
          return new ConcertEntity.fromJson(e.response.data);
        }
      } else {
        return new ConcertEntity.withError(e.message);
      }
    }
  }
}

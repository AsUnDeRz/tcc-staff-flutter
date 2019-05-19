import 'package:app/model/base_error_entity.dart';
import 'package:dio/dio.dart';

class CoreNetwork {
  final String endpoint = "https://alpha-api.theconcert.co.th/staffs";
  final Dio _dio = Dio();

  Future<dynamic> get(String path) async {
    Response response = await _dio.get(endpoint + path);
    try {
      return response.data;
    } on DioError catch (e) {
      return handleError(e);
    }
  }

  Future<BaseError> handleError(DioError e) async {
    if (e.response.statusCode >= 400) {
      return BaseError(message: "error status code 400+");
    } else if (e.response.statusCode >= 500) {
      return BaseError(message: "error status code 500+");
    }
  }
}

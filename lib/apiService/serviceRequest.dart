import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = "https://admin.switchxenergy.com/";
    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      error: true,
      responseBody: true,
      compact: true,
    ));
  }

  Dio get request => _dio;
}

import 'package:dio/dio.dart';
import 'app_constants.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constant.baseUrl, // ✅ Use base URL from constants
      connectTimeout: const Duration(milliseconds: Constant.connectTimeout),
      receiveTimeout: const Duration(milliseconds: Constant.receiveTimeout),
      headers: {"Content-Type": "application/json"},
    ),
  );

  Dio get dio => _dio;
}

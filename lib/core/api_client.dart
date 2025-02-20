import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dio_client.dart';
import 'http_client.dart';
import '../data/services/api_service_dio.dart';
import '../data/services/api_service_http.dart';
import '../data/services/api_service_chopper.dart';
import '../data/services/api_service_retrofit.dart';
import 'package:chopper/chopper.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  // Singleton pattern
  factory ApiClient() => _instance;

  ApiClient._internal();

  // Initialize API Clients
  final DioClient dioClient = DioClient();
  final HttpClientService httpClient = HttpClientService();
  final Dio _dio = Dio();
  final ChopperClient chopperClient = ChopperClient(
    baseUrl: Uri.parse("https://jsonplaceholder.typicode.com"),
    services: [
      ApiServiceChopper.create(),
    ],
    converter: const JsonConverter(),
  );

  // Create API Services
  late final ApiServiceDio apiServiceDio = ApiServiceDio();
  late final ApiServiceHttp apiServiceHttp = ApiServiceHttp();
  late final ApiServiceChopper apiServiceChopper =
      chopperClient.getService<ApiServiceChopper>();
  late final ApiServiceRetrofit apiServiceRetrofit = ApiServiceRetrofit(_dio);
}

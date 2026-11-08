import 'package:dio/dio.dart';
import 'package:depokontrol/core/token_storage.dart';
class ApiService {
  static final ApiService _instance = ApiService._internal();
  late final Dio dio;
  factory ApiService() {
    return _instance;
  }
  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
  static String _getBaseUrl() {
    return "http://127.0.0.1:8000";
  }
}
import 'package:dio/dio.dart';
import 'package:depokontrol/core/token_storage.dart';
import 'api_service.dart';

class AuthService {
  final Dio dio = ApiService().dio;

  /// LOGIN
  Future<String> login(
    String kullaniciadi,
    String password,
  ) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: {
          "username": kullaniciadi,
          "password": password,
        },
      );

      final token = response.data["access_token"];

      if (token == null) {
        throw Exception("Token alınamadı");
      }

      await TokenStorage.saveToken(token);

      return token;
    } on DioException catch (e) {
      final data = e.response?.data;

      throw Exception(
        (data is Map && data["detail"] != null)
            ? data["detail"].toString()
            : data?.toString() ?? "Giriş hatası oluştu",
      );
    } catch (e) {
      throw Exception("Beklenmeyen hata: $e");
    }
  }

  /// REGISTER
  Future register({
    required String email,
    required String kullaniciadi,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/auth/register",
        data: {
          "email": email,
          "kullaniciadi": kullaniciadi,
          "password": password,
        },
      );

      return response.data;
    } on DioException catch (e) {
      final data = e.response?.data;

      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      print("MESSAGE: ${e.message}");

      throw Exception(
        (data is Map && data["detail"] != null)
            ? data["detail"].toString()
            : data?.toString() ?? "Kayıt hatası oluştu",
      );
    } catch (e) {
      throw Exception("Beklenmeyen hata: $e");
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    await TokenStorage.clearToken();
  }

  /// TOKEN GETIR
  Future<String?> getToken() async {
    return await TokenStorage.getToken();
  }

  /// LOGIN KONTROL
  Future<bool> isLoggedIn() async {
    final token = await TokenStorage.getToken();
    return token != null && token.isNotEmpty;
  }
}
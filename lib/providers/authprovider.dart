import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/auth_service.dart';
import '../core/token_storage.dart';


final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthNotifier extends Notifier<bool> {
@override
bool build() {
  _checkLogin();
  return false;
}

Future<void> _checkLogin() async {
  final token =
      await TokenStorage.getToken();

  if (token != null) {
    state = true;
  }
}
 
  Future<void> login(String username, String password) async {
    final authService = ref.read(authServiceProvider);
    await authService.login(username, password);
    state = true;
  }
  Future<void> logout() async {
    final authService = ref.read(authServiceProvider);
    await authService.logout();
    state = false;
  }
  Future<void> register({
    required String email,
    required String kullaniciadi,
    required String password,
  }) async {
    final authService = ref.read(authServiceProvider);
    await authService.register(
      email: email,
      kullaniciadi: kullaniciadi,
      password: password,
    );
  }
}
final authProvider = NotifierProvider<AuthNotifier, bool>(AuthNotifier.new);




import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otlob_api/otlob_api.dart';

class AuthRepository {
  final OtlobApi _apiClient;
  final FlutterSecureStorage _storage;

  AuthRepository(this._apiClient, this._storage);

  Future<bool> login(String email, String password) async {
    try {
      final loginDto = LoginDto((b) => b
        ..email = email
        ..password = password);
      final response = await _apiClient.getAuthenticationApi().authControllerLogin(loginDto: loginDto);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseMap = response.data as Map<String, dynamic>;
        print('Login Success Data: $responseMap');
        final data = responseMap['data'] as Map<String, dynamic>;
        
        // Role check
        final userData = data['user'] as Map<String, dynamic>;
        final role = userData['role'] as String;
        if (role == 'CUSTOMER') {
          throw 'ACCESS_DENIED';
        }

        await _storage.write(key: 'access_token', value: data['access_token']);
        await _storage.write(key: 'refresh_token', value: data['refresh_token']);
        await _storage.write(key: 'user_id', value: userData['id']);
        return true;
      }
      return false;
    } catch (e) {
      if (e == 'ACCESS_DENIED') rethrow;
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'access_token');
    return token != null;
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }
}

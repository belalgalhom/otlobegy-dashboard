import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otlob_api/otlob_api.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
        await _storage.write(key: 'user_id', value: userData['id']?.toString());
        await _storage.write(key: 'user_role', value: role);
        
        if (userData['vendorMemberships'] != null && (userData['vendorMemberships'] as List).isNotEmpty) {
          final membership = userData['vendorMemberships'][0];
          await _storage.write(key: 'vendor_id', value: membership['vendorId'].toString());
          await _storage.write(key: 'vendor_role', value: membership['role'].toString());
        }
        return true;
      }
      return false;
    } catch (e) {
      if (e == 'ACCESS_DENIED') rethrow;
      print('AuthRepository login error: $e');
      if (e is DioException) {
        print('AuthRepository login Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      }
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

  Future<String?> getUserRole() async {
    return await _storage.read(key: 'user_role');
  }

  Future<String?> getVendorId() async {
    return await _storage.read(key: 'vendor_id');
  }

  Future<String?> getVendorRole() async {
    return await _storage.read(key: 'vendor_role');
  }

  Future<bool> isTokenExpired() async {
    final token = await _storage.read(key: 'access_token');
    if (token == null) return true;
    return JwtDecoder.isExpired(token);
  }

  Future<String> refreshToken() async {
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');
      if (refreshToken == null) throw 'NO_REFRESH_TOKEN';

      final dio = Dio(BaseOptions(baseUrl: _apiClient.dio.options.baseUrl));
      final response = await dio.post(
        '/auth/refresh',
        options: Options(headers: {
          'Authorization': 'Bearer $refreshToken',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>;
        final newAccessToken = data['access_token'];
        final newRefreshToken = data['refresh_token'];

        await _storage.write(key: 'access_token', value: newAccessToken);
        await _storage.write(key: 'refresh_token', value: newRefreshToken);

        return newAccessToken;
      }
      throw 'REFRESH_FAILED';
    } catch (e) {
      print('AuthRepository refreshToken error: $e');
      rethrow;
    }
  }
}

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
        
        // Role check (Disabled for testing/developer access)
        final userData = data['user'] as Map<String, dynamic>;
        final role = userData['role'] as String;
        // if (role == 'CUSTOMER') {
        //   throw 'ACCESS_DENIED';
        // }

        await _storage.write(key: 'access_token', value: data['access_token']);
        await _storage.write(key: 'refresh_token', value: data['refresh_token']);
        await _storage.write(key: 'user_id', value: userData['id']?.toString());
        await _storage.write(key: 'user_role', value: role);
        await _storage.write(key: 'user_name', value: userData['name']?.toString());
        
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

  Future<void> saveProfileInfo(String email, String password, String name, String role) async {
    await _storage.write(key: 'saved_email', value: email);
    await _storage.write(key: 'saved_password', value: password);
    await _storage.write(key: 'saved_name', value: name);
    await _storage.write(key: 'saved_role', value: role);
  }

  Future<Map<String, String>?> getSavedProfile() async {
    final email = await _storage.read(key: 'saved_email');
    final password = await _storage.read(key: 'saved_password');
    final name = await _storage.read(key: 'saved_name');
    final role = await _storage.read(key: 'saved_role');
    
    if (email != null) {
      return {
        'email': email,
        'password': password ?? '',
        'name': name ?? '',
        'role': role ?? '',
      };
    }
    return null;
  }

  Future<void> deleteSavedProfile() async {
    await _storage.delete(key: 'saved_email');
    await _storage.delete(key: 'saved_password');
    await _storage.delete(key: 'saved_name');
    await _storage.delete(key: 'saved_role');
  }

  Future<void> logout() async {
    // Save these before deleting all
    final savedEmail = await _storage.read(key: 'saved_email');
    final savedPassword = await _storage.read(key: 'saved_password');
    final savedName = await _storage.read(key: 'saved_name');
    final savedRole = await _storage.read(key: 'saved_role');

    await _storage.deleteAll();

    // Restore saved profile info if it existed
    if (savedEmail != null) {
      await _storage.write(key: 'saved_email', value: savedEmail);
      if (savedPassword != null) await _storage.write(key: 'saved_password', value: savedPassword);
      if (savedName != null) await _storage.write(key: 'saved_name', value: savedName);
      if (savedRole != null) await _storage.write(key: 'saved_role', value: savedRole);
    }
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

  Future<String?> getUserName() async {
    final cached = await _storage.read(key: 'user_name');
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }
    try {
      final response = await _apiClient.getUsersApi().usersControllerGetUser();
      final dynamic responseMap = (response as dynamic).data;
      if (responseMap is Map && responseMap['data'] != null) {
        final data = responseMap['data'] as Map<String, dynamic>;
        final name = data['name']?.toString();
        if (name != null) {
          await _storage.write(key: 'user_name', value: name);
          return name;
        }
      }
    } catch (e) {
      print('AuthRepository getUserName live fetch error: $e');
    }
    return null;
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

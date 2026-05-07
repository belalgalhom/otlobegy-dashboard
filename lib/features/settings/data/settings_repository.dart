import 'package:dio/dio.dart';
import 'package:otlob_api/otlob_api.dart';

class SettingsRepository {
  final OtlobApi _apiClient;

  SettingsRepository(this._apiClient);

  Dio get _dio => _apiClient.dio;

  Future<Map<String, dynamic>> getSettings() async {
    try {
      final response = await _dio.get('/platform-settings');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateSettings(Map<String, dynamic> settings) async {
    try {
      await _dio.patch('/platform-settings', data: settings);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadHomeCover(List<int> bytes, String fileName) async {
    return _uploadFile('/platform-settings/home-cover', bytes, fileName);
  }

  Future<String> uploadMotorcycleIcon(List<int> bytes, String fileName) async {
    return _uploadFile('/platform-settings/motorcycle-icon', bytes, fileName);
  }

  Future<String> uploadCarIcon(List<int> bytes, String fileName) async {
    return _uploadFile('/platform-settings/car-icon', bytes, fileName);
  }

  Future<String> uploadDeliveryBannerIcon(List<int> bytes, String fileName) async {
    return _uploadFile('/platform-settings/delivery-banner-icon', bytes, fileName);
  }

  Future<String> _uploadFile(String path, List<int> bytes, String fileName) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes, filename: fileName),
      });
      final response = await _dio.post(path, data: formData);
      final data = response.data as Map<String, dynamic>;
      // Usually the response is { data: { url: '...' } } due to TransformInterceptor
      return data['data']['url'] ?? data['url'];
    } catch (e) {
      rethrow;
    }
  }
}

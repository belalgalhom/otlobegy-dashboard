import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:otlob_api/otlob_api.dart';
import 'package:otlob_admin/features/users/data/users_repository.dart';

void main() {
  test('fetch users', () async {
    final dio = Dio();
    dio.options.baseUrl = 'https://api.otlob-egy.online';
    
    // Attempt to call API directly
    final api = OtlobApi(dio: dio, basePathOverride: 'https://api.otlob-egy.online');
    try {
      final response = await api.getUsersApi().usersControllerAdminFindAll();
      print('Response type: \${response.runtimeType}');
      final dynamic data = (response as dynamic).data;
      print('Data type: \${data.runtimeType}');
      print('Data: \$data');
    } catch(e) {
      print('Caught: \$e');
      if (e is DioException) {
        print('DioException response: \${e.response?.data}');
      }
    }
  });
}

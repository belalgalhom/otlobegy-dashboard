import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otlob_admin/core/models/paginated_result.dart';

class OrdersRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  OrdersRepository(this._dio, this._storage);

  Future<PaginatedResult<dynamic>> getOrders({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      final role = await _storage.read(key: 'user_role');
      final vendorId = await _storage.read(key: 'vendor_id');

      Response response;

      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
        if (status != null && status.isNotEmpty) 'status': status,
      };

      if (role == 'VENDOR' && vendorId != null && vendorId.isNotEmpty) {
        response = await _dio.get(
          '/orders/vendor/$vendorId',
          queryParameters: queryParams,
        );
      } else {
        response = await _dio.get(
          '/orders',
          queryParameters: queryParams,
        );
      }

      final dynamic responseMap = response.data;
      if (responseMap is Map && responseMap['data'] != null) {
        final data = responseMap['data'] as Map<String, dynamic>;
        
        // Supports both array wrapper and raw lists
        List<dynamic> items = [];
        int total = 0;
        
        if (data['orders'] != null) {
          items = data['orders'] as List<dynamic>? ?? [];
          total = data['total'] as int? ?? items.length;
        } else if (data['results'] != null) {
          items = data['results'] as List<dynamic>? ?? [];
          total = data['total'] as int? ?? items.length;
        } else {
          items = responseMap['data'] as List<dynamic>? ?? [];
          total = items.length;
        }
        
        return PaginatedResult(items: items, total: total);
      } else if (responseMap is List) {
        return PaginatedResult(items: responseMap, total: responseMap.length);
      }
      return PaginatedResult.empty();
    } catch (e) {
      print('OrdersRepository getOrders Error: $e');
      if (e is DioException) {
        print('OrdersRepository getOrders Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      }
      return PaginatedResult.empty();
    }
  }

  Future<bool> updateOrderStatus(String orderId, String status, {int? estimatedPrepTime}) async {
    try {
      final response = await _dio.patch(
        '/orders/vendor/$orderId/status',
        data: {
          'status': status,
          if (estimatedPrepTime != null) 'estimatedPrepTime': estimatedPrepTime,
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('OrdersRepository updateOrderStatus Error: $e');
      if (e is DioException) {
        print('OrdersRepository updateOrderStatus Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      }
      return false;
    }
  }

  Future<bool> cancelOrder(String orderId, String reason) async {
    try {
      final response = await _dio.post(
        '/orders/$orderId/cancel',
        data: {
          'reason': reason,
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('OrdersRepository cancelOrder Error: $e');
      return false;
    }
  }
}

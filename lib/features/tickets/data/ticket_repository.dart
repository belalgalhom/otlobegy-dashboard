import 'package:otlob_api/otlob_api.dart';

class TicketRepository {
  final OtlobApi _apiClient;

  TicketRepository(this._apiClient);

  Future<Map<String, dynamic>> getTickets({
    int page = 1,
    int limit = 20,
    String? status,
    String? category,
    String? priority,
  }) async {
    try {
      final response = await _apiClient.dio.get('/tickets', queryParameters: {
        'page': page,
        'limit': limit,
        if (status != null && status != 'ALL') 'status': status,
        if (category != null) 'category': category,
        if (priority != null) 'priority': priority,
      });
      final data = response.data['data'];
      if (data is Map<String, dynamic>) {
        return data;
      }
      return {'tickets': [], 'total': 0};
    } catch (e) {
      print('TicketRepository getTickets Error: $e');
      return {'tickets': [], 'total': 0};
    }
  }

  Future<bool> updateTicketStatus(String ticketId, String status) async {
    try {
      await _apiClient.dio.patch('/tickets/$ticketId', data: {
        'status': status,
      });
      return true;
    } catch (e) {
      print('TicketRepository updateTicketStatus Error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getTicketDetails(String ticketId) async {
    try {
      final response = await _apiClient.dio.get('/tickets/$ticketId');
      final data = response.data['data'];
      if (data is Map<String, dynamic>) {
        return data;
      }
      return null;
    } catch (e) {
      print('TicketRepository getTicketDetails Error: $e');
      return null;
    }
  }
}

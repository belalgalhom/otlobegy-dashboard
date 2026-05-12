import 'package:dio/dio.dart';
import 'package:otlob_api/otlob_api.dart';

class ChatRepository {
  final OtlobApi _apiClient;

  ChatRepository(this._apiClient);

  Future<List<dynamic>> getConversations({int page = 1, int limit = 20}) async {
    try {
      final response = await _apiClient.dio.get(
        '/chat/conversations',
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = response.data['data'];
      if (data is Map && data['conversations'] != null) {
        return data['conversations'] as List<dynamic>;
      }
      return [];
    } catch (e) {
      print('ChatRepository getConversations Error: $e');
      return [];
    }
  }

  Future<List<dynamic>> getMessages(String conversationId, {String? before}) async {
    try {
      final response = await _apiClient.dio.get(
        '/chat/conversations/$conversationId/messages',
        queryParameters: before != null ? {'before': before} : null,
      );
      final data = response.data['data'];
      if (data is Map && data['messages'] != null) {
        return data['messages'] as List<dynamic>;
      }
      return [];
    } catch (e) {
      print('ChatRepository getMessages Error: $e');
      return [];
    }
  }

  Future<bool> sendMessage(String conversationId, String text, {String type = 'TEXT', String? mediaUrl, Map<String, dynamic>? metadata}) async {
    try {
      await _apiClient.dio.post(
        '/chat/conversations/$conversationId/messages',
        data: {
          'type': type,
          'text': text.isEmpty ? null : text,
          'mediaUrl': mediaUrl,
          if (metadata != null) 'metadata': metadata,
        },
      );
      return true;
    } catch (e) {
      print('ChatRepository sendMessage Error: $e');
      return false;
    }
  }

  Future<String?> uploadMedia(String conversationId, String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      final response = await _apiClient.dio.post(
        '/chat/conversations/$conversationId/messages/upload',
        data: formData,
      );
      final data = response.data;
      if (data is Map && data.containsKey('data')) {
        return data['data']['url'] ?? data['url'];
      }
      return data['url'];
    } catch (e) {
      print('ChatRepository uploadMedia Error: $e');
      return null;
    }
  }

  Future<bool> markAsRead(String conversationId, {String? lastReadMessageId}) async {
    try {
      await _apiClient.dio.patch(
        '/chat/conversations/$conversationId/messages/read',
        data: lastReadMessageId != null ? {'lastReadMessageId': lastReadMessageId} : {},
      );
      return true;
    } catch (e) {
      print('ChatRepository markAsRead Error: $e');
      return false;
    }
  }
  Future<bool> deleteMessage(String conversationId, String messageId) async {
    try {
      await _apiClient.dio.delete(
        '/chat/conversations/$conversationId/messages/$messageId',
      );
      return true;
    } catch (e) {
      print('ChatRepository deleteMessage Error: $e');
      return false;
    }
  }

  Future<bool> updateMessage(String conversationId, String messageId, String text) async {
    try {
      await _apiClient.dio.patch(
        '/chat/conversations/$conversationId/messages/$messageId',
        data: {'text': text},
      );
      return true;
    } catch (e) {
      print('ChatRepository updateMessage Error: $e');
      return false;
    }
  }
}

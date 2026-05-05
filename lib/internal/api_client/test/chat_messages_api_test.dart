import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for ChatMessagesApi
void main() {
  final instance = OtlobApi().getChatMessagesApi();

  group(ChatMessagesApi, () {
    // Delete a message
    //
    //Future messagesControllerDelete(String conversationId, String messageId) async
    test('test messagesControllerDelete', () async {
      // TODO
    });

    // List messages in a conversation
    //
    //Future messagesControllerList(String conversationId, { String before, num limit }) async
    test('test messagesControllerList', () async {
      // TODO
    });

    // Mark messages as read
    //
    //Future messagesControllerMarkRead(String conversationId, MarkReadDto markReadDto) async
    test('test messagesControllerMarkRead', () async {
      // TODO
    });

    // Send a message in a conversation
    //
    //Future messagesControllerSend(String conversationId, SendMessageDto sendMessageDto) async
    test('test messagesControllerSend', () async {
      // TODO
    });

  });
}

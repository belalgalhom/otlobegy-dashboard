import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for ChatConversationsApi
void main() {
  final instance = OtlobApi().getChatConversationsApi();

  group(ChatConversationsApi, () {
    // Close a conversation
    //
    //Future conversationsControllerClose(String id) async
    test('test conversationsControllerClose', () async {
      // TODO
    });

    // Create a new conversation for an order
    //
    //Future conversationsControllerCreateOrder(CreateOrderConversationDto createOrderConversationDto) async
    test('test conversationsControllerCreateOrder', () async {
      // TODO
    });

    // Create a new support conversation
    //
    //Future conversationsControllerCreateSupport(CreateSupportConversationDto createSupportConversationDto) async
    test('test conversationsControllerCreateSupport', () async {
      // TODO
    });

    // Get a specific conversation by ID
    //
    //Future conversationsControllerGetOne(String id) async
    test('test conversationsControllerGetOne', () async {
      // TODO
    });

    // List my conversations
    //
    //Future conversationsControllerListMine({ num page, num limit }) async
    test('test conversationsControllerListMine', () async {
      // TODO
    });

  });
}

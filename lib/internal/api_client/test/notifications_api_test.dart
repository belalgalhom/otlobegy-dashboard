import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for NotificationsApi
void main() {
  final instance = OtlobApi().getNotificationsApi();

  group(NotificationsApi, () {
    // Delete all read notifications
    //
    //Future notificationsControllerDeleteAllRead() async
    test('test notificationsControllerDeleteAllRead', () async {
      // TODO
    });

    // Delete a specific notification
    //
    //Future notificationsControllerDeleteOne(String id) async
    test('test notificationsControllerDeleteOne', () async {
      // TODO
    });

    // Get a specific notification by ID
    //
    //Future notificationsControllerGetOne(String id) async
    test('test notificationsControllerGetOne', () async {
      // TODO
    });

    // List my notifications
    //
    //Future notificationsControllerList({ bool unreadOnly, String type, num page, num limit }) async
    test('test notificationsControllerList', () async {
      // TODO
    });

    // Mark a specific notification as read
    //
    //Future notificationsControllerMarkOneRead(String id) async
    test('test notificationsControllerMarkOneRead', () async {
      // TODO
    });

    // Mark multiple notifications as read
    //
    //Future notificationsControllerMarkRead(MarkNotificationsReadDto markNotificationsReadDto) async
    test('test notificationsControllerMarkRead', () async {
      // TODO
    });

    // Get unread notifications count
    //
    //Future notificationsControllerUnreadCount() async
    test('test notificationsControllerUnreadCount', () async {
      // TODO
    });

  });
}

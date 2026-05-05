import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for InboxSummaryCountsApi
void main() {
  final instance = OtlobApi().getInboxSummaryCountsApi();

  group(InboxSummaryCountsApi, () {
    // Get unread counts for chat and notifications
    //
    //Future inboxControllerGetCounts() async
    test('test inboxControllerGetCounts', () async {
      // TODO
    });

  });
}

import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for SupportTicketsApi
void main() {
  final instance = OtlobApi().getSupportTicketsApi();

  group(SupportTicketsApi, () {
    // Create a new support ticket
    //
    //Future ticketsControllerCreate(CreateTicketDto createTicketDto) async
    test('test ticketsControllerCreate', () async {
      // TODO
    });

    // Get a specific support ticket by ID
    //
    //Future ticketsControllerGetOne(String id) async
    test('test ticketsControllerGetOne', () async {
      // TODO
    });

    // List support tickets with filters
    //
    //Future ticketsControllerList({ String status, String priority, String category, String assigneeId, String creatorId, num page, num limit }) async
    test('test ticketsControllerList', () async {
      // TODO
    });

    // Delete/Cancel a support ticket
    //
    //Future ticketsControllerRemove(String id) async
    test('test ticketsControllerRemove', () async {
      // TODO
    });

    // Update a support ticket
    //
    //Future ticketsControllerUpdate(String id, UpdateTicketDto updateTicketDto) async
    test('test ticketsControllerUpdate', () async {
      // TODO
    });

  });
}

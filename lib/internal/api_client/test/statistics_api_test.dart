import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for StatisticsApi
void main() {
  final instance = OtlobApi().getStatisticsApi();

  group(StatisticsApi, () {
    // [Admin] Get platform-wide statistics
    //
    //Future statisticsControllerGetAppStats() async
    test('test statisticsControllerGetAppStats', () async {
      // TODO
    });

    // [Admin] Get statistics for a specific driver
    //
    //Future statisticsControllerGetDriverStats(String driverId) async
    test('test statisticsControllerGetDriverStats', () async {
      // TODO
    });

    // Get my driver statistics
    //
    //Future statisticsControllerGetMyDriverStats() async
    test('test statisticsControllerGetMyDriverStats', () async {
      // TODO
    });

    // Get vendor statistics (member or admin)
    //
    //Future statisticsControllerGetVendorStats(String vendorId, { String period }) async
    test('test statisticsControllerGetVendorStats', () async {
      // TODO
    });

  });
}

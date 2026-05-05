import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for LogisticsZonesApi
void main() {
  final instance = OtlobApi().getLogisticsZonesApi();

  group(LogisticsZonesApi, () {
    // Find zone by coordinates
    //
    //Future zonesControllerCheckLocation(CheckLocationDto checkLocationDto) async
    test('test zonesControllerCheckLocation', () async {
      // TODO
    });

    // Create a new delivery zone
    //
    //Future zonesControllerCreate(CreateZoneDto createZoneDto) async
    test('test zonesControllerCreate', () async {
      // TODO
    });

    // List all delivery zones
    //
    //Future zonesControllerFindAll() async
    test('test zonesControllerFindAll', () async {
      // TODO
    });

    // Get a specific zone by ID
    //
    //Future zonesControllerFindOne(String id) async
    test('test zonesControllerFindOne', () async {
      // TODO
    });

    // Delete a delivery zone
    //
    //Future zonesControllerRemove(String id) async
    test('test zonesControllerRemove', () async {
      // TODO
    });

    // Update a delivery zone
    //
    //Future zonesControllerUpdate(String id, UpdateZoneDto updateZoneDto) async
    test('test zonesControllerUpdate', () async {
      // TODO
    });

  });
}

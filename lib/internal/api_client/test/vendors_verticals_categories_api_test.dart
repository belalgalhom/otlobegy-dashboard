import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for VendorsVerticalsCategoriesApi
void main() {
  final instance = OtlobApi().getVendorsVerticalsCategoriesApi();

  group(VendorsVerticalsCategoriesApi, () {
    // Create a new vendor vertical (Admin)
    //
    //Future vendorVerticalsControllerCreate(CreateVendorVerticalDto createVendorVerticalDto) async
    test('test vendorVerticalsControllerCreate', () async {
      // TODO
    });

    // Get all vendor verticals (Admin)
    //
    //Future vendorVerticalsControllerFindAll() async
    test('test vendorVerticalsControllerFindAll', () async {
      // TODO
    });

    // Get all active vendor verticals
    //
    //Future vendorVerticalsControllerFindAllActive() async
    test('test vendorVerticalsControllerFindAllActive', () async {
      // TODO
    });

    // Get a specific vendor vertical by ID
    //
    //Future vendorVerticalsControllerFindOne(String id) async
    test('test vendorVerticalsControllerFindOne', () async {
      // TODO
    });

    // Delete a vendor vertical (Admin)
    //
    //Future vendorVerticalsControllerRemove(String id) async
    test('test vendorVerticalsControllerRemove', () async {
      // TODO
    });

    // Update a vendor vertical (Admin)
    //
    //Future vendorVerticalsControllerUpdate(String id, UpdateVendorVerticalDto updateVendorVerticalDto) async
    test('test vendorVerticalsControllerUpdate', () async {
      // TODO
    });

  });
}

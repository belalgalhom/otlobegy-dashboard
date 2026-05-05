import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for VendorsCoreManagementApi
void main() {
  final instance = OtlobApi().getVendorsCoreManagementApi();

  group(VendorsCoreManagementApi, () {
    // Create a new vendor (Admin)
    //
    //Future vendorsControllerCreate(CreateVendorDto createVendorDto) async
    test('test vendorsControllerCreate', () async {
      // TODO
    });

    // List all vendors with filters
    //
    //Future vendorsControllerFindAll({ String status, String verticalId, String search, num page, num limit }) async
    test('test vendorsControllerFindAll', () async {
      // TODO
    });

    // Find a vendor by its slug
    //
    //Future vendorsControllerFindBySlug(String slug) async
    test('test vendorsControllerFindBySlug', () async {
      // TODO
    });

    // Get a specific vendor by ID
    //
    //Future vendorsControllerFindOne(String vendorId) async
    test('test vendorsControllerFindOne', () async {
      // TODO
    });

    // Get my vendor profile (Member)
    //
    //Future vendorsControllerGetMyVendor(String vendorId) async
    test('test vendorsControllerGetMyVendor', () async {
      // TODO
    });

    // Delete a vendor (Admin)
    //
    //Future vendorsControllerRemove(String vendorId) async
    test('test vendorsControllerRemove', () async {
      // TODO
    });

    // Update vendor information (Admin)
    //
    //Future vendorsControllerUpdate(String vendorId, UpdateVendorDto updateVendorDto) async
    test('test vendorsControllerUpdate', () async {
      // TODO
    });

    // Update vendor status (Admin)
    //
    //Future vendorsControllerUpdateStatus(String vendorId, UpdateVendorStatusDto updateVendorStatusDto) async
    test('test vendorsControllerUpdateStatus', () async {
      // TODO
    });

    // Upload vendor cover image
    //
    //Future vendorsControllerUploadCover(String vendorId, { MultipartFile file }) async
    test('test vendorsControllerUploadCover', () async {
      // TODO
    });

    // Upload vendor logo image
    //
    //Future vendorsControllerUploadLogo(String vendorId, { MultipartFile file }) async
    test('test vendorsControllerUploadLogo', () async {
      // TODO
    });

  });
}

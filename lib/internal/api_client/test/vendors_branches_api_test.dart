import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for VendorsBranchesApi
void main() {
  final instance = OtlobApi().getVendorsBranchesApi();

  group(VendorsBranchesApi, () {
    // Create a new branch (Admin Override)
    //
    //Future vendorBranchesControllerAdminCreate(String vendorId, CreateVendorBranchDto createVendorBranchDto) async
    test('test vendorBranchesControllerAdminCreate', () async {
      // TODO
    });

    // Delete a branch (Admin Override)
    //
    //Future vendorBranchesControllerAdminRemove(String vendorId, String branchId) async
    test('test vendorBranchesControllerAdminRemove', () async {
      // TODO
    });

    // Update a branch (Admin Override)
    //
    //Future vendorBranchesControllerAdminUpdate(String vendorId, String branchId, UpdateVendorBranchDto updateVendorBranchDto) async
    test('test vendorBranchesControllerAdminUpdate', () async {
      // TODO
    });

    // Create a new branch (Member)
    //
    //Future vendorBranchesControllerCreate(String vendorId, CreateVendorBranchDto createVendorBranchDto) async
    test('test vendorBranchesControllerCreate', () async {
      // TODO
    });

    // List all branches for a vendor
    //
    //Future vendorBranchesControllerFindAll(String vendorId) async
    test('test vendorBranchesControllerFindAll', () async {
      // TODO
    });

    // Get a specific branch by ID
    //
    //Future vendorBranchesControllerFindOne(String vendorId, String branchId) async
    test('test vendorBranchesControllerFindOne', () async {
      // TODO
    });

    // Delete a branch (Member)
    //
    //Future vendorBranchesControllerRemove(String vendorId, String branchId) async
    test('test vendorBranchesControllerRemove', () async {
      // TODO
    });

    // Update a branch (Member)
    //
    //Future vendorBranchesControllerUpdate(String vendorId, String branchId, UpdateVendorBranchDto updateVendorBranchDto) async
    test('test vendorBranchesControllerUpdate', () async {
      // TODO
    });

  });
}

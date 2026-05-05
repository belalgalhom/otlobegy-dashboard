import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for VendorsMembersTeamApi
void main() {
  final instance = OtlobApi().getVendorsMembersTeamApi();

  group(VendorsMembersTeamApi, () {
    // Add a new member to the vendor
    //
    //Future vendorMembersControllerAddMember(String vendorId, AddVendorMemberDto addVendorMemberDto) async
    test('test vendorMembersControllerAddMember', () async {
      // TODO
    });

    // Add a new member to a vendor (Admin Override)
    //
    //Future vendorMembersControllerAdminAddMember(String vendorId, AddVendorMemberDto addVendorMemberDto) async
    test('test vendorMembersControllerAdminAddMember', () async {
      // TODO
    });

    // Remove a member from a vendor (Admin Override)
    //
    //Future vendorMembersControllerAdminRemoveMember(String vendorId, String memberId) async
    test('test vendorMembersControllerAdminRemoveMember', () async {
      // TODO
    });

    // List all members of a vendor
    //
    //Future vendorMembersControllerFindAll(String vendorId) async
    test('test vendorMembersControllerFindAll', () async {
      // TODO
    });

    // Remove a member from the vendor
    //
    //Future vendorMembersControllerRemoveMember(String vendorId, String memberId) async
    test('test vendorMembersControllerRemoveMember', () async {
      // TODO
    });

    // Update a member's role
    //
    //Future vendorMembersControllerUpdateRole(String vendorId, String memberId, UpdateVendorMemberRoleDto updateVendorMemberRoleDto) async
    test('test vendorMembersControllerUpdateRole', () async {
      // TODO
    });

  });
}

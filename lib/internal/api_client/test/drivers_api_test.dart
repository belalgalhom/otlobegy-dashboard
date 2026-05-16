import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for DriversApi
void main() {
  final instance = OtlobApi().getDriversApi();

  group(DriversApi, () {
    // [Admin] List all drivers
    //
    //Future driversControllerAdminFindAll({ String status, String search, num page, num limit }) async
    test('test driversControllerAdminFindAll', () async {
      // TODO
    });

    // [Admin] Get a driver by ID
    //
    //Future driversControllerAdminFindOne(String driverId) async
    test('test driversControllerAdminFindOne', () async {
      // TODO
    });

    // [Admin] Suspend a driver
    //
    //Future driversControllerAdminSuspend(String driverId) async
    test('test driversControllerAdminSuspend', () async {
      // TODO
    });

    // [Admin] Unsuspend a driver
    //
    //Future driversControllerAdminUnsuspend(String driverId) async
    test('test driversControllerAdminUnsuspend', () async {
      // TODO
    });

    // Create a shift
    //
    //Future driversControllerCreateShift(CreateDriverShiftDto createDriverShiftDto) async
    test('test driversControllerCreateShift', () async {
      // TODO
    });

    // End a shift
    //
    //Future driversControllerEndShift(String shiftId) async
    test('test driversControllerEndShift', () async {
      // TODO
    });

    // Get my driver profile
    //
    //Future driversControllerGetMyProfile() async
    test('test driversControllerGetMyProfile', () async {
      // TODO
    });

    // Get my shifts
    //
    //Future driversControllerGetMyShifts() async
    test('test driversControllerGetMyShifts', () async {
      // TODO
    });

    // Get wallet balance
    //
    //Future driversControllerGetWalletBalance() async
    test('test driversControllerGetWalletBalance', () async {
      // TODO
    });

    // Get wallet transaction history
    //
    //Future driversControllerGetWalletTransactions({ num page, num limit }) async
    test('test driversControllerGetWalletTransactions', () async {
      // TODO
    });

    // Register as a driver (creates driver profile, upgrades role)
    //
    //Future driversControllerRegister(RegisterDriverDto registerDriverDto) async
    test('test driversControllerRegister', () async {
      // TODO
    });

    // Start a shift
    //
    //Future driversControllerStartShift(String shiftId) async
    test('test driversControllerStartShift', () async {
      // TODO
    });

    // Update driver GPS location (call frequently ~5s)
    //
    //Future driversControllerUpdateLocation(UpdateDriverLocationDto updateDriverLocationDto) async
    test('test driversControllerUpdateLocation', () async {
      // TODO
    });

    // Update my driver profile
    //
    //Future driversControllerUpdateProfile(UpdateDriverProfileDto updateDriverProfileDto) async
    test('test driversControllerUpdateProfile', () async {
      // TODO
    });

    // Update driver status (ONLINE / OFFLINE / ON_BREAK)
    //
    //Future driversControllerUpdateStatus(UpdateDriverStatusDto updateDriverStatusDto) async
    test('test driversControllerUpdateStatus', () async {
      // TODO
    });

    // Upload driver avatar
    //
    //Future driversControllerUploadAvatar({ MultipartFile file }) async
    test('test driversControllerUploadAvatar', () async {
      // TODO
    });

  });
}

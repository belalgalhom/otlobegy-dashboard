import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for PlatformSettingsVersioningApi
void main() {
  final instance = OtlobApi().getPlatformSettingsVersioningApi();

  group(PlatformSettingsVersioningApi, () {
    // Check if app version is supported
    //
    //Future platformSettingsControllerCheckVersion(AppVersionCheckDto appVersionCheckDto) async
    test('test platformSettingsControllerCheckVersion', () async {
      // TODO
    });

    // Get all platform settings (Admin)
    //
    //Future platformSettingsControllerGetAll() async
    test('test platformSettingsControllerGetAll', () async {
      // TODO
    });

    // Get public platform settings (maintenance mode, versions)
    //
    //Future platformSettingsControllerGetPublic() async
    test('test platformSettingsControllerGetPublic', () async {
      // TODO
    });

    // Update platform settings (Admin)
    //
    //Future platformSettingsControllerUpdate(UpdatePlatformSettingsDto updatePlatformSettingsDto) async
    test('test platformSettingsControllerUpdate', () async {
      // TODO
    });

  });
}

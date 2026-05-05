import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for DevicesPushNotificationsApi
void main() {
  final instance = OtlobApi().getDevicesPushNotificationsApi();

  group(DevicesPushNotificationsApi, () {
    // Register a device for push notifications
    //
    //Future devicesControllerRegister(RegisterDeviceDto registerDeviceDto) async
    test('test devicesControllerRegister', () async {
      // TODO
    });

    // Remove a device token
    //
    //Future devicesControllerRemove(String token) async
    test('test devicesControllerRemove', () async {
      // TODO
    });

  });
}

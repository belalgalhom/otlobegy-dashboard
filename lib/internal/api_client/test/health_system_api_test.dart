import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for HealthSystemApi
void main() {
  final instance = OtlobApi().getHealthSystemApi();

  group(HealthSystemApi, () {
    // API Health Check
    //
    //Future apiControllerRoot() async
    test('test apiControllerRoot', () async {
      // TODO
    });

  });
}

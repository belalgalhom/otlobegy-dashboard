import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for PromotionsApi
void main() {
  final instance = OtlobApi().getPromotionsApi();

  group(PromotionsApi, () {
    //Future promotionsControllerCreate(CreatePromotionDto createPromotionDto) async
    test('test promotionsControllerCreate', () async {
      // TODO
    });

    // Get all promotions (Admin)
    //
    //Future promotionsControllerFindAll() async
    test('test promotionsControllerFindAll', () async {
      // TODO
    });

    // Get all active promotions for customer app
    //
    //Future promotionsControllerFindAllActive() async
    test('test promotionsControllerFindAllActive', () async {
      // TODO
    });

    //Future promotionsControllerFindOne(String id) async
    test('test promotionsControllerFindOne', () async {
      // TODO
    });

    //Future promotionsControllerRemove(String id) async
    test('test promotionsControllerRemove', () async {
      // TODO
    });

    //Future promotionsControllerUpdate(String id, UpdatePromotionDto updatePromotionDto) async
    test('test promotionsControllerUpdate', () async {
      // TODO
    });

    //Future promotionsControllerUploadImage(String id) async
    test('test promotionsControllerUploadImage', () async {
      // TODO
    });

  });
}

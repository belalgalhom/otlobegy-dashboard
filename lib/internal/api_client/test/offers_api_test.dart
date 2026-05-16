import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for OffersApi
void main() {
  final instance = OtlobApi().getOffersApi();

  group(OffersApi, () {
    // Create new product offer
    //
    //Future offersControllerCreate(CreateOfferDto createOfferDto) async
    test('test offersControllerCreate', () async {
      // TODO
    });

    // Get all offers (Admin)
    //
    //Future offersControllerFindAll() async
    test('test offersControllerFindAll', () async {
      // TODO
    });

    // Get all active product offers
    //
    //Future offersControllerFindAllActive() async
    test('test offersControllerFindAllActive', () async {
      // TODO
    });

    // Delete product offer
    //
    //Future offersControllerRemove(String id) async
    test('test offersControllerRemove', () async {
      // TODO
    });

    // Update product offer
    //
    //Future offersControllerUpdate(String id, UpdateOfferDto updateOfferDto) async
    test('test offersControllerUpdate', () async {
      // TODO
    });

  });
}

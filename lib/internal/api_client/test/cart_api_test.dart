import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for CartApi
void main() {
  final instance = OtlobApi().getCartApi();

  group(CartApi, () {
    // Add item to cart
    //
    //Future cartControllerAddItem(String vendorId, AddCartItemDto addCartItemDto) async
    test('test cartControllerAddItem', () async {
      // TODO
    });

    // Clear entire cart for a vendor
    //
    //Future cartControllerClearCart(String vendorId) async
    test('test cartControllerClearCart', () async {
      // TODO
    });

    // Get cart for a specific vendor
    //
    //Future cartControllerGetCart(String vendorId) async
    test('test cartControllerGetCart', () async {
      // TODO
    });

    // Get all my carts (one per vendor)
    //
    //Future cartControllerGetMyCarts() async
    test('test cartControllerGetMyCarts', () async {
      // TODO
    });

    // Remove item from cart
    //
    //Future cartControllerRemoveItem(String vendorId, String itemId) async
    test('test cartControllerRemoveItem', () async {
      // TODO
    });

    // Update cart item (quantity / options)
    //
    //Future cartControllerUpdateItem(String vendorId, String itemId, UpdateCartItemDto updateCartItemDto) async
    test('test cartControllerUpdateItem', () async {
      // TODO
    });

  });
}

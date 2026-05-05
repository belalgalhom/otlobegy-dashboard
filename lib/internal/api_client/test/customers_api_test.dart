import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for CustomersApi
void main() {
  final instance = OtlobApi().getCustomersApi();

  group(CustomersApi, () {
    // [Admin] Prevent customer from placing orders (canOrder → false)
    //
    //Future customersControllerAdminDisableOrdering(String customerId) async
    test('test customersControllerAdminDisableOrdering', () async {
      // TODO
    });

    // [Admin] Allow customer to place orders (canOrder → true)
    //
    //Future customersControllerAdminEnableOrdering(String customerId) async
    test('test customersControllerAdminEnableOrdering', () async {
      // TODO
    });

    // [Admin] List all customers — filter by canOrder, includeDeleted, search
    //
    //Future customersControllerAdminFindAll({ bool canOrder, bool includeDeleted, String search, num page, num limit }) async
    test('test customersControllerAdminFindAll', () async {
      // TODO
    });

    // [Admin] Get a customer by their userId
    //
    //Future customersControllerAdminFindByUserId(String userId) async
    test('test customersControllerAdminFindByUserId', () async {
      // TODO
    });

    // [Admin] Get a customer — includes counts + last 5 orders
    //
    //Future customersControllerAdminFindOne(String customerId) async
    test('test customersControllerAdminFindOne', () async {
      // TODO
    });

    // [Admin] List a customer's saved addresses
    //
    //Future customersControllerAdminGetAddresses(String customerId) async
    test('test customersControllerAdminGetAddresses', () async {
      // TODO
    });

    // [Admin] List a customer's full order history (paginated)
    //
    //Future customersControllerAdminGetOrders(String customerId, { num page, num limit }) async
    test('test customersControllerAdminGetOrders', () async {
      // TODO
    });

    // [Admin] Hard-delete a customer (cascades to addresses, carts, favorites). Parent User is untouched.
    //
    //Future customersControllerAdminRemove(String customerId) async
    test('test customersControllerAdminRemove', () async {
      // TODO
    });

    // Add a new address
    //
    //Future customersControllerCreateAddress(CreateAddressDto createAddressDto) async
    test('test customersControllerCreateAddress', () async {
      // TODO
    });

    // Delete an address
    //
    //Future customersControllerDeleteAddress(String id) async
    test('test customersControllerDeleteAddress', () async {
      // TODO
    });

    // Get my addresses
    //
    //Future customersControllerGetAddresses() async
    test('test customersControllerGetAddresses', () async {
      // TODO
    });

    // Get my favorites (vendors + products)
    //
    //Future customersControllerGetFavorites() async
    test('test customersControllerGetFavorites', () async {
      // TODO
    });

    // Toggle product favorite
    //
    //Future customersControllerToggleFavoriteProduct(String productId) async
    test('test customersControllerToggleFavoriteProduct', () async {
      // TODO
    });

    // Toggle vendor favorite
    //
    //Future customersControllerToggleFavoriteVendor(String vendorId) async
    test('test customersControllerToggleFavoriteVendor', () async {
      // TODO
    });

    // Update an address
    //
    //Future customersControllerUpdateAddress(String id, UpdateAddressDto updateAddressDto) async
    test('test customersControllerUpdateAddress', () async {
      // TODO
    });

  });
}

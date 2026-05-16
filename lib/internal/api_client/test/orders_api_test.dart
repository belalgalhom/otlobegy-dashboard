import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for OrdersApi
void main() {
  final instance = OtlobApi().getOrdersApi();

  group(OrdersApi, () {
    // [Admin] List all orders with filters
    //
    //Future ordersControllerAdminFindAll({ String status, String vendorId, String driverId, String customerId, num page, num limit }) async
    test('test ordersControllerAdminFindAll', () async {
      // TODO
    });

    // [Admin] Force-assign a driver to an order
    //
    //Future ordersControllerAdminForceAssignDriver(String orderId, AdminAssignDriverDto adminAssignDriverDto) async
    test('test ordersControllerAdminForceAssignDriver', () async {
      // TODO
    });

    // Cancel an order (customer or vendor)
    //
    //Future ordersControllerCancelOrder(String orderId) async
    test('test ordersControllerCancelOrder', () async {
      // TODO
    });

    // Driver updates order status (PICKED_UP / DELIVERED)
    //
    //Future ordersControllerDriverUpdateStatus(String orderId, UpdateOrderStatusDto updateOrderStatusDto) async
    test('test ordersControllerDriverUpdateStatus', () async {
      // TODO
    });

    // Get my pending dispatch requests
    //
    //Future ordersControllerGetMyDispatches() async
    test('test ordersControllerGetMyDispatches', () async {
      // TODO
    });

    // Get my order history (customer)
    //
    //Future ordersControllerGetMyOrdersAsCustomer({ String status, String vendorId, String driverId, String customerId, num page, num limit }) async
    test('test ordersControllerGetMyOrdersAsCustomer', () async {
      // TODO
    });

    // Get my orders as driver
    //
    //Future ordersControllerGetMyOrdersAsDriver({ String status, String vendorId, String driverId, String customerId, num page, num limit }) async
    test('test ordersControllerGetMyOrdersAsDriver', () async {
      // TODO
    });

    // Get a single order (customer/driver/vendor/admin)
    //
    //Future ordersControllerGetOne(String orderId) async
    test('test ordersControllerGetOne', () async {
      // TODO
    });

    // Get orders for a vendor (vendor member or admin)
    //
    //Future ordersControllerGetVendorOrders(String vendorId, { String status, String vendorId2, String driverId, String customerId, num page, num limit }) async
    test('test ordersControllerGetVendorOrders', () async {
      // TODO
    });

    // Place a new order from active cart
    //
    //Future ordersControllerPlaceOrder(PlaceOrderDto placeOrderDto) async
    test('test ordersControllerPlaceOrder', () async {
      // TODO
    });

    // Accept or reject a dispatch request
    //
    //Future ordersControllerRespondToDispatch(String dispatchId, RespondToDispatchDto respondToDispatchDto) async
    test('test ordersControllerRespondToDispatch', () async {
      // TODO
    });

    // Vendor updates order status
    //
    //Future ordersControllerVendorUpdateStatus(String orderId, UpdateOrderStatusDto updateOrderStatusDto) async
    test('test ordersControllerVendorUpdateStatus', () async {
      // TODO
    });

  });
}

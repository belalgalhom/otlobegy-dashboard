# otlob_api.api.OrdersApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ordersControllerAdminFindAll**](OrdersApi.md#orderscontrolleradminfindall) | **GET** /orders | [Admin] List all orders with filters
[**ordersControllerAdminForceAssignDriver**](OrdersApi.md#orderscontrolleradminforceassigndriver) | **POST** /orders/{orderId}/assign-driver | [Admin] Force-assign a driver to an order
[**ordersControllerCancelOrder**](OrdersApi.md#orderscontrollercancelorder) | **POST** /orders/{orderId}/cancel | Cancel an order (customer or vendor)
[**ordersControllerDriverUpdateStatus**](OrdersApi.md#orderscontrollerdriverupdatestatus) | **PATCH** /orders/driver/{orderId}/status | Driver updates order status (PICKED_UP / DELIVERED)
[**ordersControllerGetMyDispatches**](OrdersApi.md#orderscontrollergetmydispatches) | **GET** /orders/driver/dispatches | Get my pending dispatch requests
[**ordersControllerGetMyOrdersAsCustomer**](OrdersApi.md#orderscontrollergetmyordersascustomer) | **GET** /orders/my | Get my order history (customer)
[**ordersControllerGetMyOrdersAsDriver**](OrdersApi.md#orderscontrollergetmyordersasdriver) | **GET** /orders/driver/my | Get my orders as driver
[**ordersControllerGetOne**](OrdersApi.md#orderscontrollergetone) | **GET** /orders/{orderId} | Get a single order (customer/driver/vendor/admin)
[**ordersControllerGetVendorOrders**](OrdersApi.md#orderscontrollergetvendororders) | **GET** /orders/vendor/{vendorId} | Get orders for a vendor (vendor member or admin)
[**ordersControllerPlaceOrder**](OrdersApi.md#orderscontrollerplaceorder) | **POST** /orders | Place a new order from active cart
[**ordersControllerRespondToDispatch**](OrdersApi.md#orderscontrollerrespondtodispatch) | **POST** /orders/driver/dispatches/{dispatchId}/respond | Accept or reject a dispatch request
[**ordersControllerVendorUpdateStatus**](OrdersApi.md#orderscontrollervendorupdatestatus) | **PATCH** /orders/vendor/{orderId}/status | Vendor updates order status


# **ordersControllerAdminFindAll**
> ordersControllerAdminFindAll(status, vendorId, driverId, customerId, page, limit)

[Admin] List all orders with filters

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String status = status_example; // String | 
final String vendorId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String driverId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String customerId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.ordersControllerAdminFindAll(status, vendorId, driverId, customerId, page, limit);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerAdminFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 
 **vendorId** | **String**|  | [optional] 
 **driverId** | **String**|  | [optional] 
 **customerId** | **String**|  | [optional] 
 **page** | **num**|  | [optional] [default to 1]
 **limit** | **num**|  | [optional] [default to 20]

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerAdminForceAssignDriver**
> ordersControllerAdminForceAssignDriver(orderId, adminAssignDriverDto)

[Admin] Force-assign a driver to an order

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String orderId = orderId_example; // String | 
final AdminAssignDriverDto adminAssignDriverDto = ; // AdminAssignDriverDto | 

try {
    api.ordersControllerAdminForceAssignDriver(orderId, adminAssignDriverDto);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerAdminForceAssignDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 
 **adminAssignDriverDto** | [**AdminAssignDriverDto**](AdminAssignDriverDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerCancelOrder**
> ordersControllerCancelOrder(orderId)

Cancel an order (customer or vendor)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String orderId = orderId_example; // String | 

try {
    api.ordersControllerCancelOrder(orderId);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerCancelOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerDriverUpdateStatus**
> ordersControllerDriverUpdateStatus(orderId, updateOrderStatusDto)

Driver updates order status (PICKED_UP / DELIVERED)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String orderId = orderId_example; // String | 
final UpdateOrderStatusDto updateOrderStatusDto = ; // UpdateOrderStatusDto | 

try {
    api.ordersControllerDriverUpdateStatus(orderId, updateOrderStatusDto);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerDriverUpdateStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 
 **updateOrderStatusDto** | [**UpdateOrderStatusDto**](UpdateOrderStatusDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerGetMyDispatches**
> ordersControllerGetMyDispatches()

Get my pending dispatch requests

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();

try {
    api.ordersControllerGetMyDispatches();
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerGetMyDispatches: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerGetMyOrdersAsCustomer**
> ordersControllerGetMyOrdersAsCustomer(status, vendorId, driverId, customerId, page, limit)

Get my order history (customer)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String status = status_example; // String | 
final String vendorId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String driverId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String customerId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.ordersControllerGetMyOrdersAsCustomer(status, vendorId, driverId, customerId, page, limit);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerGetMyOrdersAsCustomer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 
 **vendorId** | **String**|  | [optional] 
 **driverId** | **String**|  | [optional] 
 **customerId** | **String**|  | [optional] 
 **page** | **num**|  | [optional] [default to 1]
 **limit** | **num**|  | [optional] [default to 20]

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerGetMyOrdersAsDriver**
> ordersControllerGetMyOrdersAsDriver(status, vendorId, driverId, customerId, page, limit)

Get my orders as driver

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String status = status_example; // String | 
final String vendorId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String driverId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String customerId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.ordersControllerGetMyOrdersAsDriver(status, vendorId, driverId, customerId, page, limit);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerGetMyOrdersAsDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 
 **vendorId** | **String**|  | [optional] 
 **driverId** | **String**|  | [optional] 
 **customerId** | **String**|  | [optional] 
 **page** | **num**|  | [optional] [default to 1]
 **limit** | **num**|  | [optional] [default to 20]

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerGetOne**
> ordersControllerGetOne(orderId)

Get a single order (customer/driver/vendor/admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String orderId = orderId_example; // String | 

try {
    api.ordersControllerGetOne(orderId);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerGetOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerGetVendorOrders**
> ordersControllerGetVendorOrders(vendorId, status, vendorId2, driverId, customerId, page, limit)

Get orders for a vendor (vendor member or admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String vendorId = vendorId_example; // String | 
final String status = status_example; // String | 
final String vendorId2 = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String driverId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String customerId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.ordersControllerGetVendorOrders(vendorId, status, vendorId2, driverId, customerId, page, limit);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerGetVendorOrders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **status** | **String**|  | [optional] 
 **vendorId2** | **String**|  | [optional] 
 **driverId** | **String**|  | [optional] 
 **customerId** | **String**|  | [optional] 
 **page** | **num**|  | [optional] [default to 1]
 **limit** | **num**|  | [optional] [default to 20]

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerPlaceOrder**
> ordersControllerPlaceOrder(placeOrderDto)

Place a new order from active cart

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final PlaceOrderDto placeOrderDto = ; // PlaceOrderDto | 

try {
    api.ordersControllerPlaceOrder(placeOrderDto);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerPlaceOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **placeOrderDto** | [**PlaceOrderDto**](PlaceOrderDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerRespondToDispatch**
> ordersControllerRespondToDispatch(dispatchId, respondToDispatchDto)

Accept or reject a dispatch request

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String dispatchId = dispatchId_example; // String | 
final RespondToDispatchDto respondToDispatchDto = ; // RespondToDispatchDto | 

try {
    api.ordersControllerRespondToDispatch(dispatchId, respondToDispatchDto);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerRespondToDispatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dispatchId** | **String**|  | 
 **respondToDispatchDto** | [**RespondToDispatchDto**](RespondToDispatchDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ordersControllerVendorUpdateStatus**
> ordersControllerVendorUpdateStatus(orderId, updateOrderStatusDto)

Vendor updates order status

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOrdersApi();
final String orderId = orderId_example; // String | 
final UpdateOrderStatusDto updateOrderStatusDto = ; // UpdateOrderStatusDto | 

try {
    api.ordersControllerVendorUpdateStatus(orderId, updateOrderStatusDto);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->ordersControllerVendorUpdateStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 
 **updateOrderStatusDto** | [**UpdateOrderStatusDto**](UpdateOrderStatusDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


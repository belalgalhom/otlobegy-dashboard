# otlob_api.api.VendorsWalletTransactionsApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**vendorWalletControllerAdminGetBalance**](VendorsWalletTransactionsApi.md#vendorwalletcontrolleradmingetbalance) | **GET** /vendors/{vendorId}/wallet/admin/balance | Get any vendor&#39;s wallet balance (Admin)
[**vendorWalletControllerAdminListTransactions**](VendorsWalletTransactionsApi.md#vendorwalletcontrolleradminlisttransactions) | **GET** /vendors/{vendorId}/wallet/admin/transactions | List any vendor&#39;s wallet transactions (Admin)
[**vendorWalletControllerGetBalance**](VendorsWalletTransactionsApi.md#vendorwalletcontrollergetbalance) | **GET** /vendors/{vendorId}/wallet/balance | Get vendor wallet balance (Member)
[**vendorWalletControllerListTransactions**](VendorsWalletTransactionsApi.md#vendorwalletcontrollerlisttransactions) | **GET** /vendors/{vendorId}/wallet/transactions | List vendor wallet transactions (Member)


# **vendorWalletControllerAdminGetBalance**
> vendorWalletControllerAdminGetBalance(vendorId)

Get any vendor's wallet balance (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsWalletTransactionsApi();
final String vendorId = vendorId_example; // String | 

try {
    api.vendorWalletControllerAdminGetBalance(vendorId);
} on DioException catch (e) {
    print('Exception when calling VendorsWalletTransactionsApi->vendorWalletControllerAdminGetBalance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorWalletControllerAdminListTransactions**
> vendorWalletControllerAdminListTransactions(vendorId, type, from, to, page, limit)

List any vendor's wallet transactions (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsWalletTransactionsApi();
final String vendorId = vendorId_example; // String | 
final String type = type_example; // String | 
final String from = 2023-01-01; // String | 
final String to = 2023-12-31; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.vendorWalletControllerAdminListTransactions(vendorId, type, from, to, page, limit);
} on DioException catch (e) {
    print('Exception when calling VendorsWalletTransactionsApi->vendorWalletControllerAdminListTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **type** | **String**|  | [optional] 
 **from** | **String**|  | [optional] 
 **to** | **String**|  | [optional] 
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

# **vendorWalletControllerGetBalance**
> vendorWalletControllerGetBalance(vendorId)

Get vendor wallet balance (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsWalletTransactionsApi();
final String vendorId = vendorId_example; // String | 

try {
    api.vendorWalletControllerGetBalance(vendorId);
} on DioException catch (e) {
    print('Exception when calling VendorsWalletTransactionsApi->vendorWalletControllerGetBalance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorWalletControllerListTransactions**
> vendorWalletControllerListTransactions(vendorId, type, from, to, page, limit)

List vendor wallet transactions (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsWalletTransactionsApi();
final String vendorId = vendorId_example; // String | 
final String type = type_example; // String | 
final String from = 2023-01-01; // String | 
final String to = 2023-12-31; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.vendorWalletControllerListTransactions(vendorId, type, from, to, page, limit);
} on DioException catch (e) {
    print('Exception when calling VendorsWalletTransactionsApi->vendorWalletControllerListTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **type** | **String**|  | [optional] 
 **from** | **String**|  | [optional] 
 **to** | **String**|  | [optional] 
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


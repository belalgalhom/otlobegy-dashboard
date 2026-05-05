# otlob_api.api.VendorsVerticalsCategoriesApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**vendorVerticalsControllerCreate**](VendorsVerticalsCategoriesApi.md#vendorverticalscontrollercreate) | **POST** /vendor-verticals | Create a new vendor vertical (Admin)
[**vendorVerticalsControllerFindAll**](VendorsVerticalsCategoriesApi.md#vendorverticalscontrollerfindall) | **GET** /vendor-verticals/admin | Get all vendor verticals (Admin)
[**vendorVerticalsControllerFindAllActive**](VendorsVerticalsCategoriesApi.md#vendorverticalscontrollerfindallactive) | **GET** /vendor-verticals | Get all active vendor verticals
[**vendorVerticalsControllerFindOne**](VendorsVerticalsCategoriesApi.md#vendorverticalscontrollerfindone) | **GET** /vendor-verticals/{id} | Get a specific vendor vertical by ID
[**vendorVerticalsControllerRemove**](VendorsVerticalsCategoriesApi.md#vendorverticalscontrollerremove) | **DELETE** /vendor-verticals/{id} | Delete a vendor vertical (Admin)
[**vendorVerticalsControllerUpdate**](VendorsVerticalsCategoriesApi.md#vendorverticalscontrollerupdate) | **PATCH** /vendor-verticals/{id} | Update a vendor vertical (Admin)


# **vendorVerticalsControllerCreate**
> vendorVerticalsControllerCreate(createVendorVerticalDto)

Create a new vendor vertical (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsVerticalsCategoriesApi();
final CreateVendorVerticalDto createVendorVerticalDto = ; // CreateVendorVerticalDto | 

try {
    api.vendorVerticalsControllerCreate(createVendorVerticalDto);
} on DioException catch (e) {
    print('Exception when calling VendorsVerticalsCategoriesApi->vendorVerticalsControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createVendorVerticalDto** | [**CreateVendorVerticalDto**](CreateVendorVerticalDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorVerticalsControllerFindAll**
> vendorVerticalsControllerFindAll()

Get all vendor verticals (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsVerticalsCategoriesApi();

try {
    api.vendorVerticalsControllerFindAll();
} on DioException catch (e) {
    print('Exception when calling VendorsVerticalsCategoriesApi->vendorVerticalsControllerFindAll: $e\n');
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

# **vendorVerticalsControllerFindAllActive**
> vendorVerticalsControllerFindAllActive()

Get all active vendor verticals

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsVerticalsCategoriesApi();

try {
    api.vendorVerticalsControllerFindAllActive();
} on DioException catch (e) {
    print('Exception when calling VendorsVerticalsCategoriesApi->vendorVerticalsControllerFindAllActive: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorVerticalsControllerFindOne**
> vendorVerticalsControllerFindOne(id)

Get a specific vendor vertical by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsVerticalsCategoriesApi();
final String id = id_example; // String | 

try {
    api.vendorVerticalsControllerFindOne(id);
} on DioException catch (e) {
    print('Exception when calling VendorsVerticalsCategoriesApi->vendorVerticalsControllerFindOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorVerticalsControllerRemove**
> vendorVerticalsControllerRemove(id)

Delete a vendor vertical (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsVerticalsCategoriesApi();
final String id = id_example; // String | 

try {
    api.vendorVerticalsControllerRemove(id);
} on DioException catch (e) {
    print('Exception when calling VendorsVerticalsCategoriesApi->vendorVerticalsControllerRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorVerticalsControllerUpdate**
> vendorVerticalsControllerUpdate(id, updateVendorVerticalDto)

Update a vendor vertical (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsVerticalsCategoriesApi();
final String id = id_example; // String | 
final UpdateVendorVerticalDto updateVendorVerticalDto = ; // UpdateVendorVerticalDto | 

try {
    api.vendorVerticalsControllerUpdate(id, updateVendorVerticalDto);
} on DioException catch (e) {
    print('Exception when calling VendorsVerticalsCategoriesApi->vendorVerticalsControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateVendorVerticalDto** | [**UpdateVendorVerticalDto**](UpdateVendorVerticalDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


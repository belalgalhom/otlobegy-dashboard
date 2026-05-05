# otlob_api.api.VendorsMenuCategoriesApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**menuCategoriesControllerAdminCreate**](VendorsMenuCategoriesApi.md#menucategoriescontrolleradmincreate) | **POST** /vendors/{vendorId}/categories/admin | Create a new menu category (Admin Override)
[**menuCategoriesControllerAdminRemove**](VendorsMenuCategoriesApi.md#menucategoriescontrolleradminremove) | **DELETE** /vendors/{vendorId}/categories/admin/{categoryId} | Delete a menu category (Admin Override)
[**menuCategoriesControllerAdminUpdate**](VendorsMenuCategoriesApi.md#menucategoriescontrolleradminupdate) | **PATCH** /vendors/{vendorId}/categories/admin/{categoryId} | Update a menu category (Admin Override)
[**menuCategoriesControllerCreate**](VendorsMenuCategoriesApi.md#menucategoriescontrollercreate) | **POST** /vendors/{vendorId}/categories | Create a new menu category (Member)
[**menuCategoriesControllerFindAll**](VendorsMenuCategoriesApi.md#menucategoriescontrollerfindall) | **GET** /vendors/{vendorId}/categories | List all menu categories for a vendor
[**menuCategoriesControllerFindOne**](VendorsMenuCategoriesApi.md#menucategoriescontrollerfindone) | **GET** /vendors/{vendorId}/categories/{categoryId} | Get a specific menu category by ID
[**menuCategoriesControllerRemove**](VendorsMenuCategoriesApi.md#menucategoriescontrollerremove) | **DELETE** /vendors/{vendorId}/categories/{categoryId} | Delete a menu category (Member)
[**menuCategoriesControllerReorder**](VendorsMenuCategoriesApi.md#menucategoriescontrollerreorder) | **PATCH** /vendors/{vendorId}/categories/reorder | Reorder menu categories
[**menuCategoriesControllerUpdate**](VendorsMenuCategoriesApi.md#menucategoriescontrollerupdate) | **PATCH** /vendors/{vendorId}/categories/{categoryId} | Update a menu category (Member)


# **menuCategoriesControllerAdminCreate**
> menuCategoriesControllerAdminCreate(vendorId, createMenuCategoryDto)

Create a new menu category (Admin Override)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final CreateMenuCategoryDto createMenuCategoryDto = ; // CreateMenuCategoryDto | 

try {
    api.menuCategoriesControllerAdminCreate(vendorId, createMenuCategoryDto);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerAdminCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **createMenuCategoryDto** | [**CreateMenuCategoryDto**](CreateMenuCategoryDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCategoriesControllerAdminRemove**
> menuCategoriesControllerAdminRemove(vendorId, categoryId)

Delete a menu category (Admin Override)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final String categoryId = categoryId_example; // String | 

try {
    api.menuCategoriesControllerAdminRemove(vendorId, categoryId);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerAdminRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **categoryId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCategoriesControllerAdminUpdate**
> menuCategoriesControllerAdminUpdate(vendorId, categoryId, updateMenuCategoryDto)

Update a menu category (Admin Override)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final String categoryId = categoryId_example; // String | 
final UpdateMenuCategoryDto updateMenuCategoryDto = ; // UpdateMenuCategoryDto | 

try {
    api.menuCategoriesControllerAdminUpdate(vendorId, categoryId, updateMenuCategoryDto);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerAdminUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **categoryId** | **String**|  | 
 **updateMenuCategoryDto** | [**UpdateMenuCategoryDto**](UpdateMenuCategoryDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCategoriesControllerCreate**
> menuCategoriesControllerCreate(vendorId, createMenuCategoryDto)

Create a new menu category (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final CreateMenuCategoryDto createMenuCategoryDto = ; // CreateMenuCategoryDto | 

try {
    api.menuCategoriesControllerCreate(vendorId, createMenuCategoryDto);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **createMenuCategoryDto** | [**CreateMenuCategoryDto**](CreateMenuCategoryDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCategoriesControllerFindAll**
> menuCategoriesControllerFindAll(vendorId, activeOnly)

List all menu categories for a vendor

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final bool activeOnly = true; // bool | 

try {
    api.menuCategoriesControllerFindAll(vendorId, activeOnly);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **activeOnly** | **bool**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCategoriesControllerFindOne**
> menuCategoriesControllerFindOne(vendorId, categoryId)

Get a specific menu category by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final String categoryId = categoryId_example; // String | 

try {
    api.menuCategoriesControllerFindOne(vendorId, categoryId);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerFindOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **categoryId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCategoriesControllerRemove**
> menuCategoriesControllerRemove(vendorId, categoryId)

Delete a menu category (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final String categoryId = categoryId_example; // String | 

try {
    api.menuCategoriesControllerRemove(vendorId, categoryId);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **categoryId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCategoriesControllerReorder**
> menuCategoriesControllerReorder(vendorId, reorderCategoriesDto)

Reorder menu categories

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final ReorderCategoriesDto reorderCategoriesDto = ; // ReorderCategoriesDto | 

try {
    api.menuCategoriesControllerReorder(vendorId, reorderCategoriesDto);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerReorder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **reorderCategoriesDto** | [**ReorderCategoriesDto**](ReorderCategoriesDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **menuCategoriesControllerUpdate**
> menuCategoriesControllerUpdate(vendorId, categoryId, updateMenuCategoryDto)

Update a menu category (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMenuCategoriesApi();
final String vendorId = vendorId_example; // String | 
final String categoryId = categoryId_example; // String | 
final UpdateMenuCategoryDto updateMenuCategoryDto = ; // UpdateMenuCategoryDto | 

try {
    api.menuCategoriesControllerUpdate(vendorId, categoryId, updateMenuCategoryDto);
} on DioException catch (e) {
    print('Exception when calling VendorsMenuCategoriesApi->menuCategoriesControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **categoryId** | **String**|  | 
 **updateMenuCategoryDto** | [**UpdateMenuCategoryDto**](UpdateMenuCategoryDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


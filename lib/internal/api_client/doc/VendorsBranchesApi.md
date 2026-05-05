# otlob_api.api.VendorsBranchesApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**vendorBranchesControllerAdminCreate**](VendorsBranchesApi.md#vendorbranchescontrolleradmincreate) | **POST** /vendors/{vendorId}/branches/admin | Create a new branch (Admin Override)
[**vendorBranchesControllerAdminRemove**](VendorsBranchesApi.md#vendorbranchescontrolleradminremove) | **DELETE** /vendors/{vendorId}/branches/admin/{branchId} | Delete a branch (Admin Override)
[**vendorBranchesControllerAdminUpdate**](VendorsBranchesApi.md#vendorbranchescontrolleradminupdate) | **PATCH** /vendors/{vendorId}/branches/admin/{branchId} | Update a branch (Admin Override)
[**vendorBranchesControllerCreate**](VendorsBranchesApi.md#vendorbranchescontrollercreate) | **POST** /vendors/{vendorId}/branches | Create a new branch (Member)
[**vendorBranchesControllerFindAll**](VendorsBranchesApi.md#vendorbranchescontrollerfindall) | **GET** /vendors/{vendorId}/branches | List all branches for a vendor
[**vendorBranchesControllerFindOne**](VendorsBranchesApi.md#vendorbranchescontrollerfindone) | **GET** /vendors/{vendorId}/branches/{branchId} | Get a specific branch by ID
[**vendorBranchesControllerRemove**](VendorsBranchesApi.md#vendorbranchescontrollerremove) | **DELETE** /vendors/{vendorId}/branches/{branchId} | Delete a branch (Member)
[**vendorBranchesControllerUpdate**](VendorsBranchesApi.md#vendorbranchescontrollerupdate) | **PATCH** /vendors/{vendorId}/branches/{branchId} | Update a branch (Member)


# **vendorBranchesControllerAdminCreate**
> vendorBranchesControllerAdminCreate(vendorId, createVendorBranchDto)

Create a new branch (Admin Override)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsBranchesApi();
final String vendorId = vendorId_example; // String | 
final CreateVendorBranchDto createVendorBranchDto = ; // CreateVendorBranchDto | 

try {
    api.vendorBranchesControllerAdminCreate(vendorId, createVendorBranchDto);
} on DioException catch (e) {
    print('Exception when calling VendorsBranchesApi->vendorBranchesControllerAdminCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **createVendorBranchDto** | [**CreateVendorBranchDto**](CreateVendorBranchDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorBranchesControllerAdminRemove**
> vendorBranchesControllerAdminRemove(vendorId, branchId)

Delete a branch (Admin Override)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsBranchesApi();
final String vendorId = vendorId_example; // String | 
final String branchId = branchId_example; // String | 

try {
    api.vendorBranchesControllerAdminRemove(vendorId, branchId);
} on DioException catch (e) {
    print('Exception when calling VendorsBranchesApi->vendorBranchesControllerAdminRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **branchId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorBranchesControllerAdminUpdate**
> vendorBranchesControllerAdminUpdate(vendorId, branchId, updateVendorBranchDto)

Update a branch (Admin Override)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsBranchesApi();
final String vendorId = vendorId_example; // String | 
final String branchId = branchId_example; // String | 
final UpdateVendorBranchDto updateVendorBranchDto = ; // UpdateVendorBranchDto | 

try {
    api.vendorBranchesControllerAdminUpdate(vendorId, branchId, updateVendorBranchDto);
} on DioException catch (e) {
    print('Exception when calling VendorsBranchesApi->vendorBranchesControllerAdminUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **branchId** | **String**|  | 
 **updateVendorBranchDto** | [**UpdateVendorBranchDto**](UpdateVendorBranchDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorBranchesControllerCreate**
> vendorBranchesControllerCreate(vendorId, createVendorBranchDto)

Create a new branch (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsBranchesApi();
final String vendorId = vendorId_example; // String | 
final CreateVendorBranchDto createVendorBranchDto = ; // CreateVendorBranchDto | 

try {
    api.vendorBranchesControllerCreate(vendorId, createVendorBranchDto);
} on DioException catch (e) {
    print('Exception when calling VendorsBranchesApi->vendorBranchesControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **createVendorBranchDto** | [**CreateVendorBranchDto**](CreateVendorBranchDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorBranchesControllerFindAll**
> vendorBranchesControllerFindAll(vendorId)

List all branches for a vendor

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsBranchesApi();
final String vendorId = vendorId_example; // String | 

try {
    api.vendorBranchesControllerFindAll(vendorId);
} on DioException catch (e) {
    print('Exception when calling VendorsBranchesApi->vendorBranchesControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorBranchesControllerFindOne**
> vendorBranchesControllerFindOne(vendorId, branchId)

Get a specific branch by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsBranchesApi();
final String vendorId = vendorId_example; // String | 
final String branchId = branchId_example; // String | 

try {
    api.vendorBranchesControllerFindOne(vendorId, branchId);
} on DioException catch (e) {
    print('Exception when calling VendorsBranchesApi->vendorBranchesControllerFindOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **branchId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorBranchesControllerRemove**
> vendorBranchesControllerRemove(vendorId, branchId)

Delete a branch (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsBranchesApi();
final String vendorId = vendorId_example; // String | 
final String branchId = branchId_example; // String | 

try {
    api.vendorBranchesControllerRemove(vendorId, branchId);
} on DioException catch (e) {
    print('Exception when calling VendorsBranchesApi->vendorBranchesControllerRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **branchId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorBranchesControllerUpdate**
> vendorBranchesControllerUpdate(vendorId, branchId, updateVendorBranchDto)

Update a branch (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsBranchesApi();
final String vendorId = vendorId_example; // String | 
final String branchId = branchId_example; // String | 
final UpdateVendorBranchDto updateVendorBranchDto = ; // UpdateVendorBranchDto | 

try {
    api.vendorBranchesControllerUpdate(vendorId, branchId, updateVendorBranchDto);
} on DioException catch (e) {
    print('Exception when calling VendorsBranchesApi->vendorBranchesControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **branchId** | **String**|  | 
 **updateVendorBranchDto** | [**UpdateVendorBranchDto**](UpdateVendorBranchDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


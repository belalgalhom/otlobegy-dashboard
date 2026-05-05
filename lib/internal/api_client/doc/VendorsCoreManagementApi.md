# otlob_api.api.VendorsCoreManagementApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**vendorsControllerCreate**](VendorsCoreManagementApi.md#vendorscontrollercreate) | **POST** /vendors | Create a new vendor (Admin)
[**vendorsControllerFindAll**](VendorsCoreManagementApi.md#vendorscontrollerfindall) | **GET** /vendors | List all vendors with filters
[**vendorsControllerFindBySlug**](VendorsCoreManagementApi.md#vendorscontrollerfindbyslug) | **GET** /vendors/by-slug/{slug} | Find a vendor by its slug
[**vendorsControllerFindOne**](VendorsCoreManagementApi.md#vendorscontrollerfindone) | **GET** /vendors/{vendorId} | Get a specific vendor by ID
[**vendorsControllerGetMyVendor**](VendorsCoreManagementApi.md#vendorscontrollergetmyvendor) | **GET** /vendors/{vendorId}/me | Get my vendor profile (Member)
[**vendorsControllerRemove**](VendorsCoreManagementApi.md#vendorscontrollerremove) | **DELETE** /vendors/{vendorId} | Delete a vendor (Admin)
[**vendorsControllerUpdate**](VendorsCoreManagementApi.md#vendorscontrollerupdate) | **PATCH** /vendors/{vendorId} | Update vendor information (Admin)
[**vendorsControllerUpdateStatus**](VendorsCoreManagementApi.md#vendorscontrollerupdatestatus) | **PATCH** /vendors/{vendorId}/status | Update vendor status (Admin)
[**vendorsControllerUploadCover**](VendorsCoreManagementApi.md#vendorscontrolleruploadcover) | **POST** /vendors/{vendorId}/cover | Upload vendor cover image
[**vendorsControllerUploadLogo**](VendorsCoreManagementApi.md#vendorscontrolleruploadlogo) | **POST** /vendors/{vendorId}/logo | Upload vendor logo image


# **vendorsControllerCreate**
> vendorsControllerCreate(createVendorDto)

Create a new vendor (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final CreateVendorDto createVendorDto = ; // CreateVendorDto | 

try {
    api.vendorsControllerCreate(createVendorDto);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createVendorDto** | [**CreateVendorDto**](CreateVendorDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorsControllerFindAll**
> vendorsControllerFindAll(status, verticalId, search, page, limit)

List all vendors with filters

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String status = status_example; // String | 
final String verticalId = vertical-id-123; // String | 
final String search = pizza; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.vendorsControllerFindAll(status, verticalId, search, page, limit);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 
 **verticalId** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 
 **page** | **num**|  | [optional] [default to 1]
 **limit** | **num**|  | [optional] [default to 20]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorsControllerFindBySlug**
> vendorsControllerFindBySlug(slug)

Find a vendor by its slug

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String slug = slug_example; // String | 

try {
    api.vendorsControllerFindBySlug(slug);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerFindBySlug: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorsControllerFindOne**
> vendorsControllerFindOne(vendorId)

Get a specific vendor by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String vendorId = vendorId_example; // String | 

try {
    api.vendorsControllerFindOne(vendorId);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerFindOne: $e\n');
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

# **vendorsControllerGetMyVendor**
> vendorsControllerGetMyVendor(vendorId)

Get my vendor profile (Member)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String vendorId = vendorId_example; // String | 

try {
    api.vendorsControllerGetMyVendor(vendorId);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerGetMyVendor: $e\n');
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

# **vendorsControllerRemove**
> vendorsControllerRemove(vendorId)

Delete a vendor (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String vendorId = vendorId_example; // String | 

try {
    api.vendorsControllerRemove(vendorId);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerRemove: $e\n');
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

# **vendorsControllerUpdate**
> vendorsControllerUpdate(vendorId, updateVendorDto)

Update vendor information (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String vendorId = vendorId_example; // String | 
final UpdateVendorDto updateVendorDto = ; // UpdateVendorDto | 

try {
    api.vendorsControllerUpdate(vendorId, updateVendorDto);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **updateVendorDto** | [**UpdateVendorDto**](UpdateVendorDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorsControllerUpdateStatus**
> vendorsControllerUpdateStatus(vendorId, updateVendorStatusDto)

Update vendor status (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String vendorId = vendorId_example; // String | 
final UpdateVendorStatusDto updateVendorStatusDto = ; // UpdateVendorStatusDto | 

try {
    api.vendorsControllerUpdateStatus(vendorId, updateVendorStatusDto);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerUpdateStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **updateVendorStatusDto** | [**UpdateVendorStatusDto**](UpdateVendorStatusDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorsControllerUploadCover**
> vendorsControllerUploadCover(vendorId, file)

Upload vendor cover image

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String vendorId = vendorId_example; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.vendorsControllerUploadCover(vendorId, file);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerUploadCover: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **file** | **MultipartFile**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorsControllerUploadLogo**
> vendorsControllerUploadLogo(vendorId, file)

Upload vendor logo image

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsCoreManagementApi();
final String vendorId = vendorId_example; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.vendorsControllerUploadLogo(vendorId, file);
} on DioException catch (e) {
    print('Exception when calling VendorsCoreManagementApi->vendorsControllerUploadLogo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **file** | **MultipartFile**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


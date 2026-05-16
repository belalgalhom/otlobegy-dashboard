# otlob_api.api.PlatformSettingsVersioningApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**platformSettingsControllerCheckVersion**](PlatformSettingsVersioningApi.md#platformsettingscontrollercheckversion) | **POST** /platform-settings/app-version-check | Check if app version is supported
[**platformSettingsControllerGetAll**](PlatformSettingsVersioningApi.md#platformsettingscontrollergetall) | **GET** /platform-settings | Get all platform settings (Admin)
[**platformSettingsControllerGetPublic**](PlatformSettingsVersioningApi.md#platformsettingscontrollergetpublic) | **GET** /platform-settings/public | Get public platform settings (maintenance mode, versions)
[**platformSettingsControllerUpdate**](PlatformSettingsVersioningApi.md#platformsettingscontrollerupdate) | **PATCH** /platform-settings | Update platform settings (Admin)
[**platformSettingsControllerUploadCarIcon**](PlatformSettingsVersioningApi.md#platformsettingscontrolleruploadcaricon) | **POST** /platform-settings/car-icon | Upload car icon
[**platformSettingsControllerUploadDeliveryBannerIcon**](PlatformSettingsVersioningApi.md#platformsettingscontrolleruploaddeliverybannericon) | **POST** /platform-settings/delivery-banner-icon | Upload delivery banner icon
[**platformSettingsControllerUploadHomeCover**](PlatformSettingsVersioningApi.md#platformsettingscontrolleruploadhomecover) | **POST** /platform-settings/home-cover | Upload home cover image
[**platformSettingsControllerUploadMotorcycleIcon**](PlatformSettingsVersioningApi.md#platformsettingscontrolleruploadmotorcycleicon) | **POST** /platform-settings/motorcycle-icon | Upload motorcycle icon


# **platformSettingsControllerCheckVersion**
> platformSettingsControllerCheckVersion(appVersionCheckDto)

Check if app version is supported

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPlatformSettingsVersioningApi();
final AppVersionCheckDto appVersionCheckDto = ; // AppVersionCheckDto | 

try {
    api.platformSettingsControllerCheckVersion(appVersionCheckDto);
} on DioException catch (e) {
    print('Exception when calling PlatformSettingsVersioningApi->platformSettingsControllerCheckVersion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appVersionCheckDto** | [**AppVersionCheckDto**](AppVersionCheckDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **platformSettingsControllerGetAll**
> platformSettingsControllerGetAll()

Get all platform settings (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPlatformSettingsVersioningApi();

try {
    api.platformSettingsControllerGetAll();
} on DioException catch (e) {
    print('Exception when calling PlatformSettingsVersioningApi->platformSettingsControllerGetAll: $e\n');
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

# **platformSettingsControllerGetPublic**
> platformSettingsControllerGetPublic()

Get public platform settings (maintenance mode, versions)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPlatformSettingsVersioningApi();

try {
    api.platformSettingsControllerGetPublic();
} on DioException catch (e) {
    print('Exception when calling PlatformSettingsVersioningApi->platformSettingsControllerGetPublic: $e\n');
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

# **platformSettingsControllerUpdate**
> platformSettingsControllerUpdate(updatePlatformSettingsDto)

Update platform settings (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPlatformSettingsVersioningApi();
final UpdatePlatformSettingsDto updatePlatformSettingsDto = ; // UpdatePlatformSettingsDto | 

try {
    api.platformSettingsControllerUpdate(updatePlatformSettingsDto);
} on DioException catch (e) {
    print('Exception when calling PlatformSettingsVersioningApi->platformSettingsControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updatePlatformSettingsDto** | [**UpdatePlatformSettingsDto**](UpdatePlatformSettingsDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **platformSettingsControllerUploadCarIcon**
> platformSettingsControllerUploadCarIcon(file)

Upload car icon

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPlatformSettingsVersioningApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.platformSettingsControllerUploadCarIcon(file);
} on DioException catch (e) {
    print('Exception when calling PlatformSettingsVersioningApi->platformSettingsControllerUploadCarIcon: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **platformSettingsControllerUploadDeliveryBannerIcon**
> platformSettingsControllerUploadDeliveryBannerIcon(file)

Upload delivery banner icon

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPlatformSettingsVersioningApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.platformSettingsControllerUploadDeliveryBannerIcon(file);
} on DioException catch (e) {
    print('Exception when calling PlatformSettingsVersioningApi->platformSettingsControllerUploadDeliveryBannerIcon: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **platformSettingsControllerUploadHomeCover**
> platformSettingsControllerUploadHomeCover(file)

Upload home cover image

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPlatformSettingsVersioningApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.platformSettingsControllerUploadHomeCover(file);
} on DioException catch (e) {
    print('Exception when calling PlatformSettingsVersioningApi->platformSettingsControllerUploadHomeCover: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **platformSettingsControllerUploadMotorcycleIcon**
> platformSettingsControllerUploadMotorcycleIcon(file)

Upload motorcycle icon

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPlatformSettingsVersioningApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.platformSettingsControllerUploadMotorcycleIcon(file);
} on DioException catch (e) {
    print('Exception when calling PlatformSettingsVersioningApi->platformSettingsControllerUploadMotorcycleIcon: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


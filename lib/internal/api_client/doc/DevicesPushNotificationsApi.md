# otlob_api.api.DevicesPushNotificationsApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**devicesControllerRegister**](DevicesPushNotificationsApi.md#devicescontrollerregister) | **POST** /devices | Register a device for push notifications
[**devicesControllerRemove**](DevicesPushNotificationsApi.md#devicescontrollerremove) | **DELETE** /devices/{token} | Remove a device token


# **devicesControllerRegister**
> devicesControllerRegister(registerDeviceDto)

Register a device for push notifications

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDevicesPushNotificationsApi();
final RegisterDeviceDto registerDeviceDto = ; // RegisterDeviceDto | 

try {
    api.devicesControllerRegister(registerDeviceDto);
} on DioException catch (e) {
    print('Exception when calling DevicesPushNotificationsApi->devicesControllerRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerDeviceDto** | [**RegisterDeviceDto**](RegisterDeviceDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **devicesControllerRemove**
> devicesControllerRemove(token)

Remove a device token

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDevicesPushNotificationsApi();
final String token = token_example; // String | 

try {
    api.devicesControllerRemove(token);
} on DioException catch (e) {
    print('Exception when calling DevicesPushNotificationsApi->devicesControllerRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


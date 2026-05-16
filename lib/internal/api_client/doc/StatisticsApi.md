# otlob_api.api.StatisticsApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**statisticsControllerGetAppStats**](StatisticsApi.md#statisticscontrollergetappstats) | **GET** /statistics/app | [Admin] Get platform-wide statistics
[**statisticsControllerGetDriverStats**](StatisticsApi.md#statisticscontrollergetdriverstats) | **GET** /statistics/drivers/{driverId} | [Admin] Get statistics for a specific driver
[**statisticsControllerGetMyDriverStats**](StatisticsApi.md#statisticscontrollergetmydriverstats) | **GET** /statistics/driver/me | Get my driver statistics
[**statisticsControllerGetVendorStats**](StatisticsApi.md#statisticscontrollergetvendorstats) | **GET** /statistics/vendors/{vendorId} | Get vendor statistics (member or admin)


# **statisticsControllerGetAppStats**
> statisticsControllerGetAppStats()

[Admin] Get platform-wide statistics

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getStatisticsApi();

try {
    api.statisticsControllerGetAppStats();
} on DioException catch (e) {
    print('Exception when calling StatisticsApi->statisticsControllerGetAppStats: $e\n');
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

# **statisticsControllerGetDriverStats**
> statisticsControllerGetDriverStats(driverId)

[Admin] Get statistics for a specific driver

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getStatisticsApi();
final String driverId = driverId_example; // String | 

try {
    api.statisticsControllerGetDriverStats(driverId);
} on DioException catch (e) {
    print('Exception when calling StatisticsApi->statisticsControllerGetDriverStats: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **statisticsControllerGetMyDriverStats**
> statisticsControllerGetMyDriverStats()

Get my driver statistics

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getStatisticsApi();

try {
    api.statisticsControllerGetMyDriverStats();
} on DioException catch (e) {
    print('Exception when calling StatisticsApi->statisticsControllerGetMyDriverStats: $e\n');
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

# **statisticsControllerGetVendorStats**
> statisticsControllerGetVendorStats(vendorId, period)

Get vendor statistics (member or admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getStatisticsApi();
final String vendorId = vendorId_example; // String | 
final String period = period_example; // String | 

try {
    api.statisticsControllerGetVendorStats(vendorId, period);
} on DioException catch (e) {
    print('Exception when calling StatisticsApi->statisticsControllerGetVendorStats: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **period** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


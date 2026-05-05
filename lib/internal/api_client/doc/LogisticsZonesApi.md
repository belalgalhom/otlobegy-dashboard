# otlob_api.api.LogisticsZonesApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**zonesControllerCheckLocation**](LogisticsZonesApi.md#zonescontrollerchecklocation) | **POST** /zones/check-location | Find zone by coordinates
[**zonesControllerCreate**](LogisticsZonesApi.md#zonescontrollercreate) | **POST** /zones | Create a new delivery zone
[**zonesControllerFindAll**](LogisticsZonesApi.md#zonescontrollerfindall) | **GET** /zones | List all delivery zones
[**zonesControllerFindOne**](LogisticsZonesApi.md#zonescontrollerfindone) | **GET** /zones/{id} | Get a specific zone by ID
[**zonesControllerRemove**](LogisticsZonesApi.md#zonescontrollerremove) | **DELETE** /zones/{id} | Delete a delivery zone
[**zonesControllerUpdate**](LogisticsZonesApi.md#zonescontrollerupdate) | **PATCH** /zones/{id} | Update a delivery zone


# **zonesControllerCheckLocation**
> zonesControllerCheckLocation(checkLocationDto)

Find zone by coordinates

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getLogisticsZonesApi();
final CheckLocationDto checkLocationDto = ; // CheckLocationDto | 

try {
    api.zonesControllerCheckLocation(checkLocationDto);
} on DioException catch (e) {
    print('Exception when calling LogisticsZonesApi->zonesControllerCheckLocation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **checkLocationDto** | [**CheckLocationDto**](CheckLocationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **zonesControllerCreate**
> zonesControllerCreate(createZoneDto)

Create a new delivery zone

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getLogisticsZonesApi();
final CreateZoneDto createZoneDto = ; // CreateZoneDto | 

try {
    api.zonesControllerCreate(createZoneDto);
} on DioException catch (e) {
    print('Exception when calling LogisticsZonesApi->zonesControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createZoneDto** | [**CreateZoneDto**](CreateZoneDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **zonesControllerFindAll**
> zonesControllerFindAll()

List all delivery zones

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getLogisticsZonesApi();

try {
    api.zonesControllerFindAll();
} on DioException catch (e) {
    print('Exception when calling LogisticsZonesApi->zonesControllerFindAll: $e\n');
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

# **zonesControllerFindOne**
> zonesControllerFindOne(id)

Get a specific zone by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getLogisticsZonesApi();
final String id = id_example; // String | 

try {
    api.zonesControllerFindOne(id);
} on DioException catch (e) {
    print('Exception when calling LogisticsZonesApi->zonesControllerFindOne: $e\n');
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

# **zonesControllerRemove**
> zonesControllerRemove(id)

Delete a delivery zone

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getLogisticsZonesApi();
final String id = id_example; // String | 

try {
    api.zonesControllerRemove(id);
} on DioException catch (e) {
    print('Exception when calling LogisticsZonesApi->zonesControllerRemove: $e\n');
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

# **zonesControllerUpdate**
> zonesControllerUpdate(id, updateZoneDto)

Update a delivery zone

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getLogisticsZonesApi();
final String id = id_example; // String | 
final UpdateZoneDto updateZoneDto = ; // UpdateZoneDto | 

try {
    api.zonesControllerUpdate(id, updateZoneDto);
} on DioException catch (e) {
    print('Exception when calling LogisticsZonesApi->zonesControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateZoneDto** | [**UpdateZoneDto**](UpdateZoneDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


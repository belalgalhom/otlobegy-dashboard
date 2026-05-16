# otlob_api.api.DriversApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**driversControllerAdminFindAll**](DriversApi.md#driverscontrolleradminfindall) | **GET** /drivers | [Admin] List all drivers
[**driversControllerAdminFindOne**](DriversApi.md#driverscontrolleradminfindone) | **GET** /drivers/{driverId} | [Admin] Get a driver by ID
[**driversControllerAdminSuspend**](DriversApi.md#driverscontrolleradminsuspend) | **POST** /drivers/{driverId}/suspend | [Admin] Suspend a driver
[**driversControllerAdminUnsuspend**](DriversApi.md#driverscontrolleradminunsuspend) | **POST** /drivers/{driverId}/unsuspend | [Admin] Unsuspend a driver
[**driversControllerCreateShift**](DriversApi.md#driverscontrollercreateshift) | **POST** /drivers/me/shifts | Create a shift
[**driversControllerEndShift**](DriversApi.md#driverscontrollerendshift) | **POST** /drivers/me/shifts/{shiftId}/end | End a shift
[**driversControllerGetMyProfile**](DriversApi.md#driverscontrollergetmyprofile) | **GET** /drivers/me | Get my driver profile
[**driversControllerGetMyShifts**](DriversApi.md#driverscontrollergetmyshifts) | **GET** /drivers/me/shifts | Get my shifts
[**driversControllerGetWalletBalance**](DriversApi.md#driverscontrollergetwalletbalance) | **GET** /drivers/me/wallet | Get wallet balance
[**driversControllerGetWalletTransactions**](DriversApi.md#driverscontrollergetwallettransactions) | **GET** /drivers/me/wallet/transactions | Get wallet transaction history
[**driversControllerRegister**](DriversApi.md#driverscontrollerregister) | **POST** /drivers/register | Register as a driver (creates driver profile, upgrades role)
[**driversControllerStartShift**](DriversApi.md#driverscontrollerstartshift) | **POST** /drivers/me/shifts/{shiftId}/start | Start a shift
[**driversControllerUpdateLocation**](DriversApi.md#driverscontrollerupdatelocation) | **PATCH** /drivers/me/location | Update driver GPS location (call frequently ~5s)
[**driversControllerUpdateProfile**](DriversApi.md#driverscontrollerupdateprofile) | **PATCH** /drivers/me | Update my driver profile
[**driversControllerUpdateStatus**](DriversApi.md#driverscontrollerupdatestatus) | **PATCH** /drivers/me/status | Update driver status (ONLINE / OFFLINE / ON_BREAK)
[**driversControllerUploadAvatar**](DriversApi.md#driverscontrolleruploadavatar) | **POST** /drivers/me/avatar | Upload driver avatar


# **driversControllerAdminFindAll**
> driversControllerAdminFindAll(status, search, page, limit)

[Admin] List all drivers

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final String status = status_example; // String | 
final String search = ahmed; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.driversControllerAdminFindAll(status, search, page, limit);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerAdminFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 
 **search** | **String**|  | [optional] 
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

# **driversControllerAdminFindOne**
> driversControllerAdminFindOne(driverId)

[Admin] Get a driver by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final String driverId = driverId_example; // String | 

try {
    api.driversControllerAdminFindOne(driverId);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerAdminFindOne: $e\n');
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

# **driversControllerAdminSuspend**
> driversControllerAdminSuspend(driverId)

[Admin] Suspend a driver

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final String driverId = driverId_example; // String | 

try {
    api.driversControllerAdminSuspend(driverId);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerAdminSuspend: $e\n');
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

# **driversControllerAdminUnsuspend**
> driversControllerAdminUnsuspend(driverId)

[Admin] Unsuspend a driver

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final String driverId = driverId_example; // String | 

try {
    api.driversControllerAdminUnsuspend(driverId);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerAdminUnsuspend: $e\n');
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

# **driversControllerCreateShift**
> driversControllerCreateShift(createDriverShiftDto)

Create a shift

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final CreateDriverShiftDto createDriverShiftDto = ; // CreateDriverShiftDto | 

try {
    api.driversControllerCreateShift(createDriverShiftDto);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerCreateShift: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createDriverShiftDto** | [**CreateDriverShiftDto**](CreateDriverShiftDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerEndShift**
> driversControllerEndShift(shiftId)

End a shift

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final String shiftId = shiftId_example; // String | 

try {
    api.driversControllerEndShift(shiftId);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerEndShift: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shiftId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerGetMyProfile**
> driversControllerGetMyProfile()

Get my driver profile

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();

try {
    api.driversControllerGetMyProfile();
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerGetMyProfile: $e\n');
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

# **driversControllerGetMyShifts**
> driversControllerGetMyShifts()

Get my shifts

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();

try {
    api.driversControllerGetMyShifts();
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerGetMyShifts: $e\n');
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

# **driversControllerGetWalletBalance**
> driversControllerGetWalletBalance()

Get wallet balance

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();

try {
    api.driversControllerGetWalletBalance();
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerGetWalletBalance: $e\n');
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

# **driversControllerGetWalletTransactions**
> driversControllerGetWalletTransactions(page, limit)

Get wallet transaction history

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.driversControllerGetWalletTransactions(page, limit);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerGetWalletTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **driversControllerRegister**
> driversControllerRegister(registerDriverDto)

Register as a driver (creates driver profile, upgrades role)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final RegisterDriverDto registerDriverDto = ; // RegisterDriverDto | 

try {
    api.driversControllerRegister(registerDriverDto);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerDriverDto** | [**RegisterDriverDto**](RegisterDriverDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerStartShift**
> driversControllerStartShift(shiftId)

Start a shift

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final String shiftId = shiftId_example; // String | 

try {
    api.driversControllerStartShift(shiftId);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerStartShift: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **shiftId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerUpdateLocation**
> driversControllerUpdateLocation(updateDriverLocationDto)

Update driver GPS location (call frequently ~5s)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final UpdateDriverLocationDto updateDriverLocationDto = ; // UpdateDriverLocationDto | 

try {
    api.driversControllerUpdateLocation(updateDriverLocationDto);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerUpdateLocation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateDriverLocationDto** | [**UpdateDriverLocationDto**](UpdateDriverLocationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerUpdateProfile**
> driversControllerUpdateProfile(updateDriverProfileDto)

Update my driver profile

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final UpdateDriverProfileDto updateDriverProfileDto = ; // UpdateDriverProfileDto | 

try {
    api.driversControllerUpdateProfile(updateDriverProfileDto);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerUpdateProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateDriverProfileDto** | [**UpdateDriverProfileDto**](UpdateDriverProfileDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerUpdateStatus**
> driversControllerUpdateStatus(updateDriverStatusDto)

Update driver status (ONLINE / OFFLINE / ON_BREAK)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final UpdateDriverStatusDto updateDriverStatusDto = ; // UpdateDriverStatusDto | 

try {
    api.driversControllerUpdateStatus(updateDriverStatusDto);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerUpdateStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateDriverStatusDto** | [**UpdateDriverStatusDto**](UpdateDriverStatusDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driversControllerUploadAvatar**
> driversControllerUploadAvatar(file)

Upload driver avatar

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getDriversApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.driversControllerUploadAvatar(file);
} on DioException catch (e) {
    print('Exception when calling DriversApi->driversControllerUploadAvatar: $e\n');
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


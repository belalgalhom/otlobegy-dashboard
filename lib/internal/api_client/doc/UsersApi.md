# otlob_api.api.UsersApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**usersControllerAdminBan**](UsersApi.md#userscontrolleradminban) | **POST** /users/{userId}/ban | [Admin] Ban a user — immediately revokes all sessions. Cannot ban SUPER_ADMIN.
[**usersControllerAdminFindAll**](UsersApi.md#userscontrolleradminfindall) | **GET** /users | [Admin] List all users — filter by role, isBanned, includeDeleted, search
[**usersControllerAdminFindOne**](UsersApi.md#userscontrolleradminfindone) | **GET** /users/{userId} | [Admin] Get a user — includes sessions, devices, vendor memberships, customer/driver snapshots
[**usersControllerAdminGetSessions**](UsersApi.md#userscontrolleradmingetsessions) | **GET** /users/{userId}/sessions | [Admin] List active sessions for a user
[**usersControllerAdminRemove**](UsersApi.md#userscontrolleradminremove) | **DELETE** /users/{userId} | [Admin] Soft-delete a user — wipes email/phone PII. Cannot delete SUPER_ADMIN.
[**usersControllerAdminRevokeAllSessions**](UsersApi.md#userscontrolleradminrevokeallsessions) | **DELETE** /users/{userId}/sessions | [Admin] Revoke all sessions for a user (force logout)
[**usersControllerAdminUnban**](UsersApi.md#userscontrolleradminunban) | **POST** /users/{userId}/unban | [Admin] Unban a user
[**usersControllerAdminUpdate**](UsersApi.md#userscontrolleradminupdate) | **PATCH** /users/{userId} | [Admin] Update a user — name, email, phone, role, title, permissions, verification flags
[**usersControllerChangePassword**](UsersApi.md#userscontrollerchangepassword) | **POST** /users/me/change-password | Change my password
[**usersControllerDeleteAccount**](UsersApi.md#userscontrollerdeleteaccount) | **DELETE** /users/me | Delete my account
[**usersControllerGetNotificationSettings**](UsersApi.md#userscontrollergetnotificationsettings) | **GET** /users/me/notification-settings | Get my notification settings
[**usersControllerGetUser**](UsersApi.md#userscontrollergetuser) | **GET** /users/me | Get my profile
[**usersControllerUpdateNotificationSettings**](UsersApi.md#userscontrollerupdatenotificationsettings) | **PATCH** /users/me/notification-settings | Update my notification settings
[**usersControllerUpdateUser**](UsersApi.md#userscontrollerupdateuser) | **PATCH** /users/me | Update my profile (name, email, phone, language)
[**usersControllerUploadAvatar**](UsersApi.md#userscontrolleruploadavatar) | **POST** /users/me/avatar | Upload my avatar


# **usersControllerAdminBan**
> usersControllerAdminBan(userId, banUserDto)

[Admin] Ban a user — immediately revokes all sessions. Cannot ban SUPER_ADMIN.

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final String userId = userId_example; // String | 
final BanUserDto banUserDto = ; // BanUserDto | 

try {
    api.usersControllerAdminBan(userId, banUserDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerAdminBan: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **banUserDto** | [**BanUserDto**](BanUserDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerAdminFindAll**
> usersControllerAdminFindAll(role, isBanned, includeDeleted, search, page, limit)

[Admin] List all users — filter by role, isBanned, includeDeleted, search

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final String role = role_example; // String | 
final bool isBanned = false; // bool | 
final bool includeDeleted = false; // bool | Include soft-deleted accounts
final String search = john; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.usersControllerAdminFindAll(role, isBanned, includeDeleted, search, page, limit);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerAdminFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | **String**|  | [optional] 
 **isBanned** | **bool**|  | [optional] 
 **includeDeleted** | **bool**| Include soft-deleted accounts | [optional] 
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

# **usersControllerAdminFindOne**
> usersControllerAdminFindOne(userId)

[Admin] Get a user — includes sessions, devices, vendor memberships, customer/driver snapshots

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final String userId = userId_example; // String | 

try {
    api.usersControllerAdminFindOne(userId);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerAdminFindOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerAdminGetSessions**
> usersControllerAdminGetSessions(userId)

[Admin] List active sessions for a user

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final String userId = userId_example; // String | 

try {
    api.usersControllerAdminGetSessions(userId);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerAdminGetSessions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerAdminRemove**
> usersControllerAdminRemove(userId)

[Admin] Soft-delete a user — wipes email/phone PII. Cannot delete SUPER_ADMIN.

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final String userId = userId_example; // String | 

try {
    api.usersControllerAdminRemove(userId);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerAdminRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerAdminRevokeAllSessions**
> usersControllerAdminRevokeAllSessions(userId)

[Admin] Revoke all sessions for a user (force logout)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final String userId = userId_example; // String | 

try {
    api.usersControllerAdminRevokeAllSessions(userId);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerAdminRevokeAllSessions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerAdminUnban**
> usersControllerAdminUnban(userId)

[Admin] Unban a user

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final String userId = userId_example; // String | 

try {
    api.usersControllerAdminUnban(userId);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerAdminUnban: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerAdminUpdate**
> usersControllerAdminUpdate(userId, adminUpdateUserDto)

[Admin] Update a user — name, email, phone, role, title, permissions, verification flags

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final String userId = userId_example; // String | 
final AdminUpdateUserDto adminUpdateUserDto = ; // AdminUpdateUserDto | 

try {
    api.usersControllerAdminUpdate(userId, adminUpdateUserDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerAdminUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **adminUpdateUserDto** | [**AdminUpdateUserDto**](AdminUpdateUserDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerChangePassword**
> usersControllerChangePassword(changePasswordDto)

Change my password

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final ChangePasswordDto changePasswordDto = ; // ChangePasswordDto | 

try {
    api.usersControllerChangePassword(changePasswordDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerChangePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordDto** | [**ChangePasswordDto**](ChangePasswordDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerDeleteAccount**
> usersControllerDeleteAccount()

Delete my account

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();

try {
    api.usersControllerDeleteAccount();
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerDeleteAccount: $e\n');
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

# **usersControllerGetNotificationSettings**
> usersControllerGetNotificationSettings()

Get my notification settings

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();

try {
    api.usersControllerGetNotificationSettings();
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerGetNotificationSettings: $e\n');
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

# **usersControllerGetUser**
> usersControllerGetUser()

Get my profile

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();

try {
    api.usersControllerGetUser();
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerGetUser: $e\n');
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

# **usersControllerUpdateNotificationSettings**
> usersControllerUpdateNotificationSettings(updateNotificationSettingsDto)

Update my notification settings

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final UpdateNotificationSettingsDto updateNotificationSettingsDto = ; // UpdateNotificationSettingsDto | 

try {
    api.usersControllerUpdateNotificationSettings(updateNotificationSettingsDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerUpdateNotificationSettings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateNotificationSettingsDto** | [**UpdateNotificationSettingsDto**](UpdateNotificationSettingsDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerUpdateUser**
> usersControllerUpdateUser(updateUserDto)

Update my profile (name, email, phone, language)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final UpdateUserDto updateUserDto = ; // UpdateUserDto | 

try {
    api.usersControllerUpdateUser(updateUserDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerUpdateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserDto** | [**UpdateUserDto**](UpdateUserDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerUploadAvatar**
> usersControllerUploadAvatar(file)

Upload my avatar

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getUsersApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.usersControllerUploadAvatar(file);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerUploadAvatar: $e\n');
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


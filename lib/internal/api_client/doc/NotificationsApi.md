# otlob_api.api.NotificationsApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**notificationsControllerDeleteAllRead**](NotificationsApi.md#notificationscontrollerdeleteallread) | **DELETE** /notifications/read | Delete all read notifications
[**notificationsControllerDeleteOne**](NotificationsApi.md#notificationscontrollerdeleteone) | **DELETE** /notifications/{id} | Delete a specific notification
[**notificationsControllerGetOne**](NotificationsApi.md#notificationscontrollergetone) | **GET** /notifications/{id} | Get a specific notification by ID
[**notificationsControllerList**](NotificationsApi.md#notificationscontrollerlist) | **GET** /notifications | List my notifications
[**notificationsControllerMarkOneRead**](NotificationsApi.md#notificationscontrollermarkoneread) | **PATCH** /notifications/{id}/read | Mark a specific notification as read
[**notificationsControllerMarkRead**](NotificationsApi.md#notificationscontrollermarkread) | **PATCH** /notifications/read | Mark multiple notifications as read
[**notificationsControllerUnreadCount**](NotificationsApi.md#notificationscontrollerunreadcount) | **GET** /notifications/unread-count | Get unread notifications count


# **notificationsControllerDeleteAllRead**
> notificationsControllerDeleteAllRead()

Delete all read notifications

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getNotificationsApi();

try {
    api.notificationsControllerDeleteAllRead();
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerDeleteAllRead: $e\n');
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

# **notificationsControllerDeleteOne**
> notificationsControllerDeleteOne(id)

Delete a specific notification

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getNotificationsApi();
final String id = id_example; // String | 

try {
    api.notificationsControllerDeleteOne(id);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerDeleteOne: $e\n');
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

# **notificationsControllerGetOne**
> notificationsControllerGetOne(id)

Get a specific notification by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getNotificationsApi();
final String id = id_example; // String | 

try {
    api.notificationsControllerGetOne(id);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerGetOne: $e\n');
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

# **notificationsControllerList**
> notificationsControllerList(unreadOnly, type, page, limit)

List my notifications

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getNotificationsApi();
final bool unreadOnly = true; // bool | 
final String type = type_example; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.notificationsControllerList(unreadOnly, type, page, limit);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **unreadOnly** | **bool**|  | [optional] 
 **type** | **String**|  | [optional] 
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

# **notificationsControllerMarkOneRead**
> notificationsControllerMarkOneRead(id)

Mark a specific notification as read

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getNotificationsApi();
final String id = id_example; // String | 

try {
    api.notificationsControllerMarkOneRead(id);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerMarkOneRead: $e\n');
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

# **notificationsControllerMarkRead**
> notificationsControllerMarkRead(markNotificationsReadDto)

Mark multiple notifications as read

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getNotificationsApi();
final MarkNotificationsReadDto markNotificationsReadDto = ; // MarkNotificationsReadDto | 

try {
    api.notificationsControllerMarkRead(markNotificationsReadDto);
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerMarkRead: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **markNotificationsReadDto** | [**MarkNotificationsReadDto**](MarkNotificationsReadDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationsControllerUnreadCount**
> notificationsControllerUnreadCount()

Get unread notifications count

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getNotificationsApi();

try {
    api.notificationsControllerUnreadCount();
} on DioException catch (e) {
    print('Exception when calling NotificationsApi->notificationsControllerUnreadCount: $e\n');
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


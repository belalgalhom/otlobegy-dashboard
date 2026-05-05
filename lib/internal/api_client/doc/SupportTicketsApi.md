# otlob_api.api.SupportTicketsApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ticketsControllerCreate**](SupportTicketsApi.md#ticketscontrollercreate) | **POST** /tickets | Create a new support ticket
[**ticketsControllerGetOne**](SupportTicketsApi.md#ticketscontrollergetone) | **GET** /tickets/{id} | Get a specific support ticket by ID
[**ticketsControllerList**](SupportTicketsApi.md#ticketscontrollerlist) | **GET** /tickets | List support tickets with filters
[**ticketsControllerRemove**](SupportTicketsApi.md#ticketscontrollerremove) | **DELETE** /tickets/{id} | Delete/Cancel a support ticket
[**ticketsControllerUpdate**](SupportTicketsApi.md#ticketscontrollerupdate) | **PATCH** /tickets/{id} | Update a support ticket


# **ticketsControllerCreate**
> ticketsControllerCreate(createTicketDto)

Create a new support ticket

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getSupportTicketsApi();
final CreateTicketDto createTicketDto = ; // CreateTicketDto | 

try {
    api.ticketsControllerCreate(createTicketDto);
} on DioException catch (e) {
    print('Exception when calling SupportTicketsApi->ticketsControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createTicketDto** | [**CreateTicketDto**](CreateTicketDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ticketsControllerGetOne**
> ticketsControllerGetOne(id)

Get a specific support ticket by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getSupportTicketsApi();
final String id = id_example; // String | 

try {
    api.ticketsControllerGetOne(id);
} on DioException catch (e) {
    print('Exception when calling SupportTicketsApi->ticketsControllerGetOne: $e\n');
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

# **ticketsControllerList**
> ticketsControllerList(status, priority, category, assigneeId, creatorId, page, limit)

List support tickets with filters

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getSupportTicketsApi();
final String status = status_example; // String | 
final String priority = priority_example; // String | 
final String category = category_example; // String | 
final String assigneeId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final String creatorId = 550e8400-e29b-41d4-a716-446655440000; // String | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.ticketsControllerList(status, priority, category, assigneeId, creatorId, page, limit);
} on DioException catch (e) {
    print('Exception when calling SupportTicketsApi->ticketsControllerList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 
 **priority** | **String**|  | [optional] 
 **category** | **String**|  | [optional] 
 **assigneeId** | **String**|  | [optional] 
 **creatorId** | **String**|  | [optional] 
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

# **ticketsControllerRemove**
> ticketsControllerRemove(id)

Delete/Cancel a support ticket

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getSupportTicketsApi();
final String id = id_example; // String | 

try {
    api.ticketsControllerRemove(id);
} on DioException catch (e) {
    print('Exception when calling SupportTicketsApi->ticketsControllerRemove: $e\n');
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

# **ticketsControllerUpdate**
> ticketsControllerUpdate(id, updateTicketDto)

Update a support ticket

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getSupportTicketsApi();
final String id = id_example; // String | 
final UpdateTicketDto updateTicketDto = ; // UpdateTicketDto | 

try {
    api.ticketsControllerUpdate(id, updateTicketDto);
} on DioException catch (e) {
    print('Exception when calling SupportTicketsApi->ticketsControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateTicketDto** | [**UpdateTicketDto**](UpdateTicketDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


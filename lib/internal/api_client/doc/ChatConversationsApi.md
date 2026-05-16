# otlob_api.api.ChatConversationsApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**conversationsControllerClose**](ChatConversationsApi.md#conversationscontrollerclose) | **PATCH** /chat/conversations/{id}/close | Close a conversation
[**conversationsControllerCreateDirect**](ChatConversationsApi.md#conversationscontrollercreatedirect) | **POST** /chat/conversations/direct | Create or get a direct conversation with a user
[**conversationsControllerCreateOrder**](ChatConversationsApi.md#conversationscontrollercreateorder) | **POST** /chat/conversations/order | Create a new conversation for an order
[**conversationsControllerCreateSupport**](ChatConversationsApi.md#conversationscontrollercreatesupport) | **POST** /chat/conversations/support | Create a new support conversation
[**conversationsControllerCreateVendor**](ChatConversationsApi.md#conversationscontrollercreatevendor) | **POST** /chat/conversations/vendor | Create a new vendor conversation
[**conversationsControllerGetOne**](ChatConversationsApi.md#conversationscontrollergetone) | **GET** /chat/conversations/{id} | Get a specific conversation by ID
[**conversationsControllerListMine**](ChatConversationsApi.md#conversationscontrollerlistmine) | **GET** /chat/conversations | List my conversations


# **conversationsControllerClose**
> conversationsControllerClose(id)

Close a conversation

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getChatConversationsApi();
final String id = id_example; // String | 

try {
    api.conversationsControllerClose(id);
} on DioException catch (e) {
    print('Exception when calling ChatConversationsApi->conversationsControllerClose: $e\n');
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

# **conversationsControllerCreateDirect**
> conversationsControllerCreateDirect(createDirectConversationDto)

Create or get a direct conversation with a user

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getChatConversationsApi();
final CreateDirectConversationDto createDirectConversationDto = ; // CreateDirectConversationDto | 

try {
    api.conversationsControllerCreateDirect(createDirectConversationDto);
} on DioException catch (e) {
    print('Exception when calling ChatConversationsApi->conversationsControllerCreateDirect: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createDirectConversationDto** | [**CreateDirectConversationDto**](CreateDirectConversationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **conversationsControllerCreateOrder**
> conversationsControllerCreateOrder(createOrderConversationDto)

Create a new conversation for an order

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getChatConversationsApi();
final CreateOrderConversationDto createOrderConversationDto = ; // CreateOrderConversationDto | 

try {
    api.conversationsControllerCreateOrder(createOrderConversationDto);
} on DioException catch (e) {
    print('Exception when calling ChatConversationsApi->conversationsControllerCreateOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createOrderConversationDto** | [**CreateOrderConversationDto**](CreateOrderConversationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **conversationsControllerCreateSupport**
> conversationsControllerCreateSupport(createSupportConversationDto)

Create a new support conversation

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getChatConversationsApi();
final CreateSupportConversationDto createSupportConversationDto = ; // CreateSupportConversationDto | 

try {
    api.conversationsControllerCreateSupport(createSupportConversationDto);
} on DioException catch (e) {
    print('Exception when calling ChatConversationsApi->conversationsControllerCreateSupport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createSupportConversationDto** | [**CreateSupportConversationDto**](CreateSupportConversationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **conversationsControllerCreateVendor**
> conversationsControllerCreateVendor(createVendorConversationDto)

Create a new vendor conversation

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getChatConversationsApi();
final CreateVendorConversationDto createVendorConversationDto = ; // CreateVendorConversationDto | 

try {
    api.conversationsControllerCreateVendor(createVendorConversationDto);
} on DioException catch (e) {
    print('Exception when calling ChatConversationsApi->conversationsControllerCreateVendor: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createVendorConversationDto** | [**CreateVendorConversationDto**](CreateVendorConversationDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **conversationsControllerGetOne**
> conversationsControllerGetOne(id)

Get a specific conversation by ID

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getChatConversationsApi();
final String id = id_example; // String | 

try {
    api.conversationsControllerGetOne(id);
} on DioException catch (e) {
    print('Exception when calling ChatConversationsApi->conversationsControllerGetOne: $e\n');
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

# **conversationsControllerListMine**
> conversationsControllerListMine(page, limit)

List my conversations

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getChatConversationsApi();
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.conversationsControllerListMine(page, limit);
} on DioException catch (e) {
    print('Exception when calling ChatConversationsApi->conversationsControllerListMine: $e\n');
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


# otlob_api.api.ChatMediaApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**chatMediaControllerUpload**](ChatMediaApi.md#chatmediacontrollerupload) | **POST** /chat/media/upload | 


# **chatMediaControllerUpload**
> chatMediaControllerUpload()



### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getChatMediaApi();

try {
    api.chatMediaControllerUpload();
} on DioException catch (e) {
    print('Exception when calling ChatMediaApi->chatMediaControllerUpload: $e\n');
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


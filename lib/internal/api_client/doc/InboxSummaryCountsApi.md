# otlob_api.api.InboxSummaryCountsApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**inboxControllerGetCounts**](InboxSummaryCountsApi.md#inboxcontrollergetcounts) | **GET** /inbox/counts | Get unread counts for chat and notifications


# **inboxControllerGetCounts**
> inboxControllerGetCounts()

Get unread counts for chat and notifications

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getInboxSummaryCountsApi();

try {
    api.inboxControllerGetCounts();
} on DioException catch (e) {
    print('Exception when calling InboxSummaryCountsApi->inboxControllerGetCounts: $e\n');
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


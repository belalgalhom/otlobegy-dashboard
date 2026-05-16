# otlob_api.api.PromotionsApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**promotionsControllerCreate**](PromotionsApi.md#promotionscontrollercreate) | **POST** /promotions/admin | 
[**promotionsControllerFindAll**](PromotionsApi.md#promotionscontrollerfindall) | **GET** /promotions/admin | Get all promotions (Admin)
[**promotionsControllerFindAllActive**](PromotionsApi.md#promotionscontrollerfindallactive) | **GET** /promotions | Get all active promotions for customer app
[**promotionsControllerFindOne**](PromotionsApi.md#promotionscontrollerfindone) | **GET** /promotions/admin/{id} | 
[**promotionsControllerRemove**](PromotionsApi.md#promotionscontrollerremove) | **DELETE** /promotions/admin/{id} | 
[**promotionsControllerUpdate**](PromotionsApi.md#promotionscontrollerupdate) | **PATCH** /promotions/admin/{id} | 
[**promotionsControllerUploadImage**](PromotionsApi.md#promotionscontrolleruploadimage) | **POST** /promotions/admin/{id}/image | 


# **promotionsControllerCreate**
> promotionsControllerCreate(createPromotionDto)



### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPromotionsApi();
final CreatePromotionDto createPromotionDto = ; // CreatePromotionDto | 

try {
    api.promotionsControllerCreate(createPromotionDto);
} on DioException catch (e) {
    print('Exception when calling PromotionsApi->promotionsControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createPromotionDto** | [**CreatePromotionDto**](CreatePromotionDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **promotionsControllerFindAll**
> promotionsControllerFindAll()

Get all promotions (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPromotionsApi();

try {
    api.promotionsControllerFindAll();
} on DioException catch (e) {
    print('Exception when calling PromotionsApi->promotionsControllerFindAll: $e\n');
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

# **promotionsControllerFindAllActive**
> promotionsControllerFindAllActive()

Get all active promotions for customer app

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPromotionsApi();

try {
    api.promotionsControllerFindAllActive();
} on DioException catch (e) {
    print('Exception when calling PromotionsApi->promotionsControllerFindAllActive: $e\n');
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

# **promotionsControllerFindOne**
> promotionsControllerFindOne(id)



### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPromotionsApi();
final String id = id_example; // String | 

try {
    api.promotionsControllerFindOne(id);
} on DioException catch (e) {
    print('Exception when calling PromotionsApi->promotionsControllerFindOne: $e\n');
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

# **promotionsControllerRemove**
> promotionsControllerRemove(id)



### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPromotionsApi();
final String id = id_example; // String | 

try {
    api.promotionsControllerRemove(id);
} on DioException catch (e) {
    print('Exception when calling PromotionsApi->promotionsControllerRemove: $e\n');
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

# **promotionsControllerUpdate**
> promotionsControllerUpdate(id, updatePromotionDto)



### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPromotionsApi();
final String id = id_example; // String | 
final UpdatePromotionDto updatePromotionDto = ; // UpdatePromotionDto | 

try {
    api.promotionsControllerUpdate(id, updatePromotionDto);
} on DioException catch (e) {
    print('Exception when calling PromotionsApi->promotionsControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updatePromotionDto** | [**UpdatePromotionDto**](UpdatePromotionDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **promotionsControllerUploadImage**
> promotionsControllerUploadImage(id)



### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getPromotionsApi();
final String id = id_example; // String | 

try {
    api.promotionsControllerUploadImage(id);
} on DioException catch (e) {
    print('Exception when calling PromotionsApi->promotionsControllerUploadImage: $e\n');
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


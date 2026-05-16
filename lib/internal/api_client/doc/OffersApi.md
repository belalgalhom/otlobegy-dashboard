# otlob_api.api.OffersApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**offersControllerCreate**](OffersApi.md#offerscontrollercreate) | **POST** /offers/admin | Create new product offer
[**offersControllerFindAll**](OffersApi.md#offerscontrollerfindall) | **GET** /offers/admin | Get all offers (Admin)
[**offersControllerFindAllActive**](OffersApi.md#offerscontrollerfindallactive) | **GET** /offers | Get all active product offers
[**offersControllerRemove**](OffersApi.md#offerscontrollerremove) | **DELETE** /offers/admin/{id} | Delete product offer
[**offersControllerUpdate**](OffersApi.md#offerscontrollerupdate) | **PATCH** /offers/admin/{id} | Update product offer


# **offersControllerCreate**
> offersControllerCreate(createOfferDto)

Create new product offer

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOffersApi();
final CreateOfferDto createOfferDto = ; // CreateOfferDto | 

try {
    api.offersControllerCreate(createOfferDto);
} on DioException catch (e) {
    print('Exception when calling OffersApi->offersControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createOfferDto** | [**CreateOfferDto**](CreateOfferDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **offersControllerFindAll**
> offersControllerFindAll()

Get all offers (Admin)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOffersApi();

try {
    api.offersControllerFindAll();
} on DioException catch (e) {
    print('Exception when calling OffersApi->offersControllerFindAll: $e\n');
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

# **offersControllerFindAllActive**
> offersControllerFindAllActive()

Get all active product offers

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOffersApi();

try {
    api.offersControllerFindAllActive();
} on DioException catch (e) {
    print('Exception when calling OffersApi->offersControllerFindAllActive: $e\n');
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

# **offersControllerRemove**
> offersControllerRemove(id)

Delete product offer

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOffersApi();
final String id = id_example; // String | 

try {
    api.offersControllerRemove(id);
} on DioException catch (e) {
    print('Exception when calling OffersApi->offersControllerRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **offersControllerUpdate**
> offersControllerUpdate(id, updateOfferDto)

Update product offer

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getOffersApi();
final String id = id_example; // String | 
final UpdateOfferDto updateOfferDto = ; // UpdateOfferDto | 

try {
    api.offersControllerUpdate(id, updateOfferDto);
} on DioException catch (e) {
    print('Exception when calling OffersApi->offersControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateOfferDto** | [**UpdateOfferDto**](UpdateOfferDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


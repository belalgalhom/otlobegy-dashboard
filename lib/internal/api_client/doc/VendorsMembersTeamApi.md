# otlob_api.api.VendorsMembersTeamApi

## Load the API package
```dart
import 'package:otlob_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**vendorMembersControllerAddMember**](VendorsMembersTeamApi.md#vendormemberscontrolleraddmember) | **POST** /vendors/{vendorId}/members | Add a new member to the vendor
[**vendorMembersControllerAdminAddMember**](VendorsMembersTeamApi.md#vendormemberscontrolleradminaddmember) | **POST** /vendors/{vendorId}/members/admin | Add a new member to a vendor (Admin Override)
[**vendorMembersControllerAdminRemoveMember**](VendorsMembersTeamApi.md#vendormemberscontrolleradminremovemember) | **DELETE** /vendors/{vendorId}/members/admin/{memberId} | Remove a member from a vendor (Admin Override)
[**vendorMembersControllerFindAll**](VendorsMembersTeamApi.md#vendormemberscontrollerfindall) | **GET** /vendors/{vendorId}/members | List all members of a vendor
[**vendorMembersControllerRemoveMember**](VendorsMembersTeamApi.md#vendormemberscontrollerremovemember) | **DELETE** /vendors/{vendorId}/members/{memberId} | Remove a member from the vendor
[**vendorMembersControllerUpdateRole**](VendorsMembersTeamApi.md#vendormemberscontrollerupdaterole) | **PATCH** /vendors/{vendorId}/members/{memberId}/role | Update a member&#39;s role


# **vendorMembersControllerAddMember**
> vendorMembersControllerAddMember(vendorId, addVendorMemberDto)

Add a new member to the vendor

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMembersTeamApi();
final String vendorId = vendorId_example; // String | 
final AddVendorMemberDto addVendorMemberDto = ; // AddVendorMemberDto | 

try {
    api.vendorMembersControllerAddMember(vendorId, addVendorMemberDto);
} on DioException catch (e) {
    print('Exception when calling VendorsMembersTeamApi->vendorMembersControllerAddMember: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **addVendorMemberDto** | [**AddVendorMemberDto**](AddVendorMemberDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorMembersControllerAdminAddMember**
> vendorMembersControllerAdminAddMember(vendorId, addVendorMemberDto)

Add a new member to a vendor (Admin Override)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMembersTeamApi();
final String vendorId = vendorId_example; // String | 
final AddVendorMemberDto addVendorMemberDto = ; // AddVendorMemberDto | 

try {
    api.vendorMembersControllerAdminAddMember(vendorId, addVendorMemberDto);
} on DioException catch (e) {
    print('Exception when calling VendorsMembersTeamApi->vendorMembersControllerAdminAddMember: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **addVendorMemberDto** | [**AddVendorMemberDto**](AddVendorMemberDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorMembersControllerAdminRemoveMember**
> vendorMembersControllerAdminRemoveMember(vendorId, memberId)

Remove a member from a vendor (Admin Override)

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMembersTeamApi();
final String vendorId = vendorId_example; // String | 
final String memberId = memberId_example; // String | 

try {
    api.vendorMembersControllerAdminRemoveMember(vendorId, memberId);
} on DioException catch (e) {
    print('Exception when calling VendorsMembersTeamApi->vendorMembersControllerAdminRemoveMember: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **memberId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorMembersControllerFindAll**
> vendorMembersControllerFindAll(vendorId)

List all members of a vendor

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMembersTeamApi();
final String vendorId = vendorId_example; // String | 

try {
    api.vendorMembersControllerFindAll(vendorId);
} on DioException catch (e) {
    print('Exception when calling VendorsMembersTeamApi->vendorMembersControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorMembersControllerRemoveMember**
> vendorMembersControllerRemoveMember(vendorId, memberId)

Remove a member from the vendor

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMembersTeamApi();
final String vendorId = vendorId_example; // String | 
final String memberId = memberId_example; // String | 

try {
    api.vendorMembersControllerRemoveMember(vendorId, memberId);
} on DioException catch (e) {
    print('Exception when calling VendorsMembersTeamApi->vendorMembersControllerRemoveMember: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **memberId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **vendorMembersControllerUpdateRole**
> vendorMembersControllerUpdateRole(vendorId, memberId, updateVendorMemberRoleDto)

Update a member's role

### Example
```dart
import 'package:otlob_api/api.dart';

final api = OtlobApi().getVendorsMembersTeamApi();
final String vendorId = vendorId_example; // String | 
final String memberId = memberId_example; // String | 
final UpdateVendorMemberRoleDto updateVendorMemberRoleDto = ; // UpdateVendorMemberRoleDto | 

try {
    api.vendorMembersControllerUpdateRole(vendorId, memberId, updateVendorMemberRoleDto);
} on DioException catch (e) {
    print('Exception when calling VendorsMembersTeamApi->vendorMembersControllerUpdateRole: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vendorId** | **String**|  | 
 **memberId** | **String**|  | 
 **updateVendorMemberRoleDto** | [**UpdateVendorMemberRoleDto**](UpdateVendorMemberRoleDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


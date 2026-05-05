import 'package:otlob_api/otlob_api.dart';
import 'package:dio/dio.dart' as dio;
import 'package:built_value/json_object.dart';
import 'package:otlob_admin/core/models/paginated_result.dart';

class VendorRepository {
  final OtlobApi _apiClient;

  VendorRepository(this._apiClient);

  Future<PaginatedResult<dynamic>> getVendors({
    int page = 1,
    int limit = 20,
    String? search,
    String? verticalId,
    String? status,
  }) async {
    try {
      final response = await _apiClient.getVendorsCoreManagementApi().vendorsControllerFindAll(
        page: page,
        limit: limit,
        search: (search != null && search.isNotEmpty) ? search : null,
        verticalId: (verticalId != null && verticalId.isNotEmpty) ? verticalId : null,
        status: (status != null && status.isNotEmpty) ? status : null,
      );
      final dynamic responseMap = (response as dynamic).data;
      
      if (responseMap is Map && responseMap['data'] != null) {
        final data = responseMap['data'] as Map<String, dynamic>;
        final items = data['vendors'] as List<dynamic>? ?? [];
        final total = data['total'] as int? ?? items.length;
        return PaginatedResult(items: items, total: total);
      } else if (responseMap is List) {
        return PaginatedResult(items: responseMap, total: responseMap.length);
      }
      return PaginatedResult.empty();
    } catch (e) {
      print('VendorRepository getVendors Error: $e');
      return PaginatedResult.empty();
    }
  }

  Future<List<dynamic>> getVerticals() async {
    try {
      final response = await _apiClient.getVendorsVerticalsCategoriesApi().vendorVerticalsControllerFindAllActive();
      final dynamic responseMap = (response as dynamic).data;
      if (responseMap is List) return responseMap;
      if (responseMap is Map && responseMap['data'] != null) {
        return responseMap['data'] as List<dynamic>? ?? [];
      }
      return [];
    } catch (e) {
      print('VendorRepository getVerticals Error: $e');
      return [];
    }
  }

  Future<List<dynamic>> getVerticalsAdmin() async {
    try {
      final response = await _apiClient.getVendorsVerticalsCategoriesApi().vendorVerticalsControllerFindAll();
      final dynamic responseMap = (response as dynamic).data;
      if (responseMap is List) return responseMap;
      if (responseMap is Map && responseMap['data'] != null) {
        return responseMap['data'] as List<dynamic>? ?? [];
      }
      return [];
    } catch (e) {
      print('VendorRepository getVerticalsAdmin Error: $e');
      return [];
    }
  }

  Future<bool> createVertical(Map<String, dynamic> data) async {
    try {
      final dto = CreateVendorVerticalDto((b) => b
        ..name = data['name'] ?? ''
        ..nameAr = data['nameAr']
        ..slug = (data['name'] as String).toLowerCase().replaceAll(' ', '-')
        ..iconUrl = data['iconUrl']
        ..isActive = data['isActive'] ?? true
        ..sortOrder = data['sortOrder'] ?? 0
      );
      await _apiClient.getVendorsVerticalsCategoriesApi().vendorVerticalsControllerCreate(createVendorVerticalDto: dto);
      return true;
    } catch (e) {
      print('VendorRepository createVertical Error: $e');
      return false;
    }
  }

  Future<bool> updateVertical(String id, Map<String, dynamic> data) async {
    try {
      final dto = UpdateVendorVerticalDto((b) => b
        ..name = data['name']
        ..nameAr = data['nameAr']
        ..slug = data['name'] != null ? (data['name'] as String).toLowerCase().replaceAll(' ', '-') : null
        ..iconUrl = data['iconUrl']
        ..isActive = data['isActive']
        ..sortOrder = data['sortOrder']
      );
      await _apiClient.getVendorsVerticalsCategoriesApi().vendorVerticalsControllerUpdate(id: id, updateVendorVerticalDto: dto);
      return true;
    } catch (e) {
      print('VendorRepository updateVertical Error: $e');
      return false;
    }
  }

  Future<bool> deleteVertical(String id) async {
    try {
      await _apiClient.getVendorsVerticalsCategoriesApi().vendorVerticalsControllerRemove(id: id);
      return true;
    } catch (e) {
      print('VendorRepository deleteVertical Error: $e');
      return false;
    }
  }

  Future<bool> createVendor(Map<String, dynamic> data) async {
    try {
      final dto = CreateVendorDto((b) => b
        ..storeName = data['storeName'] ?? ''
        ..storeNameAr = data['storeNameAr'] ?? ''
        ..description = data['description'] ?? ''
        ..descriptionAr = data['descriptionAr'] ?? ''
        ..verticalId = data['verticalId'] ?? ''
        ..taxId = data['taxId'] ?? ''
        ..commissionRate = data['commissionRate'] ?? 10
      );
      await _apiClient.getVendorsCoreManagementApi().vendorsControllerCreate(createVendorDto: dto);
      return true;
    } catch (e) {
      print('VendorRepository createVendor Error: $e');
      return false;
    }
  }

  Future<bool> updateVendor(String id, Map<String, dynamic> data) async {
    try {
      final dto = UpdateVendorDto((b) => b
        ..storeName = data['storeName']
        ..storeNameAr = data['storeNameAr']
        ..description = data['description']
        ..descriptionAr = data['descriptionAr']
        ..verticalId = data['verticalId']
        ..taxId = data['taxId']
        ..commissionRate = data['commissionRate']
      );
      await _apiClient.getVendorsCoreManagementApi().vendorsControllerUpdate(vendorId: id, updateVendorDto: dto);
      return true;
    } catch (e) {
      print('VendorRepository updateVendor Error: $e');
      return false;
    }
  }

  Future<bool> updateVendorStatus(String id, String status) async {
    try {
      final dto = UpdateVendorStatusDto((b) => b
        ..status = UpdateVendorStatusDtoStatusEnum.valueOf(status)
      );
      await _apiClient.getVendorsCoreManagementApi().vendorsControllerUpdateStatus(vendorId: id, updateVendorStatusDto: dto);
      return true;
    } catch (e) {
      print('VendorRepository updateVendorStatus Error: $e');
      return false;
    }
  }

  Future<bool> deleteVendor(String id) async {
    try {
      await _apiClient.getVendorsCoreManagementApi().vendorsControllerRemove(vendorId: id);
      return true;
    } catch (e) {
      print('VendorRepository deleteVendor Error: $e');
      return false;
    }
  }

  Future<String?> createProduct(Map<String, dynamic> data) async {
    try {
      final dto = CreateProductDto((b) => b
        ..categoryId = data['categoryId']
        ..name = data['name'] ?? ''
        ..nameAr = data['nameAr']
        ..description = data['description']
        ..descriptionAr = data['descriptionAr']
        ..basePrice = (data['basePrice'] as num?)?.toDouble()
        ..comparePrice = (data['comparePrice'] as num?)?.toDouble()
        ..sku = data['sku']
        ..stock = (data['stock'] as num?)?.toInt() ?? 0
        ..isActive = data['isActive'] ?? true
        ..isFeatured = data['isFeatured'] ?? false
      );
      final response = await _apiClient.getVendorsProductsApi().productsControllerAdminCreate(
        vendorId: data['vendorId'],
        createProductDto: dto,
      );
      
      final responseMap = (response as dynamic).data;
      if (responseMap is Map) {
        return responseMap['id']?.toString();
      }
      return 'success'; // Fallback if ID is not returned but request succeeded
    } catch (e) {
      print('VendorRepository createProduct Error: $e');
      return null;
    }
  }

  Future<PaginatedResult<dynamic>> getProducts(String vendorId, {int page = 1, int limit = 20, String? search}) async {
    try {
      final response = await _apiClient.getVendorsProductsApi().productsControllerFindAll(
        vendorId: vendorId,
        page: page,
        limit: limit,
        search: search,
      );
      final dynamic responseMap = (response as dynamic).data;
      if (responseMap is Map && responseMap['data'] != null) {
        final data = responseMap['data'] as Map<String, dynamic>;
        final items = data['products'] as List<dynamic>? ?? [];
        final total = data['total'] as int? ?? items.length;
        return PaginatedResult(items: items, total: total);
      } else if (responseMap is List) {
        return PaginatedResult(items: responseMap, total: responseMap.length);
      }
      return PaginatedResult.empty();
    } catch (e) {
      print('VendorRepository getProducts Error: $e');
      return PaginatedResult.empty();
    }
  }

  Future<bool> updateProduct(String vendorId, String productId, Map<String, dynamic> data) async {
    try {
      final dto = UpdateProductDto((b) => b
        ..categoryId = data['categoryId'] != null ? JsonObject(data['categoryId']) : null
        ..name = data['name']
        ..nameAr = data['nameAr']
        ..description = data['description']
        ..descriptionAr = data['descriptionAr']
        ..basePrice = (data['basePrice'] as num?)?.toDouble()
        ..comparePrice = (data['comparePrice'] as num?)?.toDouble()
        ..sku = data['sku']
        ..stock = (data['stock'] as num?)?.toInt()
        ..isActive = data['isActive']
        ..isFeatured = data['isFeatured']
      );
      await _apiClient.getVendorsProductsApi().productsControllerAdminUpdate(
        vendorId: vendorId,
        productId: productId,
        updateProductDto: dto,
      );
      return true;
    } catch (e) {
      print('VendorRepository updateProduct Error: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String vendorId, String productId) async {
    try {
      await _apiClient.getVendorsProductsApi().productsControllerAdminRemove(
        vendorId: vendorId,
        productId: productId,
      );
      return true;
    } catch (e) {
      print('VendorRepository deleteProduct Error: $e');
      return false;
    }
  }

  Future<List<dynamic>> getMenuCategories(String vendorId) async {
    try {
      final response = await _apiClient.getVendorsMenuCategoriesApi().menuCategoriesControllerFindAll(vendorId: vendorId);
      final dynamic responseMap = (response as dynamic).data;
      if (responseMap is List) return responseMap;
      if (responseMap is Map && responseMap['data'] != null) {
        return responseMap['data'] as List<dynamic>? ?? [];
      }
      return [];
    } catch (e) {
      print('VendorRepository getMenuCategories Error: $e');
      return [];
    }
  }

  Future<bool> createMenuCategory(String vendorId, Map<String, dynamic> data) async {
    try {
      final dto = CreateMenuCategoryDto((b) => b
        ..name = data['name'] ?? ''
        ..nameAr = data['nameAr'] ?? ''
        ..description = data['description'] ?? ''
        ..descriptionAr = data['descriptionAr'] ?? ''
        ..isActive = data['isActive'] ?? true
      );
      await _apiClient.getVendorsMenuCategoriesApi().menuCategoriesControllerAdminCreate(
        vendorId: vendorId,
        createMenuCategoryDto: dto,
      );
      return true;
    } catch (e) {
      print('VendorRepository createMenuCategory Error: $e');
      return false;
    }
  }

  Future<bool> updateMenuCategory(String vendorId, String categoryId, Map<String, dynamic> data) async {
    try {
      final dto = UpdateMenuCategoryDto((b) => b
        ..name = data['name']
        ..nameAr = data['nameAr']
        ..description = data['description']
        ..descriptionAr = data['descriptionAr']
        ..isActive = data['isActive']
      );
      await _apiClient.getVendorsMenuCategoriesApi().menuCategoriesControllerAdminUpdate(
        vendorId: vendorId,
        categoryId: categoryId,
        updateMenuCategoryDto: dto,
      );
      return true;
    } catch (e) {
      print('VendorRepository updateMenuCategory Error: $e');
      return false;
    }
  }

  Future<bool> deleteMenuCategory(String vendorId, String categoryId) async {
    try {
      await _apiClient.getVendorsMenuCategoriesApi().menuCategoriesControllerAdminRemove(
        vendorId: vendorId,
        categoryId: categoryId,
      );
      return true;
    } catch (e) {
      print('VendorRepository deleteMenuCategory Error: $e');
      return false;
    }
  }

  Future<List<dynamic>> getBranches(String vendorId) async {
    try {
      final response = await _apiClient.getVendorsBranchesApi().vendorBranchesControllerFindAll(vendorId: vendorId);
      final dynamic responseMap = (response as dynamic).data;
      if (responseMap is List) return responseMap;
      if (responseMap is Map && responseMap['data'] != null) {
        return responseMap['data'] as List<dynamic>? ?? [];
      }
      return [];
    } catch (e) {
      print('VendorRepository getBranches Error: $e');
      return [];
    }
  }

  Future<bool> createBranch(String vendorId, Map<String, dynamic> data) async {
    try {
      final dto = CreateVendorBranchDto((b) => b
        ..name = data['name'] ?? ''
        ..nameAr = data['nameAr'] ?? ''
        ..address = data['address'] ?? ''
        ..phone = data['phoneNumber'] ?? ''
        ..location.replace(['0.0', '0.0']) // Default location
        ..isOpen = data['isActive'] ?? true
      );
      await _apiClient.getVendorsBranchesApi().vendorBranchesControllerAdminCreate(
        vendorId: vendorId,
        createVendorBranchDto: dto,
      );
      return true;
    } catch (e) {
      print('VendorRepository createBranch Error: $e');
      return false;
    }
  }

  Future<bool> updateBranch(String vendorId, String branchId, Map<String, dynamic> data) async {
    try {
      final dto = UpdateVendorBranchDto((b) => b
        ..name = data['name']
        ..nameAr = data['nameAr']
        ..address = data['address']
        ..phone = data['phoneNumber']
        ..isOpen = data['isActive']
      );
      await _apiClient.getVendorsBranchesApi().vendorBranchesControllerAdminUpdate(
        vendorId: vendorId,
        branchId: branchId,
        updateVendorBranchDto: dto,
      );
      return true;
    } catch (e) {
      print('VendorRepository updateBranch Error: $e');
      return false;
    }
  }

  Future<bool> deleteBranch(String vendorId, String branchId) async {
    try {
      await _apiClient.getVendorsBranchesApi().vendorBranchesControllerAdminRemove(
        vendorId: vendorId,
        branchId: branchId,
      );
      return true;
    } catch (e) {
      print('VendorRepository deleteBranch Error: $e');
      return false;
    }
  }

  Future<bool> uploadProductImage(String vendorId, String productId, dio.MultipartFile file) async {
    try {
      await _apiClient.getVendorsProductsApi().productsControllerUploadImage(
        vendorId: vendorId,
        productId: productId,
        file: file,
      );
      return true;
    } catch (e) {
      print('VendorRepository uploadProductImage Error: $e');
      return false;
    }
  }
}

import 'package:image_picker/image_picker.dart';
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

  Future<String?> createVertical(Map<String, dynamic> data) async {
    try {
      final dto = CreateVendorVerticalDto((b) => b
        ..name = data['name'] ?? ''
        ..nameAr = data['nameAr']
        ..slug = (data['name'] as String).toLowerCase().replaceAll(' ', '-')
        ..iconUrl = data['iconUrl']
        ..isActive = data['isActive'] ?? true
        ..sortOrder = data['sortOrder'] ?? 0
      );
      final response = await _apiClient.getVendorsVerticalsCategoriesApi().vendorVerticalsControllerCreate(createVendorVerticalDto: dto);
      
      final dynamic responseMap = (response as dynamic).data;
      String? id;
      if (responseMap is Map) {
        id = responseMap['id']?.toString() ?? responseMap['data']?['id']?.toString();
      }
      
      if (id != null && data['iconFile'] != null) {
        final xFile = data['iconFile'] as XFile;
        await uploadVerticalIcon(id, xFile.path, xFile.name);
      }
      
      return id ?? 'success';
    } catch (e) {
      if (e is dio.DioException) {
        print('VendorRepository createVertical Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('VendorRepository createVertical Error: $e');
      }
      return null;
    }
  }

  Future<bool> uploadVerticalIcon(String id, String filePath, String fileName) async {
    try {
      // Create fresh FormData for the first attempt
      final formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(filePath, filename: fileName),
      });

      // Trying admin path first as verticals for admin are at /vendor-verticals/admin
      await _apiClient.dio.post(
        '/vendor-verticals/admin/$id/icon',
        data: formData,
      );
      return true;
    } catch (e) {
      if (e is dio.DioException) {
        print('VendorRepository uploadVerticalIcon Error: ${e.response?.statusCode} - ${e.response?.data}');
        // Fallback to non-admin path if admin fails with 404
        if (e.response?.statusCode == 404) {
          try {
            // Create fresh FormData for the fallback attempt
            final fallbackFormData = dio.FormData.fromMap({
              'file': await dio.MultipartFile.fromFile(filePath, filename: fileName),
            });

            await _apiClient.dio.post(
              '/vendor-verticals/$id/icon',
              data: fallbackFormData,
            );
            return true;
          } catch (e2) {
             print('VendorRepository uploadVerticalIcon Fallback Error: $e2');
          }
        }
      } else {
        print('VendorRepository uploadVerticalIcon Error: $e');
      }
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
      
      if (data['iconFile'] != null) {
        final xFile = data['iconFile'] as XFile;
        await uploadVerticalIcon(id, xFile.path, xFile.name);
      }
      
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
        ..phone = data['phone']
      );
      final response = await _apiClient.getVendorsCoreManagementApi().vendorsControllerCreate(createVendorDto: dto);
      
      // If we have a cover image, upload it
      if (data['coverImage'] != null) {
        final dynamic responseMap = (response as dynamic).data;
        String? vendorId;
        if (responseMap is Map) {
          vendorId = responseMap['id']?.toString() ?? responseMap['data']?['id']?.toString();
        }
        
        if (vendorId != null) {
          final xFile = data['coverImage']; // This is XFile
          final multipartFile = await dio.MultipartFile.fromFile(
            xFile.path,
            filename: xFile.name,
          );
          await _apiClient.getVendorsCoreManagementApi().vendorsControllerUploadCover(
            vendorId: vendorId,
            file: multipartFile,
          );
        }
      }
      return true;
    } catch (e) {
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to create vendor';
      }
      rethrow;
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
        ..phone = data['phone']
      );
      await _apiClient.getVendorsCoreManagementApi().vendorsControllerUpdate(vendorId: id, updateVendorDto: dto);
      
      // If we have a cover image, upload it
      if (data['coverImage'] != null) {
        final xFile = data['coverImage'];
        final multipartFile = await dio.MultipartFile.fromFile(
          xFile.path,
          filename: xFile.name,
        );
        await _apiClient.getVendorsCoreManagementApi().vendorsControllerUploadCover(
          vendorId: id,
          file: multipartFile,
        );
      }
      return true;
    } catch (e) {
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to update vendor';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to update status';
      }
      rethrow;
    }

  }

  Future<bool> deleteVendor(String id) async {
    try {
      await _apiClient.getVendorsCoreManagementApi().vendorsControllerRemove(vendorId: id);
      return true;
    } catch (e) {
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to delete vendor';
      }
      rethrow;
    }

  }

  Future<String?> createProduct(Map<String, dynamic> data) async {
    try {
      print('VendorRepository: Creating product with data: $data');
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
      
      print('VendorRepository: DTO built: $dto');
      
      final response = await _apiClient.getVendorsProductsApi().productsControllerAdminCreate(
        vendorId: data['vendorId'],
        createProductDto: dto,
      );
      
      final responseMap = (response as dynamic).data;
      String? id;
      if (responseMap is Map) {
        id = responseMap['id']?.toString() ?? responseMap['data']?['id']?.toString();
      }
      
      print('VendorRepository: Product created successfully. ID: $id');
      return id ?? 'success';
    } catch (e) {
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to add product';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to update product';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to delete product';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to create menu category';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to update menu category';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to delete menu category';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to create branch';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to update branch';
      }
      rethrow;
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
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to delete branch';
      }
      rethrow;
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

  // --- Promotions ---

  Future<List<dynamic>> getPromotions() async {
    try {
      final response = await _apiClient.dio.get('/promotions/admin');
      final data = response.data;
      if (data is List) return data;
      if (data is Map && data['data'] != null) return data['data'] as List<dynamic>;
      return [];
    } catch (e) {
      print('VendorRepository getPromotions Error: $e');
      return [];
    }
  }

  Future<String?> createPromotion(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.dio.post('/promotions/admin', data: {
        'title': data['title'],
        'titleAr': data['titleAr'],
        'description': data['description'],
        'descriptionAr': data['descriptionAr'],
        'type': data['type'] ?? 'BANNER',
        'vendorId': data['vendorId'],
        'productId': data['productId'],
        'externalUrl': data['externalUrl'],
        'isActive': data['isActive'] ?? true,
        'sortOrder': data['sortOrder'] ?? 0,
        'startDate': data['startDate'],
        'endDate': data['endDate'],
      });
      
      final resData = response.data;
      if (resData is Map) {
        return resData['id']?.toString() ?? resData['data']?['id']?.toString();
      }
      return 'success';
    } catch (e) {
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to create promotion';
      }
      print('VendorRepository createPromotion Error: $e');
      rethrow;
    }
  }

  Future<bool> updatePromotion(String id, Map<String, dynamic> data) async {
    try {
      await _apiClient.dio.patch('/promotions/admin/$id', data: {
        'title': data['title'],
        'titleAr': data['titleAr'],
        'description': data['description'],
        'descriptionAr': data['descriptionAr'],
        'type': data['type'],
        'vendorId': data['vendorId'],
        'productId': data['productId'],
        'externalUrl': data['externalUrl'],
        'isActive': data['isActive'],
        'sortOrder': data['sortOrder'],
        'startDate': data['startDate'],
        'endDate': data['endDate'],
      });
      return true;
    } catch (e) {
      if (e is dio.DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to update promotion';
      }
      print('VendorRepository updatePromotion Error: $e');
      rethrow;
    }
  }

  Future<bool> deletePromotion(String id) async {
    try {
      await _apiClient.dio.delete('/promotions/admin/$id');
      return true;
    } catch (e) {
      print('VendorRepository deletePromotion Error: $e');
      return false;
    }
  }

  Future<bool> uploadPromotionImage(String id, dio.MultipartFile file) async {
    try {
      final formData = dio.FormData.fromMap({
        'file': file,
      });
      await _apiClient.dio.post('/promotions/admin/$id/image', data: formData);
      return true;
    } catch (e) {
      print('VendorRepository uploadPromotionImage Error: $e');
      return false;
    }
  }
}

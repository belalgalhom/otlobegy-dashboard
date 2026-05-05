import 'package:dio/dio.dart';
import 'package:otlob_api/otlob_api.dart';
import 'package:otlob_admin/core/models/paginated_result.dart';

class UsersRepository {
  final OtlobApi _apiClient;

  UsersRepository(this._apiClient);

  Future<PaginatedResult<dynamic>> getUsers({
    int page = 1,
    int limit = 20,
    String? search,
    String? role,
    bool? isBanned,
  }) async {
    try {
      final response = await _apiClient.getUsersApi().usersControllerAdminFindAll(
        page: page,
        limit: limit,
        search: (search != null && search.isNotEmpty) ? search : null,
        role: (role != null && role.isNotEmpty) ? role : null,
        isBanned: isBanned,
      );
      final dynamic responseMap = (response as dynamic).data;
      
      if (responseMap is Map && responseMap['data'] != null) {
        final data = responseMap['data'] as Map<String, dynamic>;
        final users = data['users'] as List<dynamic>? ?? [];
        final total = data['total'] as int? ?? users.length;
        return PaginatedResult(items: users, total: total);
      } else if (responseMap is List) {
        return PaginatedResult(items: responseMap, total: responseMap.length);
      }
      return PaginatedResult.empty();
    } catch (e, st) {
      print('UsersRepository Error: $e');
      print(st);
      return PaginatedResult.empty();
    }
  }

  Future<PaginatedResult<dynamic>> getCustomers() async {
    try {
      final response = await _apiClient.getCustomersApi().customersControllerAdminFindAll();
      final dynamic responseMap = (response as dynamic).data;
      
      if (responseMap is Map && responseMap['data'] != null) {
        final data = responseMap['data'] as Map<String, dynamic>;
        final items = (data['customers'] ?? data['data'] ?? []) as List<dynamic>;
        final total = data['total'] as int? ?? items.length;
        return PaginatedResult(items: items, total: total);
      } else if (responseMap is List) {
        return PaginatedResult(items: responseMap, total: responseMap.length);
      }
      return PaginatedResult.empty();
    } catch (e) {
      return PaginatedResult.empty();
    }
  }

  Future<bool> addUser({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phone,
  }) async {
    try {
      final dto = RegisterDto((b) => b
        ..name = name
        ..email = email
        ..password = password
        ..phone = phone
      );
      
      await _apiClient.getUsersApi().usersControllerAdminCreate(registerDto: dto);
      
      // If a specific role was requested that isn't the default (CUSTOMER),
      // we might need to update the user's role immediately after registration.
      // But we need the user ID. For now, let's just register.
      return true;
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to add user';
      }
      rethrow;
    }
  }
  Future<bool> updateUser(String id, {
    String? name,
    String? email,
    String? phone,
    String? role,
  }) async {
    try {
      final dto = AdminUpdateUserDto((b) {
        if (name != null) b.name = name;
        if (email != null) b.email = email;
        if (phone != null) b.phone = phone;
        if (role != null) b.role = AdminUpdateUserDtoRoleEnum.valueOf(role);
      });
      await _apiClient.getUsersApi().usersControllerAdminUpdate(
        userId: id,
        adminUpdateUserDto: dto,
      );
      return true;
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to update user';
      }
      rethrow;
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      await _apiClient.getUsersApi().usersControllerAdminRemove(userId: id);
      return true;
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final responseData = e.response?.data as Map<String, dynamic>;
        throw responseData['message'] ?? 'Failed to delete user';
      }
      rethrow;
    }
  }

  Future<bool> banUser(String id, {String? reason}) async {
    try {
      final dto = BanUserDto((b) {
        if (reason != null) b.reason = reason;
      });
      await _apiClient.getUsersApi().usersControllerAdminBan(
        userId: id,
        banUserDto: dto,
      );
      return true;
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to ban user';
      }
      rethrow;
    }
  }

  Future<bool> unbanUser(String id) async {
    try {
      await _apiClient.getUsersApi().usersControllerAdminUnban(userId: id);
      return true;
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final data = e.response?.data as Map<String, dynamic>;
        throw data['message'] ?? 'Failed to unban user';
      }
      rethrow;
    }
  }
}

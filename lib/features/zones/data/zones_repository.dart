import 'package:otlob_api/otlob_api.dart';
import 'package:otlob_admin/core/models/paginated_result.dart';

class ZonesRepository {
  final OtlobApi _apiClient;

  ZonesRepository(this._apiClient);

  Future<PaginatedResult<dynamic>> getZones({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiClient.getLogisticsZonesApi().zonesControllerFindAll();
      final dynamic responseMap = (response as dynamic).data;
      
      if (responseMap is Map && responseMap['data'] != null) {
        final dynamic dataField = responseMap['data'];
        if (dataField is List) {
          return PaginatedResult(items: dataField, total: dataField.length);
        } else if (dataField is Map) {
          final items = (dataField['zones'] ?? dataField['items'] ?? []) as List<dynamic>;
          final total = dataField['total'] as int? ?? items.length;
          return PaginatedResult(items: items, total: total);
        }
      } else if (responseMap is List) {
        return PaginatedResult(items: responseMap, total: responseMap.length);
      }
      return PaginatedResult.empty();
    } catch (e) {
      print('ZonesRepository getZones Error: $e');
      return PaginatedResult.empty();
    }
  }

  Future<bool> createZone(Map<String, dynamic> data) async {
    try {
      final dto = CreateZoneDto((b) => b
        ..name = data['name'] ?? ''
        ..boundary.replace([])
      );
      await _apiClient.getLogisticsZonesApi().zonesControllerCreate(createZoneDto: dto);
      return true;
    } catch (e) {
      return false;
    }
  }
}

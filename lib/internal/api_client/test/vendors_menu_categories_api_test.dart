import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for VendorsMenuCategoriesApi
void main() {
  final instance = OtlobApi().getVendorsMenuCategoriesApi();

  group(VendorsMenuCategoriesApi, () {
    // Create a new menu category (Admin Override)
    //
    //Future menuCategoriesControllerAdminCreate(String vendorId, CreateMenuCategoryDto createMenuCategoryDto) async
    test('test menuCategoriesControllerAdminCreate', () async {
      // TODO
    });

    // Delete a menu category (Admin Override)
    //
    //Future menuCategoriesControllerAdminRemove(String vendorId, String categoryId) async
    test('test menuCategoriesControllerAdminRemove', () async {
      // TODO
    });

    // Update a menu category (Admin Override)
    //
    //Future menuCategoriesControllerAdminUpdate(String vendorId, String categoryId, UpdateMenuCategoryDto updateMenuCategoryDto) async
    test('test menuCategoriesControllerAdminUpdate', () async {
      // TODO
    });

    // Create a new menu category (Member)
    //
    //Future menuCategoriesControllerCreate(String vendorId, CreateMenuCategoryDto createMenuCategoryDto) async
    test('test menuCategoriesControllerCreate', () async {
      // TODO
    });

    // List all menu categories for a vendor
    //
    //Future menuCategoriesControllerFindAll(String vendorId, { bool activeOnly }) async
    test('test menuCategoriesControllerFindAll', () async {
      // TODO
    });

    // Get a specific menu category by ID
    //
    //Future menuCategoriesControllerFindOne(String vendorId, String categoryId) async
    test('test menuCategoriesControllerFindOne', () async {
      // TODO
    });

    // Delete a menu category (Member)
    //
    //Future menuCategoriesControllerRemove(String vendorId, String categoryId) async
    test('test menuCategoriesControllerRemove', () async {
      // TODO
    });

    // Reorder menu categories
    //
    //Future menuCategoriesControllerReorder(String vendorId, ReorderCategoriesDto reorderCategoriesDto) async
    test('test menuCategoriesControllerReorder', () async {
      // TODO
    });

    // Update a menu category (Member)
    //
    //Future menuCategoriesControllerUpdate(String vendorId, String categoryId, UpdateMenuCategoryDto updateMenuCategoryDto) async
    test('test menuCategoriesControllerUpdate', () async {
      // TODO
    });

  });
}

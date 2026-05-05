import 'package:test/test.dart';
import 'package:otlob_api/otlob_api.dart';


/// tests for VendorsProductsApi
void main() {
  final instance = OtlobApi().getVendorsProductsApi();

  group(VendorsProductsApi, () {
    // Add an option to a group
    //
    //Future productsControllerAddOption(String vendorId, String productId, String groupId, CreateProductOptionDto createProductOptionDto) async
    test('test productsControllerAddOption', () async {
      // TODO
    });

    // Add an option group to a product
    //
    //Future productsControllerAddOptionGroup(String vendorId, String productId, CreateOptionGroupDto createOptionGroupDto) async
    test('test productsControllerAddOptionGroup', () async {
      // TODO
    });

    // Add a variant to a product
    //
    //Future productsControllerAddVariant(String vendorId, String productId, CreateProductVariantDto createProductVariantDto) async
    test('test productsControllerAddVariant', () async {
      // TODO
    });

    // Add an option group to a product variant
    //
    //Future productsControllerAddVariantOptionGroup(String vendorId, String productId, String variantId, CreateOptionGroupDto createOptionGroupDto) async
    test('test productsControllerAddVariantOptionGroup', () async {
      // TODO
    });

    // Create a new product (Admin Override)
    //
    //Future productsControllerAdminCreate(String vendorId, CreateProductDto createProductDto) async
    test('test productsControllerAdminCreate', () async {
      // TODO
    });

    // Delete a product (Admin Override)
    //
    //Future productsControllerAdminRemove(String vendorId, String productId) async
    test('test productsControllerAdminRemove', () async {
      // TODO
    });

    // Update a product (Admin Override)
    //
    //Future productsControllerAdminUpdate(String vendorId, String productId, UpdateProductDto updateProductDto) async
    test('test productsControllerAdminUpdate', () async {
      // TODO
    });

    // Create a new product (Member)
    //
    //Future productsControllerCreate(String vendorId, CreateProductDto createProductDto) async
    test('test productsControllerCreate', () async {
      // TODO
    });

    // List all products for a vendor
    //
    //Future productsControllerFindAll(String vendorId, { String categoryId, bool isActive, bool isFeatured, String search, num page, num limit }) async
    test('test productsControllerFindAll', () async {
      // TODO
    });

    // Get a specific product by ID
    //
    //Future productsControllerFindOne(String vendorId, String productId) async
    test('test productsControllerFindOne', () async {
      // TODO
    });

    // Delete a product (Member)
    //
    //Future productsControllerRemove(String vendorId, String productId) async
    test('test productsControllerRemove', () async {
      // TODO
    });

    // Delete an option from a group
    //
    //Future productsControllerRemoveOption(String vendorId, String productId, String groupId, String optionId) async
    test('test productsControllerRemoveOption', () async {
      // TODO
    });

    // Delete a product option group
    //
    //Future productsControllerRemoveOptionGroup(String vendorId, String productId, String groupId) async
    test('test productsControllerRemoveOptionGroup', () async {
      // TODO
    });

    // Delete a product variant
    //
    //Future productsControllerRemoveVariant(String vendorId, String productId, String variantId) async
    test('test productsControllerRemoveVariant', () async {
      // TODO
    });

    // Update a product (Member)
    //
    //Future productsControllerUpdate(String vendorId, String productId, UpdateProductDto updateProductDto) async
    test('test productsControllerUpdate', () async {
      // TODO
    });

    // Update an option in a group
    //
    //Future productsControllerUpdateOption(String vendorId, String productId, String groupId, String optionId, UpdateProductOptionDto updateProductOptionDto) async
    test('test productsControllerUpdateOption', () async {
      // TODO
    });

    // Update a product option group
    //
    //Future productsControllerUpdateOptionGroup(String vendorId, String productId, String groupId, UpdateOptionGroupDto updateOptionGroupDto) async
    test('test productsControllerUpdateOptionGroup', () async {
      // TODO
    });

    // Update a product variant
    //
    //Future productsControllerUpdateVariant(String vendorId, String productId, String variantId, UpdateProductVariantDto updateProductVariantDto) async
    test('test productsControllerUpdateVariant', () async {
      // TODO
    });

    // Upload product image
    //
    //Future productsControllerUploadImage(String vendorId, String productId, { MultipartFile file }) async
    test('test productsControllerUploadImage', () async {
      // TODO
    });

  });
}

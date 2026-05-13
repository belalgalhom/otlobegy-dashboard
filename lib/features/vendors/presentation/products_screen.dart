import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/features/vendors/presentation/widgets/add_product_dialog.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:otlob_admin/core/utils/error_utils.dart';
import 'package:otlob_admin/core/utils/image_utils.dart';
import 'package:otlob_admin/core/widgets/dashboard_search_bar.dart';


class ProductsScreen extends StatefulWidget {
  final String vendorId;
  final String vendorName;

  const ProductsScreen({
    super.key,
    required this.vendorId,
    required this.vendorName,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<dynamic> _products = [];
  bool _isLoading = true;
  int _total = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts({String? search}) async {
    setState(() => _isLoading = true);
    final result = await sl<VendorRepository>().getProducts(widget.vendorId, search: search);
    if (mounted) {
      setState(() {
        _products = result.items;
        _total = result.total;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              AppColors.primary.withOpacity(0.05),
              Colors.transparent,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(LucideIcons.arrowLeft, color: Theme.of(context).colorScheme.onSurface),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.products,
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 24,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            '${widget.vendorName} • ${AppLocalizations.of(context)!.itemsCount(_total)}',
                            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showAddProductDialog(),
                      icon: const Icon(LucideIcons.plus, size: 18),
                      label: isMobile ? Text(AppLocalizations.of(context)!.addVendor.split(' ')[0]) : Text(AppLocalizations.of(context)!.addProduct),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                // Search Bar
                DashboardSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    _fetchProducts(search: value);
                  },
                  onClear: () {
                    _fetchProducts();
                  },
                ),
                const SizedBox(height: 24),

                // Products List
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _products.isEmpty
                          ? _buildEmptyState()
                          : ListView.separated(
                              itemCount: _products.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final product = _products[index];
                                return _buildProductCard(product);
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
            ),
            child: const Icon(LucideIcons.package, size: 48, color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.noProductsFound,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.noProductsDescription,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(dynamic product) {
    final bool isActive = product['isActive'] ?? true;
    final double price = double.tryParse(product['basePrice']?.toString() ?? '') ?? 0.0;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: product['imageUrl'] != null
                    ? CachedNetworkImage(
                        imageUrl: ImageUtils.formatImageUrl(product['imageUrl']),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          LucideIcons.image,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                      )
                    : const Icon(LucideIcons.package, color: AppColors.primary, size: 24),
              ),
            ),
            title: Text(
              product['name'] ?? AppLocalizations.of(context)!.unnamedProduct,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold),
                    ),
                    if (product['sellByStrip'] == true && product['stripsPerPackage'] != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${(price / (product['stripsPerPackage'] as int)).toStringAsFixed(2)} / ${AppLocalizations.of(context)!.sellByStrip}',
                          style: const TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isActive ? AppLocalizations.of(context)!.activeStatus : AppLocalizations.of(context)!.inactiveStatus,
                        style: TextStyle(
                          color: isActive ? AppColors.success : AppColors.error,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (product['stock'] != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '${AppLocalizations.of(context)!.stock}: ${product['stock']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActionItem(
                  context: context,
                  icon: LucideIcons.edit3,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  label: AppLocalizations.of(context)!.edit,
                  onPressed: () => _showAddProductDialog(product: product),
                ),
                const SizedBox(width: 8),
                _buildActionItem(
                  context: context,
                  icon: LucideIcons.trash2,
                  color: AppColors.error,
                  label: AppLocalizations.of(context)!.delete,
                  onPressed: () => _confirmDelete(product),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog({dynamic product}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddProductDialog(
        vendorId: widget.vendorId,
        vendorName: widget.vendorName,
        product: product,
      ),
    );

    if (result != null && mounted) {
      bool success = false;
      String? productId;
      
      try {
        if (product != null) {
          success = await sl<VendorRepository>().updateProduct(widget.vendorId, product['id'], result);
          productId = product['id'];
        } else {
          productId = await sl<VendorRepository>().createProduct(result);
          success = productId != null;
        }
        
        if (success && productId != null && productId != 'success' && result['imageFile'] != null) {
          final imageFile = result['imageFile'] as XFile;
          final multipartFile = await dio.MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.name,
          );
          await sl<VendorRepository>().uploadProductImage(widget.vendorId, productId, multipartFile);
        }
        
        if (success) {
          _fetchProducts();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(ErrorUtils.translate(context, product != null ? 'common.success.resource_updated' : 'common.success.resource_created')),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(ErrorUtils.translate(context, e.toString())),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }

    }
  }

  void _confirmDelete(dynamic product) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.alertTriangle, color: AppColors.error, size: 48),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.deleteProduct,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context)!.deleteProductConfirm(product['name'] ?? AppLocalizations.of(context)!.unnamedProduct),
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: AppColors.textSecondary)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final success = await sl<VendorRepository>().deleteProduct(widget.vendorId, product['id']);
                          if (mounted) {
                            Navigator.pop(context);
                            if (success) {
                              _fetchProducts();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(ErrorUtils.translate(context, 'common.success.resource_deleted')),
                                  backgroundColor: AppColors.success,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(ErrorUtils.translate(context, e.toString())),
                                backgroundColor: AppColors.error,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(AppLocalizations.of(context)!.delete),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';
import 'package:otlob_admin/features/vendors/presentation/vendor_bloc.dart';
import 'package:otlob_admin/features/vendors/presentation/widgets/add_vendor_dialog.dart';
import 'package:otlob_admin/features/vendors/presentation/widgets/add_product_dialog.dart';
import 'package:otlob_admin/features/vendors/presentation/menu_categories_screen.dart';
import 'package:otlob_admin/features/vendors/presentation/branches_screen.dart';
import 'package:otlob_admin/features/vendors/presentation/products_screen.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/core/utils/error_utils.dart';
import 'package:otlob_admin/core/utils/image_utils.dart';
import 'package:otlob_admin/core/widgets/dashboard_search_bar.dart';


class VendorsScreen extends StatefulWidget {
  final String? userRole;
  final String? vendorRole;
  
  const VendorsScreen({
    super.key,
    this.userRole,
    this.vendorRole,
  });

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<VendorBloc, VendorState>(
                builder: (context, state) {
                  int total = state.total;
                  int active = state.vendors.where((v) => v['status'] == 'OPEN').length;
                  int pending = state.vendors.where((v) => v['status'] == 'PAUSED' || v['status'] == 'PENDING').length;

                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      StatCard(
                        title: AppLocalizations.of(context)!.vendors,
                        value: total.toString(),
                        icon: LucideIcons.store,
                        color: AppColors.primary,
                        isMobile: isMobile,
                      ),
                      StatCard(
                        title: AppLocalizations.of(context)!.active,
                        value: active.toString(),
                        icon: LucideIcons.checkCircle,
                        color: AppColors.success,
                        isMobile: isMobile,
                      ),
                      StatCard(
                        title: AppLocalizations.of(context)!.pending,
                        value: pending.toString(),
                        icon: LucideIcons.clock,
                        color: AppColors.warning,
                        isMobile: isMobile,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              
              // Search Bar
              DashboardSearchBar(
                controller: _searchController,
                onChanged: (value) {
                  context.read<VendorBloc>().add(FetchVendors(search: value));
                },
                onClear: () {
                  context.read<VendorBloc>().add(FetchVendors());
                },
              ),
              const SizedBox(height: 24),

              BlocListener<VendorBloc, VendorState>(
                listener: (context, state) {
                  if (state is VendorActionSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(ErrorUtils.translate(context, state.message)),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else if (state is VendorError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(ErrorUtils.translate(context, state.message)),
                        backgroundColor: AppColors.error,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.vendors,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.onBackground,
                              letterSpacing: -0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.userRole != 'VENDOR_MEMBER')
                          ElevatedButton.icon(
                            onPressed: () async {
                              final result = await showDialog<Map<String, dynamic>>(
                                context: context,
                                builder: (context) => const AddVendorDialog(),
                              );
                              if (result != null && context.mounted) {
                                context.read<VendorBloc>().add(CreateVendor(result));
                              }
                            },
                            icon: const Icon(LucideIcons.plus, size: 16),
                            label: Text(AppLocalizations.of(context)!.addVendor),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(120, 48),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<VendorBloc, VendorState>(
                      builder: (context, state) {
                          if (state is VendorLoading && state.vendors.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(40.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state.vendors.isNotEmpty) {
                            return _buildVendorTable(state.vendors, context, isMobile);
                          } else if (state is VendorError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(color: AppColors.error),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                  ],
                ),
              ),
            ],
          );
        },
    );
  }

  Widget _buildVendorTable(List<dynamic> vendors, BuildContext context, bool isMobile) {
    if (vendors.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const Icon(LucideIcons.store, size: 48, color: AppColors.textMuted),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context)!.noVendorsFound, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vendors.length,
      separatorBuilder: (context, index) => const SizedBox(height: 0),
      itemBuilder: (context, index) {
        final v = vendors[index];
        final isArabic = Localizations.localeOf(context).languageCode == 'ar';
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: isArabic ? TextDirection.ltr : TextDirection.rtl,
                children: [
                  _buildVendorThumbnail(v),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (v['isContracted'] == true) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.primary,
                                  Color(0xFFE5A93B),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  LucideIcons.shieldCheck,
                                  size: 10,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isArabic ? 'شريك متعاقد' : 'Contracted Partner',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        Text(
                          isArabic
                              ? (v['storeNameAr']?.toString().isNotEmpty == true ? v['storeNameAr'] : v['storeName']) ?? AppLocalizations.of(context)!.unnamedStore
                              : v['storeName'] ?? AppLocalizations.of(context)!.unnamedStore,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          isArabic
                              ? (v['vertical']?['nameAr']?.toString().isNotEmpty == true ? v['vertical']['nameAr'] : v['vertical']?['name']) ?? AppLocalizations.of(context)!.restaurant
                              : v['vertical']?['name'] ?? AppLocalizations.of(context)!.restaurant,
                          style: TextStyle(color: AppColors.textSecondary.withOpacity(0.7), fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: (widget.userRole == 'VENDOR_MEMBER' && widget.vendorRole == 'STAFF') 
                              ? null 
                              : () => _confirmStatusChange(context, v),
                          borderRadius: BorderRadius.circular(8),
                          child: _buildStatusChip(context, v['status'] ?? 'CLOSED'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Colors.white12),
              const SizedBox(height: 16),
              _buildActions(context, v),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActions(BuildContext context, dynamic v) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.start,
      children: [
          _buildActionItem(
            context: context,
            icon: LucideIcons.mapPin,
            color: AppColors.success,
            label: AppLocalizations.of(context)!.branches,
            onPressed: () => _viewBranches(context, v),
          ),
          _buildActionItem(
            context: context,
            icon: LucideIcons.list,
            color: AppColors.primary,
            label: AppLocalizations.of(context)!.menuCategories,
            onPressed: () => _viewMenuCategories(context, v),
          ),
          _buildActionItem(
            context: context,
            icon: LucideIcons.package,
            color: AppColors.primary,
            label: AppLocalizations.of(context)!.products,
            onPressed: () => _viewProducts(context, v),
          ),
          if (widget.userRole != 'VENDOR_MEMBER' || (widget.vendorRole == 'OWNER' || widget.vendorRole == 'MANAGER'))
            _buildActionItem(
              context: context,
              icon: LucideIcons.edit3,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              label: AppLocalizations.of(context)!.editVendor,
              onPressed: () => _showEditVendorDialog(context, v),
            ),
          if (widget.userRole != 'VENDOR_MEMBER' || widget.vendorRole == 'OWNER')
            _buildActionItem(
              context: context,
              icon: LucideIcons.trash2,
              color: AppColors.error,
              label: AppLocalizations.of(context)!.deleteVendor,
              onPressed: () => _confirmDelete(context, v),
            ),
          _buildActionItem(
            context: context,
            icon: LucideIcons.phone,
            color: Colors.blue,
            label: AppLocalizations.of(context)!.call,
            onPressed: () => _callVendor(v),
          ),
        ],
      );
    }

  Widget _buildVendorThumbnail(dynamic v) {
    final imageUrl = ImageUtils.formatImageUrl(v['coverImage'] ?? v['image']);
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary.withOpacity(0.05),
        border: Border.all(color: Colors.white12),
      ),
      child: imageUrl.isNotEmpty && imageUrl.startsWith('http')
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(LucideIcons.image, color: AppColors.primary, size: 30),
            ),
          )
        : const Icon(LucideIcons.image, color: AppColors.primary, size: 30),
    );
  }

  void _callVendor(dynamic v) async {
    // Try to find a phone number in branches if not on vendor
    String? phone = v['phone'];
    if (phone == null && v['branches'] != null && (v['branches'] as List).isNotEmpty) {
      phone = v['branches'][0]['phone'];
    }
    
    if (phone != null && phone.isNotEmpty) {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phone,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    }
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
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildStatusChip(BuildContext context, String status) {
    Color color;
    final l10n = AppLocalizations.of(context)!;

    switch (status) {
      case 'OPEN':
        color = AppColors.success;
        break;
      case 'CLOSED':
        color = AppColors.error;
        break;
      case 'PAUSED':
        color = AppColors.warning;
        break;
      case 'SUSPENDED':
        color = AppColors.textMuted;
        break;
      default:
        color = AppColors.textMuted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        _translateStatus(context, status),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String _translateStatus(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case 'OPEN':
        return l10n.open;
      case 'CLOSED':
        return l10n.closed;
      case 'PAUSED':
        return l10n.paused;
      case 'SUSPENDED':
        return l10n.suspended;
      default:
        return status;
    }
  }
  void _viewProducts(BuildContext context, dynamic v) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsScreen(
          vendorId: v['id'] ?? '',
          vendorName: v['storeName'] ?? 'Vendor',
          vendorType: (v['vertical']?['slug'] ?? v['type'])?.toString(),
        ),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context, dynamic v) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddProductDialog(
        vendorId: v['id'] ?? '',
        vendorName: v['storeName'] ?? 'Vendor',
        vendorType: (v['vertical']?['slug'] ?? v['type'])?.toString(),
      ),
    );
    if (result != null && context.mounted) {
      context.read<VendorBloc>().add(CreateProduct(result));
    }
  }

  void _showEditVendorDialog(BuildContext context, dynamic v) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddVendorDialog(vendor: v, userRole: widget.userRole),
    );
    if (result != null && context.mounted) {
      context.read<VendorBloc>().add(UpdateVendor(v['id'], result));
    }
  }

  void _confirmDelete(BuildContext context, dynamic v) {
    final bloc = context.read<VendorBloc>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(AppLocalizations.of(context)!.deleteConfirmTitle),
        content: Text(AppLocalizations.of(context)!.deleteConfirmContent(v['storeName'] ?? '')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(DeleteVendor(v['id']));
            },
            child: Text(AppLocalizations.of(context)!.delete, style: const TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _confirmStatusChange(BuildContext context, dynamic v) {
    final bloc = context.read<VendorBloc>();
    final currentStatus = v['status'] ?? 'CLOSED';
    final List<String> statuses = ['OPEN', 'CLOSED', 'PAUSED', 'SUSPENDED'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(AppLocalizations.of(context)!.changeStatusTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: statuses.map((status) {
            final isSelected = status == currentStatus;
            return ListTile(
              title: Text(_translateStatus(context, status)),
              trailing: isSelected ? const Icon(LucideIcons.check, color: AppColors.success) : null,
              onTap: () {
                Navigator.pop(context);
                if (!isSelected) {
                  bloc.add(UpdateVendorStatus(v['id'], status));
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _viewMenuCategories(BuildContext context, dynamic v) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuCategoriesScreen(
          vendorId: v['id'] ?? '',
          vendorName: v['storeName'] ?? 'Vendor',
        ),
      ),
    );
  }
  void _viewBranches(BuildContext context, dynamic v) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BranchesScreen(
          vendorId: v['id'] ?? '',
          vendorName: v['storeName'] ?? 'Vendor',
        ),
      ),
    );
  }
}

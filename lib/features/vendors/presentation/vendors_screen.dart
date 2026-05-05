import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';
import 'package:otlob_admin/features/vendors/presentation/vendor_bloc.dart';
import 'package:otlob_admin/features/vendors/presentation/widgets/add_vendor_dialog.dart';
import 'package:otlob_admin/features/vendors/presentation/widgets/add_product_dialog.dart';
import 'package:otlob_admin/features/vendors/presentation/menu_categories_screen.dart';
import 'package:otlob_admin/features/vendors/presentation/branches_screen.dart';
import 'package:otlob_admin/features/vendors/presentation/products_screen.dart';
import 'package:otlob_admin/injection_container.dart';

class VendorsScreen extends StatelessWidget {
  const VendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<VendorBloc>()..add(FetchVendors()),
      child: LayoutBuilder(
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
                        title: 'Vendors',
                        value: total.toString(),
                        icon: LucideIcons.store,
                        color: AppColors.primary,
                        isMobile: isMobile,
                      ),
                      StatCard(
                        title: 'Active',
                        value: active.toString(),
                        icon: LucideIcons.checkCircle,
                        color: AppColors.success,
                        isMobile: isMobile,
                      ),
                      StatCard(
                        title: 'Pending',
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
              BlocListener<VendorBloc, VendorState>(
                listener: (context, state) {
                  if (state is VendorActionSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else if (state is VendorError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
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
                        const Expanded(
                          child: Text(
                            'Vendors',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                          label: const Text('Add Vendor'),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: BlocBuilder<VendorBloc, VendorState>(
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
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVendorTable(List<dynamic> vendors, BuildContext context, bool isMobile) {
    if (vendors.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: [
              Icon(LucideIcons.store, size: 48, color: AppColors.textMuted),
              SizedBox(height: 16),
              Text('No vendors found', style: TextStyle(color: AppColors.textSecondary)),
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
      separatorBuilder: (context, index) => Divider(color: Colors.white.withOpacity(0.05), height: 1),
      itemBuilder: (context, index) {
        final v = vendors[index];
        if (isMobile) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(LucideIcons.store, color: AppColors.primary, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            v['storeName'] ?? 'Unnamed Store',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            v['vertical']?['name'] ?? 'No category',
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 12,
                children: [
                  InkWell(
                    onTap: () => _confirmStatusChange(context, v),
                    borderRadius: BorderRadius.circular(8),
                    child: _buildStatusChip(v['status'] ?? 'CLOSED'),
                  ),
                  _buildActions(context, v),
                ],
              ),
              ],
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(LucideIcons.store, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          v['storeName'] ?? 'Unnamed Store',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          v['vertical']?['name'] ?? 'Restaurant',
                          style: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.7),
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => _confirmStatusChange(context, v),
                    borderRadius: BorderRadius.circular(8),
                    child: _buildStatusChip(v['status'] ?? 'CLOSED'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.white.withOpacity(0.05), height: 1),
              const SizedBox(height: 12),
              _buildActions(context, v),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActions(BuildContext context, dynamic v) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildIconButton(
          icon: LucideIcons.mapPin,
          color: AppColors.success,
          tooltip: 'Branches',
          onPressed: () => _viewBranches(context, v),
        ),
        _buildIconButton(
          icon: LucideIcons.list,
          color: AppColors.primary,
          tooltip: 'Menu Categories',
          onPressed: () => _viewMenuCategories(context, v),
        ),
        _buildIconButton(
          icon: LucideIcons.package,
          color: AppColors.primary,
          tooltip: 'Products',
          onPressed: () => _viewProducts(context, v),
        ),
        _buildIconButton(
          icon: LucideIcons.edit3,
          color: AppColors.textSecondary,
          tooltip: 'Edit Vendor',
          onPressed: () => _showEditVendorDialog(context, v),
        ),
        _buildIconButton(
          icon: LucideIcons.trash2,
          color: AppColors.error,
          tooltip: 'Delete Vendor',
          onPressed: () => _confirmDelete(context, v),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
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
      default:
        color = AppColors.textMuted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _viewProducts(BuildContext context, dynamic v) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsScreen(
          vendorId: v['id'] ?? '',
          vendorName: v['storeName'] ?? 'Vendor',
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
      ),
    );
    if (result != null && context.mounted) {
      context.read<VendorBloc>().add(CreateProduct(result));
    }
  }

  void _showEditVendorDialog(BuildContext context, dynamic v) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddVendorDialog(vendor: v),
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
        backgroundColor: AppColors.surface,
        title: const Text('Delete Vendor'),
        content: Text('Are you sure you want to delete "${v['storeName']}"? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(DeleteVendor(v['id']));
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
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
        backgroundColor: AppColors.surface,
        title: const Text('Change Vendor Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: statuses.map((status) {
            final isSelected = status == currentStatus;
            return ListTile(
              title: Text(status),
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

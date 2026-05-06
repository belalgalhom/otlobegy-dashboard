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
import 'package:otlob_admin/generated/l10n/app_localizations.dart';

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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
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
      separatorBuilder: (context, index) => Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05), height: 1),
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
                            v['storeName'] ?? AppLocalizations.of(context)!.unnamedStore,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            v['vertical']?['name'] ?? AppLocalizations.of(context)!.noCategory,
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 12),
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
                    child: _buildStatusChip(context, v['status'] ?? 'CLOSED'),
                  ),
                  _buildActions(context, v),
                ],
              ),
              ],
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8), // Reduced from 10
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(LucideIcons.store, color: AppColors.primary, size: 18), // Reduced from 20
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          v['storeName'] ?? AppLocalizations.of(context)!.unnamedStore,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14, // Reduced from 16
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          v['vertical']?['name'] ?? AppLocalizations.of(context)!.restaurant,
                          style: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.7),
                            fontSize: 11, // Reduced from 13
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
                    child: _buildStatusChip(context, v['status'] ?? 'CLOSED'),
                  ),
                ],
              ),
              const SizedBox(height: 12), // Reduced from 16
              Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05), height: 1),
              const SizedBox(height: 8), // Reduced from 12
              _buildActions(context, v),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActions(BuildContext context, dynamic v) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildActionItem(
            context: context,
            icon: LucideIcons.mapPin,
            color: AppColors.success,
            label: AppLocalizations.of(context)!.branches,
            onPressed: () => _viewBranches(context, v),
          ),
          const SizedBox(width: 12),
          _buildActionItem(
            context: context,
            icon: LucideIcons.list,
            color: AppColors.primary,
            label: AppLocalizations.of(context)!.menuCategories,
            onPressed: () => _viewMenuCategories(context, v),
          ),
          const SizedBox(width: 12),
          _buildActionItem(
            context: context,
            icon: LucideIcons.package,
            color: AppColors.primary,
            label: AppLocalizations.of(context)!.products,
            onPressed: () => _viewProducts(context, v),
          ),
          const SizedBox(width: 12),
          _buildActionItem(
            context: context,
            icon: LucideIcons.edit3,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            label: AppLocalizations.of(context)!.editVendor,
            onPressed: () => _showEditVendorDialog(context, v),
          ),
          const SizedBox(width: 12),
          _buildActionItem(
            context: context,
            icon: LucideIcons.trash2,
            color: AppColors.error,
            label: AppLocalizations.of(context)!.deleteVendor,
            onPressed: () => _confirmDelete(context, v),
          ),
        ],
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
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8), // Reduced from 10
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color), // Reduced from 18
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9, // Reduced from 10
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
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
        backgroundColor: AppColors.surface,
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

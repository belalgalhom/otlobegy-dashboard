import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/presentation/vertical_bloc.dart';
import 'package:otlob_admin/features/vendors/presentation/widgets/add_vertical_dialog.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';

class VerticalsScreen extends StatefulWidget {
  const VerticalsScreen({super.key});

  @override
  State<VerticalsScreen> createState() => _VerticalsScreenState();
}

class _VerticalsScreenState extends State<VerticalsScreen> {
  int _currentPage = 0;
  final int _pageSize = 10;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerticalBloc, VerticalState>(
      listener: (context, state) {
        if (state is VerticalActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.success),
          );
        } else if (state is VerticalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.businessTypes,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    AppLocalizations.of(context)!.manageVerticalsDescription,
                    style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddVerticalDialog(context),
                icon: const Icon(LucideIcons.plus, size: 18),
                label: Text(AppLocalizations.of(context)!.addBusinessType),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  minimumSize: const Size(120, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildVerticalsTable(context),
        ],
      ),
    );
  }

  Widget _buildVerticalsTable(BuildContext context) {
    return BlocBuilder<VerticalBloc, VerticalState>(
      builder: (context, state) {
        if (state is VerticalLoading) {
          return const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is VerticalsLoaded) {
          if (state.verticals.isEmpty) {
            return _buildEmptyState();
          }

          final totalItems = state.verticals.length;
          final totalPages = (totalItems / _pageSize).ceil();
          
          // Ensure current page is valid after deletions
          if (_currentPage >= totalPages && totalPages > 0) {
            _currentPage = totalPages - 1;
          }

          final startIndex = _currentPage * _pageSize;
          final endIndex = (startIndex + _pageSize) > totalItems ? totalItems : (startIndex + _pageSize);
          final pagedItems = state.verticals.sublist(startIndex, endIndex);

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pagedItems.length,
                  separatorBuilder: (context, index) => Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05), height: 1),
                  itemBuilder: (context, index) {
                    final v = pagedItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: v['iconUrl'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: _buildImage(v['iconUrl']),
                                  )
                                : const Icon(LucideIcons.layers, color: AppColors.primary, size: 16),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  v['name'] ?? 'N/A',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                if (v['nameAr'] != null)
                                  Text(
                                    v['nameAr'],
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 12),
                                  ),
                              ],
                            ),
                          ),
                          _buildStatusBadge(v['isActive'] ?? true),
                          const SizedBox(width: 8),
                          const SizedBox(width: 12),
                          _buildActionItem(
                            context: context,
                            icon: LucideIcons.edit3,
                            color: AppColors.primary,
                            label: AppLocalizations.of(context)!.edit,
                            onPressed: () => _showEditVerticalDialog(context, v),
                          ),
                          const SizedBox(width: 8),
                          _buildActionItem(
                            context: context,
                            icon: LucideIcons.trash2,
                            color: Colors.redAccent,
                            label: AppLocalizations.of(context)!.delete,
                            onPressed: () => _confirmDelete(context, v),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (totalPages > 1) ...[
                const SizedBox(height: 24),
                _buildPagination(totalPages),
              ],
            ],
          );
        }

        return const Padding(
          padding: EdgeInsets.all(40),
          child: Center(child: Text('No data available')),
        );
      },
    );
  }

  Widget _buildPagination(int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isSelected = _currentPage == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            onTap: () => setState(() => _currentPage = index),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
              ),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isActive ? AppColors.success : AppColors.textMuted).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isActive ? AppLocalizations.of(context)!.activeStatus : AppLocalizations.of(context)!.inactiveStatus,
        style: TextStyle(
          color: isActive ? AppColors.success : AppColors.textMuted,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(60),
      child: Center(
        child: Column(
          children: [
            const Icon(LucideIcons.layers, size: 48, color: AppColors.textMuted),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.noBusinessTypesFound, style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
          ],
        ),
      ),
    );
  }

  void _showAddVerticalDialog(BuildContext context) {
    final bloc = context.read<VerticalBloc>();
    showDialog(
      context: context,
      builder: (context) => const AddVerticalDialog(),
    ).then((result) {
      if (result != null) {
        bloc.add(CreateVertical(result));
      }
    });
  }

  void _showEditVerticalDialog(BuildContext context, dynamic vertical) {
    final bloc = context.read<VerticalBloc>();
    showDialog(
      context: context,
      builder: (context) => AddVerticalDialog(vertical: vertical),
    ).then((result) {
      if (result != null) {
        bloc.add(UpdateVertical(vertical['id'], result));
      }
    });
  }

  void _confirmDelete(BuildContext context, dynamic vertical) {
    final bloc = context.read<VerticalBloc>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(AppLocalizations.of(context)!.deleteBusinessType),
        content: Text(AppLocalizations.of(context)!.deleteBusinessTypeConfirm(vertical['name'] ?? AppLocalizations.of(context)!.unknown)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)!.cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(DeleteVertical(vertical['id']));
            },
            child: Text(AppLocalizations.of(context)!.delete, style: const TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    if (url.isEmpty) {
      return const Icon(LucideIcons.layers, color: AppColors.primary, size: 16);
    }
    
    if (url.startsWith('file://') || url.startsWith('/data/user/') || url.startsWith('/storage/')) {
      final path = url.replaceFirst('file://', '');
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(LucideIcons.layers, color: AppColors.primary, size: 16),
      );
    }

    // Prepend base URL for relative media paths from the server
    final fullUrl = url.startsWith('/media/') 
        ? 'https://api.otlob-egy.online$url' 
        : url;

    return Image.network(
      fullUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => const Icon(LucideIcons.layers, color: AppColors.primary, size: 16),
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
}

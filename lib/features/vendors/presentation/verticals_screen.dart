import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/vendors/presentation/vertical_bloc.dart';
import 'package:otlob_admin/features/vendors/presentation/widgets/add_vertical_dialog.dart';

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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Types',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  Text(
                    'Manage vertical categories for vendors',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddVerticalDialog(context),
                icon: const Icon(LucideIcons.plus, size: 18),
                label: const Text('Add Business Type'),
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
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pagedItems.length,
                  separatorBuilder: (context, index) => Divider(color: Colors.white.withOpacity(0.05), height: 1),
                  itemBuilder: (context, index) {
                    final v = pagedItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(LucideIcons.layers, color: AppColors.primary, size: 18),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  v['name'] ?? 'N/A',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                if (v['nameAr'] != null)
                                  Text(
                                    v['nameAr'],
                                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                  ),
                              ],
                            ),
                          ),
                          _buildStatusBadge(v['isActive'] ?? true),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(LucideIcons.edit3, size: 18, color: AppColors.primary),
                            onPressed: () => _showEditVerticalDialog(context, v),
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.primary.withOpacity(0.1),
                              padding: const EdgeInsets.all(8),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(LucideIcons.trash2, size: 18, color: Colors.redAccent),
                            onPressed: () => _confirmDelete(context, v),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(0.1),
                              padding: const EdgeInsets.all(8),
                            ),
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
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.1)),
              ),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
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
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: isActive ? AppColors.success : AppColors.textMuted,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.all(60),
      child: Center(
        child: Column(
          children: [
            Icon(LucideIcons.layers, size: 48, color: AppColors.textMuted),
            SizedBox(height: 16),
            Text('No business types found', style: TextStyle(color: AppColors.textSecondary)),
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
        title: const Text('Delete Business Type'),
        content: Text('Are you sure you want to delete "${vertical['name']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(DeleteVertical(vertical['id']));
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

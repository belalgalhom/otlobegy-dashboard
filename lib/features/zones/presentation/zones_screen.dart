import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';
import 'package:otlob_admin/features/zones/presentation/zone_bloc.dart';
import 'package:otlob_admin/injection_container.dart';

class ZonesScreen extends StatelessWidget {
  const ZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ZoneBloc>()..add(FetchZones()),
      child: BlocListener<ZoneBloc, ZoneState>(
        listener: (context, state) {
          if (state is ZoneOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.success),
            );
          } else if (state is ZoneError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Section
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    StatCard(
                      title: 'Active Zones',
                      value: '0',
                      icon: LucideIcons.map,
                      color: AppColors.primary,
                      isMobile: isMobile,
                    ),
                    StatCard(
                      title: 'Busy Zones',
                      value: '0',
                      icon: LucideIcons.activity,
                      color: AppColors.warning,
                      isMobile: isMobile,
                    ),
                    StatCard(
                      title: 'Deliveries',
                      value: '0',
                      icon: LucideIcons.navigation,
                      color: AppColors.success,
                      isMobile: isMobile,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Management Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Delivery Zones',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(LucideIcons.plus, size: 14),
                            label: const Text('Add Zone'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 44),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<ZoneBloc, ZoneState>(
                        builder: (context, state) {
                          if (state is ZoneLoading) {
                            return const Center(child: Padding(
                              padding: EdgeInsets.all(40.0),
                              child: CircularProgressIndicator(),
                            ));
                          } else if (state is ZonesLoaded) {
                            return _buildZonesTable(state.zones, context);
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
        ),
      ),
    );
  }

  Widget _buildZonesTable(List<dynamic> zones, BuildContext context) {
    if (zones.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Icon(LucideIcons.mapPin, size: 48, color: AppColors.textMuted),
            const SizedBox(height: 12),
            const Text('No zones defined yet.', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            TextButton(onPressed: () {}, child: const Text('Add Zone', style: TextStyle(fontSize: 13))),
          ],
        ),
      );
    }
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 320),
        child: DataTable(
          headingRowHeight: 48,
          dataRowMinHeight: 48,
          dataRowMaxHeight: 56,
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Points')),
            DataColumn(label: Text('Actions')),
          ],
          rows: zones.map((z) => DataRow(
            cells: [
              DataCell(Text(z['name'] ?? 'Unnamed', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
              DataCell(_buildStatusChip(z['isActive'] ?? true)),
              DataCell(Text('${(z['coordinates'] as List?)?.length ?? 0}', style: const TextStyle(fontSize: 13))),
              DataCell(Row(
                children: [
                  IconButton(icon: const Icon(LucideIcons.edit, size: 16), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                  const SizedBox(width: 8),
                  IconButton(icon: const Icon(LucideIcons.trash, size: 16, color: AppColors.error), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                ],
              )),
            ],
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isActive ? AppColors.success : AppColors.error).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? 'ACTIVE' : 'INACTIVE',
        style: TextStyle(
          color: isActive ? AppColors.success : AppColors.error,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

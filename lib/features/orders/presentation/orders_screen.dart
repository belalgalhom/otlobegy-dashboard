import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                StatCard(
                  title: 'New Orders',
                  value: '0',
                  icon: LucideIcons.bell,
                  color: AppColors.warning,
                  isMobile: isMobile,
                ),
                StatCard(
                  title: 'In Delivery',
                  value: '0',
                  icon: LucideIcons.truck,
                  color: AppColors.primary,
                  isMobile: isMobile,
                ),
                StatCard(
                  title: 'Cancelled',
                  value: '0',
                  icon: LucideIcons.xCircle,
                  color: AppColors.error,
                  isMobile: isMobile,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.packageSearch, size: 56, color: AppColors.textMuted),
                  SizedBox(height: 20),
                  Text(
                    'No Orders Found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The Orders API is currently not connected.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

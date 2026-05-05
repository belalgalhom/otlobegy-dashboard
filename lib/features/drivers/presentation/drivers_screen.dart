import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';

class DriversScreen extends StatelessWidget {
  const DriversScreen({super.key});

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
                  title: 'Total Drivers',
                  value: '0',
                  icon: LucideIcons.users,
                  color: AppColors.primary,
                  isMobile: isMobile,
                ),
                StatCard(
                  title: 'Active Now',
                  value: '0',
                  icon: LucideIcons.navigation,
                  color: AppColors.success,
                  isMobile: isMobile,
                ),
                StatCard(
                  title: 'Offline',
                  value: '0',
                  icon: LucideIcons.moon,
                  color: AppColors.textMuted,
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
                  Icon(LucideIcons.mapPin, size: 56, color: AppColors.textMuted),
                  SizedBox(height: 20),
                  Text(
                    'Driver Tracking Offline',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Wait for backend implementation of Driver GPS.',
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

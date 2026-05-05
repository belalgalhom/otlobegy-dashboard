import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

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
                  title: 'Open Tickets',
                  value: '0',
                  icon: LucideIcons.inbox,
                  color: AppColors.error,
                  isMobile: isMobile,
                ),
                StatCard(
                  title: 'In Progress',
                  value: '0',
                  icon: LucideIcons.clock,
                  color: AppColors.warning,
                  isMobile: isMobile,
                ),
                StatCard(
                  title: 'Resolved',
                  value: '0',
                  icon: LucideIcons.checkCircle,
                  color: AppColors.success,
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
                  Icon(LucideIcons.ticket, size: 56, color: AppColors.textMuted),
                  SizedBox(height: 20),
                  const Text(
                    'No Support Tickets',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 8),
                  const Text(
                    'All customer inquiries have been resolved.',
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

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/core/widgets/stat_card.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';

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
                  title: AppLocalizations.of(context)!.openTickets,
                  value: '0',
                  icon: LucideIcons.inbox,
                  color: AppColors.error,
                  isMobile: isMobile,
                ),
                StatCard(
                  title: AppLocalizations.of(context)!.inProgress,
                  value: '0',
                  icon: LucideIcons.clock,
                  color: AppColors.warning,
                  isMobile: isMobile,
                ),
                StatCard(
                  title: AppLocalizations.of(context)!.resolved,
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
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.ticket, size: 56, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
                  SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.noSupportTickets,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.allInquiriesResolved,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 13),
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

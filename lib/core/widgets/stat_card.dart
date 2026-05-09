import 'package:flutter/material.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isMobile;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isMobile = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine dynamic width based on device
    final double cardWidth = isMobile 
        ? (MediaQuery.of(context).size.width - 64) / 2 - 8 
        : 150.0; // Reduced from 180

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(12), // Reduced from 16
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16), // Slightly smaller radius
          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6), // Reduced from 8
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 16), // Reduced from 18
            ),
            const SizedBox(height: 12), // Reduced from 16
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 11, // Reduced from 12
                  fontWeight: FontWeight.w500,
                ),
              ),
  
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18, // Reduced from 20
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

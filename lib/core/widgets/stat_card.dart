import 'package:flutter/material.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isMobile;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine dynamic width based on device
    final double cardWidth = isMobile 
        ? (MediaQuery.of(context).size.width - 64) / 2 - 8 
        : 180.0; // Reduced from 240

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(16), // Reduced from 24
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20), // Slightly smaller radius
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
            padding: const EdgeInsets.all(8), // Reduced from 12
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 18), // Reduced from 22
          ),
          const SizedBox(height: 16), // Reduced from 24
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: 12, // Reduced from 14
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20, // Reduced from 26
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

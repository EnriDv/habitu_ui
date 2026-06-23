import 'package:flutter/material.dart';

import '../../tokens/habitu_colors.dart';

class EmptyStateCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const EmptyStateCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: HabituColors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: HabituColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

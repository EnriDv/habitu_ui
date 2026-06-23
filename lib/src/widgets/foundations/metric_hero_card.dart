import 'package:flutter/material.dart';

import '../../tokens/habitu_colors.dart';

class MetricHeroCard extends StatelessWidget {
  final String eyebrow;
  final String value;
  final String description;

  const MetricHeroCard({
    super.key,
    required this.eyebrow,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HabituColors.primary.withOpacity(0.18),
            HabituColors.surfaceContainerHighest.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow,
            style: const TextStyle(
              color: HabituColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: HabituColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

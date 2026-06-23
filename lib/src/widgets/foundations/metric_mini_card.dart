import 'package:flutter/material.dart';

import '../../tokens/habitu_colors.dart';

class MetricMiniCard extends StatelessWidget {
  final String label;
  final String value;
  final String caption;

  const MetricMiniCard({
    super.key,
    required this.label,
    required this.value,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: HabituColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: HabituColors.onSurfaceVariant)),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            style: const TextStyle(fontSize: 12, color: HabituColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

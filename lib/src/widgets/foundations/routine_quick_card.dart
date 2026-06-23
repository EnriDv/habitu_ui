import 'package:flutter/material.dart';

import '../../models/routine_quick_card_view_model.dart';
import '../../tokens/habitu_colors.dart';

class RoutineQuickCard extends StatelessWidget {
  final RoutineQuickCardViewModel routine;
  final VoidCallback? onTap;

  const RoutineQuickCard({
    super.key,
    required this.routine,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: HabituColors.surfaceContainer,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withOpacity(0.04)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              routine.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              (routine.description ?? '').isEmpty ? 'Sin descripción' : routine.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: HabituColors.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            LinearProgressIndicator(
              value: routine.completionRate,
              minHeight: 8,
              borderRadius: BorderRadius.circular(99),
              backgroundColor: Colors.white.withOpacity(0.05),
              color: HabituColors.primary,
            ),
            const SizedBox(height: 10),
            Text(
              '${routine.completedCount}/${routine.habitCount} completados',
              style: const TextStyle(
                fontSize: 12,
                color: HabituColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

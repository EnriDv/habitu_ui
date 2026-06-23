import 'package:flutter/material.dart';

import '../../tokens/habitu_colors.dart';

class SyncStatusCard extends StatelessWidget {
  final int pendingCount;

  const SyncStatusCard({
    super.key,
    required this.pendingCount,
  });

  @override
  Widget build(BuildContext context) {
    final isOffline = pendingCount > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isOffline
            ? HabituColors.accent.withOpacity(0.12)
            : HabituColors.tertiary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOffline
              ? HabituColors.accent.withOpacity(0.25)
              : HabituColors.tertiary.withOpacity(0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOffline ? Icons.cloud_off_outlined : Icons.cloud_done_outlined,
            size: 16,
            color: isOffline ? HabituColors.accent : HabituColors.tertiary,
          ),
          const SizedBox(width: 6),
          Text(
            isOffline ? 'Pendiente: $pendingCount' : 'Sincronizado',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isOffline ? HabituColors.accent : HabituColors.tertiary,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

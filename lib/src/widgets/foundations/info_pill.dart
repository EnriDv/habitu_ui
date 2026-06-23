import 'package:flutter/material.dart';

import '../../tokens/habitu_colors.dart';

class InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoPill({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: HabituColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: HabituColors.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: HabituColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

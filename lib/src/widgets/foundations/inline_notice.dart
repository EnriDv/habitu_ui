import 'package:flutter/material.dart';

import '../../tokens/habitu_colors.dart';

class InlineNotice extends StatelessWidget {
  final String text;

  const InlineNotice({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HabituColors.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: HabituColors.accent.withOpacity(0.16)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: HabituColors.onSurfaceVariant,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../tokens/habitu_colors.dart';

class AccessModeSwitch extends StatelessWidget {
  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int> onChanged;

  const AccessModeSwitch({
    super.key,
    required this.selectedIndex,
    required this.labels,
    required this.onChanged,
  }) : assert(labels.length >= 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: HabituColors.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final selected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selected
                      ? HabituColors.primary.withOpacity(0.16)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  labels[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected
                        ? HabituColors.primary
                        : HabituColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

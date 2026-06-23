import 'package:flutter/material.dart';
import '../tokens/habitu_colors.dart';
import '../tokens/habitu_typography.dart';

class HabituNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const HabituNavigationBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor = isDark ? HabituColors.surfaceContainerLowest : Colors.white;
    final Color selectedColor = HabituColors.primary;
    final Color unselectedColor = isDark ? HabituColors.onSurfaceVariant : const Color(0xFF606164);

    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: HabituTypography.labelSmall.copyWith(
        fontWeight: FontWeight.w600,
        color: selectedColor,
      ),
      unselectedLabelStyle: HabituTypography.labelSmall.copyWith(
        fontWeight: FontWeight.normal,
        color: unselectedColor,
      ),
    );
  }
}
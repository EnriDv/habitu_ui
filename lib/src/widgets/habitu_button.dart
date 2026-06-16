import 'package:flutter/material.dart';
import '../tokens/habitu_colors.dart';
import '../tokens/habitu_typography.dart';

enum HabituButtonType { elevated, outlined }

class HabituButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final HabituButtonType type;
  final IconData? icon;
  final bool fullWidth;

  const HabituButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = HabituButtonType.elevated,
    this.icon,
    this.fullWidth = false,
  });

  const HabituButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = false,
  }) : type = HabituButtonType.outlined;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textStyle = HabituTypography.labelLarge.copyWith(
      fontWeight: FontWeight.w600,
    );

    Widget buttonChild;
    if (icon != null) {
      buttonChild = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label),
        ],
      );
    } else {
      buttonChild = Text(label);
    }

    Widget button;

    switch (type) {
      case HabituButtonType.elevated:
        button = ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: HabituColors.primary,
            foregroundColor: HabituColors.onPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: const StadiumBorder(),
            textStyle: textStyle,
          ),
          child: buttonChild,
        );
        break;
      case HabituButtonType.outlined:
        button = OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: HabituColors.primary,
            side: BorderSide(
              color: isDark ? HabituColors.outlineVariant : const Color(0xFFC6C6CA),
              width: 1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: const StadiumBorder(),
            textStyle: textStyle,
          ),
          child: buttonChild,
        );
        break;
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}
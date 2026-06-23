import 'package:flutter/material.dart';
import '../tokens/habitu_colors.dart';

class HabituCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderSide? borderSide;
  final VoidCallback? onTap;
  final double borderRadius;

  const HabituCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderSide,
    this.onTap,
    this.borderRadius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final resolvedBorderSide = borderSide ?? BorderSide(
      color: isDark 
          ? HabituColors.outlineVariant.withOpacity(0.3) 
          : const Color(0xFFE5E5E3),
      width: 1.0,
    );

    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: resolvedBorderSide,
    );

    final resolvedColor = color ?? (isDark ? HabituColors.surfaceContainer : Colors.white);

    if (onTap != null) {
      return Card(
        color: resolvedColor,
        elevation: 0,
        margin: margin,
        shape: cardShape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      );
    }

    return Card(
      color: resolvedColor,
      elevation: 0,
      margin: margin,
      shape: cardShape,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../tokens/habitu_colors.dart';
import '../tokens/habitu_typography.dart';

class HabituTheme {
  HabituTheme._();

  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color background = isDark ? HabituColors.surface : const Color(0xFFF9F9F8); // Bone/Warm white
    final Color cardBg = isDark ? HabituColors.surfaceContainer : Colors.white;
    final Color textPrimary = isDark ? HabituColors.onSurface : const Color(0xFF1C1B1B);
    final Color textSecondary = isDark ? HabituColors.onSurfaceVariant : const Color(0xFF606164);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: HabituColors.primary,
        onPrimary: HabituColors.onPrimary,
        primaryContainer: HabituColors.primaryContainer,
        onPrimaryContainer: HabituColors.onPrimaryContainer,
        secondary: HabituColors.secondary,
        onSecondary: HabituColors.onSecondary,
        secondaryContainer: HabituColors.secondaryContainer,
        onSecondaryContainer: HabituColors.onSecondaryContainer,
        tertiary: HabituColors.tertiary,
        onTertiary: HabituColors.onTertiary,
        tertiaryContainer: HabituColors.tertiaryContainer,
        onTertiaryContainer: HabituColors.onTertiaryContainer,
        error: HabituColors.error,
        onError: HabituColors.onError,
        errorContainer: HabituColors.errorContainer,
        onErrorContainer: HabituColors.onErrorContainer,
        surface: isDark ? HabituColors.surface : const Color(0xFFF9F9F8),
        onSurface: textPrimary,
        outline: HabituColors.outline,
        outlineVariant: HabituColors.outlineVariant,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: HabituTypography.headlineMedium.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: isDark ? HabituColors.outlineVariant.withOpacity(0.3) : const Color(0xFFE5E5E3),
            width: 1.0,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HabituColors.primary,
          foregroundColor: HabituColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: const StadiumBorder(),
          textStyle: HabituTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: HabituColors.primary,
          side: BorderSide(color: isDark ? HabituColors.outlineVariant : const Color(0xFFC6C6CA), width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: const StadiumBorder(),
          textStyle: HabituTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? HabituColors.surfaceContainerLow : const Color(0xFFF0F0EE),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: HabituColors.primary, width: 1.5),
        ),
        hintStyle: HabituTypography.bodyMedium.copyWith(
          color: textSecondary.withOpacity(0.6),
        ),
        labelStyle: HabituTypography.bodyMedium.copyWith(
          color: textSecondary,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: HabituColors.primary,
        foregroundColor: HabituColors.onPrimary,
        elevation: 4,
        shape: CircleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? HabituColors.surfaceContainerLowest : Colors.white,
        selectedItemColor: HabituColors.primary,
        unselectedItemColor: textSecondary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: HabituTypography.labelSmall.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: HabituTypography.labelSmall,
      ),
      textTheme: TextTheme(
        displayLarge: HabituTypography.displayLarge.copyWith(color: textPrimary),
        headlineLarge: HabituTypography.headlineLarge.copyWith(color: textPrimary),
        headlineMedium: HabituTypography.headlineMedium.copyWith(color: textPrimary),
        bodyLarge: HabituTypography.bodyLarge.copyWith(color: textPrimary),
        bodyMedium: HabituTypography.bodyMedium.copyWith(color: textPrimary),
        labelLarge: HabituTypography.labelLarge.copyWith(color: textPrimary),
        labelSmall: HabituTypography.labelSmall.copyWith(color: textSecondary),
      ),
    );
  }
}
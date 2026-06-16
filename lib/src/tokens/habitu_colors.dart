import 'package:flutter/material.dart';

class HabituColors {
  HabituColors._(); // Private constructor to prevent instantiation

  // ==================== COLORES PRINCIPALES (Academic Ethereal) ====================
  static const Color surface = Color(0xFF121413);
  static const Color surfaceDim = Color(0xFF121413);
  static const Color surfaceBright = Color(0xFF383938);
  static const Color surfaceContainerLowest = Color(0xFF0D0E0E);
  static const Color surfaceContainerLow = Color(0xFF1A1C1B);
  static const Color surfaceContainer = Color(0xFF1E201F);
  static const Color surfaceContainerHigh = Color(0xFF292A29);
  static const Color surfaceContainerHighest = Color(0xFF343534);

  static const Color onSurface = Color(0xFFE3E2E0);
  static const Color onSurfaceVariant = Color(0xFFC3C6D1);
  static const Color inverseSurface = Color(0xFFE3E2E0);
  static const Color inverseOnSurface = Color(0xFF2F3130);

  static const Color outline = Color(0xFF8D919A);
  static const Color outlineVariant = Color(0xFF43474F);

  static const Color primary = Color(0xFFA7C8FF); // Pastel Blue
  static const Color onPrimary = Color(0xFF003061);
  static const Color primaryContainer = Color(0xFF003366);
  static const Color onPrimaryContainer = Color(0xFF799DD6);
  static const Color inversePrimary = Color(0xFF3A5F94);

  static const Color secondary = Color(0xFFC6C6CA); // Desaturated secondary
  static const Color onSecondary = Color(0xFF2F3034);
  static const Color secondaryContainer = Color(0xFF4A4B4F);
  static const Color onSecondaryContainer = Color(0xFFBBBBBF);

  static const Color tertiary = Color(0xFF96D3BD); // Desaturated Mint
  static const Color onTertiary = Color(0xFF00382B);
  static const Color tertiaryContainer = Color(0xFF003B2D);
  static const Color onTertiaryContainer = Color(0xFF6BA792);

  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  static const Color accent = Color(0xFFF59E0B); // Amber 500

  static const Color primaryFixed = Color(0xFFD5E3FF);
  static const Color primaryFixedDim = Color(0xFFA7C8FF);
  static const Color onPrimaryFixed = Color(0xFF001B3C);
  static const Color onPrimaryFixedVariant = Color(0xFF1F477B);

  static const Color secondaryFixed = Color(0xFFE2E2E6);
  static const Color secondaryFixedDim = Color(0xFFC6C6CA);
  static const Color onSecondaryFixed = Color(0xFF1A1C1F);
  static const Color onSecondaryFixedVariant = Color(0xFF45474A);

  static const Color tertiaryFixed = Color(0xFFB1EFD8);
  static const Color tertiaryFixedDim = Color(0xFF96D3BD);
  static const Color onTertiaryFixed = Color(0xFF002118);
  static const Color onTertiaryFixedVariant = Color(0xFF0D503F);

  // Paleta de colores para hábitos
  static const List<Color> habitColors = [
    Color(0xFFA7C8FF), // Pastel Blue (Estudio)
    Color(0xFF96D3BD), // Mint (Salud / Bienestar)
    Color(0xFFE2B2B2), // Pastel Red/Rose (Deporte)
    Color(0xFFE2D6B2), // Pastel Yellow/Sand (Sueño)
    Color(0xFFC6C6CA), // Slate (Rutina)
    Color(0xFFD0B2E2), // Lavender (Social)
  ];

  static const List<String> habitColorHexes = [
    '#A7C8FF',
    '#96D3BD',
    '#E2B2B2',
    '#E2D6B2',
    '#C6C6CA',
    '#D0B2E2',
  ];
}
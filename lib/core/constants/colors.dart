import 'package:flutter/material.dart';

/// App color constants following the FitSync design system
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryNavy = Color(0xFF1E1E2F);
  static const Color accentCoral = Color(0xFFFF6363);

  // Background Colors
  static const Color darkBackground = Color(0xFF0F0F1A);
  static const Color cardBackground = Color(0xFF252538);
  static const Color surfaceColor = Color(0xFF2A2A3E);

  // Text Colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB0B0C0);
  static const Color disabledText = Color(0xFF6B6B80);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFFF5252);
  static const Color info = Color(0xFF2196F3);

  // Accent Variations
  static const Color coralLight = Color(0xFFFF8A80);
  static const Color coralDark = Color(0xFFD32F2F);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Overlay Colors
  static const Color overlay10 = Color(0x1AFFFFFF);
  static const Color overlay20 = Color(0x33FFFFFF);
  static const Color overlay30 = Color(0x4DFFFFFF);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryNavy, surfaceColor],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentCoral, coralLight],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cardBackground, surfaceColor],
  );

  // Material Color Swatch for Primary Color
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF1E1E2F,
    <int, Color>{
      50: Color(0xFFE3E3E8),
      100: Color(0xFFBABAC5),
      200: Color(0xFF8C8C9F),
      300: Color(0xFF5E5E78),
      400: Color(0xFF3C3C5A),
      500: Color(0xFF1E1E2F),
      600: Color(0xFF1A1A2A),
      700: Color(0xFF161623),
      800: Color(0xFF12121D),
      900: Color(0xFF0A0A12),
    },
  );

  // Fashion Category Colors
  static const Map<String, Color> categoryColors = {
    'tops': Color(0xFF6C5CE7),
    'bottoms': Color(0xFF00B894),
    'dresses': Color(0xFFE17055),
    'outerwear': Color(0xFF0984E3),
    'footwear': Color(0xFFD63031),
    'accessories': Color(0xFDF0E0),
    'undergarments': Color(0xFF636E72),
  };

  // Fashion Archetype Colors
  static const Map<String, Color> archetypeColors = {
    'minimalist': Color(0xFF2D3436),
    'grunge': Color(0xFF636E72),
    'streetwear': Color(0xFFE17055),
    'oldMoney': Color(0xFF00B894),
    'bohemian': Color(0xFF6C5CE7),
    'classic': Color(0xFF0984E3),
    'avantGarde': Color(0xFFD63031),
    'casual': Color(0xFFDDD090),
  };
}

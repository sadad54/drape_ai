import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: AppColors.primarySwatch,
      primaryColor: AppColors.primaryNavy,
      scaffoldBackgroundColor: AppColors.darkBackground,
      cardColor: AppColors.cardBackground,
      dividerColor: AppColors.overlay20,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentCoral,
        secondary: AppColors.coralLight,
        surface: AppColors.cardBackground,
        background: AppColors.darkBackground,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.primaryText,
        onBackground: AppColors.primaryText,
        onError: AppColors.white,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryText,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primaryText,
          size: 24,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AppColors.cardBackground,
        elevation: 4,
        shadowColor: AppColors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.overlay10,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentCoral,
          foregroundColor: AppColors.white,
          elevation: 2,
          shadowColor: AppColors.accentCoral.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accentCoral,
          side: const BorderSide(
            color: AppColors.accentCoral,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accentCoral,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.overlay10.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.overlay20,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.overlay20,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.accentCoral,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        labelStyle: GoogleFonts.dmSans(
          color: AppColors.secondaryText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.dmSans(
          color: AppColors.disabledText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: GoogleFonts.dmSans(
          color: AppColors.error,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBackground,
        selectedItemColor: AppColors.accentCoral,
        unselectedItemColor: AppColors.secondaryText,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentCoral,
        foregroundColor: AppColors.white,
        elevation: 6,
        highlightElevation: 12,
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.accentCoral,
        unselectedLabelColor: AppColors.secondaryText,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.accentCoral,
            width: 2,
          ),
        ),
        labelStyle: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.cardBackground,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: GoogleFonts.dmSans(
          color: AppColors.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: GoogleFonts.dmSans(
          color: AppColors.secondaryText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.overlay10,
        selectedColor: AppColors.accentCoral,
        disabledColor: AppColors.disabledText,
        labelStyle: GoogleFonts.dmSans(
          color: AppColors.primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: GoogleFonts.dmSans(
          color: AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.accentCoral;
          }
          return AppColors.secondaryText;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.accentCoral.withOpacity(0.5);
          }
          return AppColors.overlay20;
        }),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accentCoral,
        linearTrackColor: AppColors.overlay20,
        circularTrackColor: AppColors.overlay20,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.overlay20,
        thickness: 1,
        space: 1,
      ),

      // Text Theme
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        // Display
        displayLarge: GoogleFonts.dmSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ),
        displayMedium: GoogleFonts.dmSans(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ),
        displaySmall: GoogleFonts.dmSans(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ),

        // Headline
        headlineLarge: GoogleFonts.dmSans(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryText,
        ),
        headlineMedium: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryText,
        ),
        headlineSmall: GoogleFonts.dmSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryText,
        ),

        // Title
        titleLarge: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
        titleMedium: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
        titleSmall: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),

        // Body
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryText,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryText,
        ),
        bodySmall: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryText,
        ),

        // Label
        labelLarge: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
        labelMedium: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
        labelSmall: GoogleFonts.dmSans(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primaryText,
        size: 24,
      ),

      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: AppColors.accentCoral,
        size: 24,
      ),
    );
  }

  static ThemeData get lightTheme {
    // Light theme implementation for future use
    return darkTheme.copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      cardColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentCoral,
        secondary: AppColors.primaryNavy,
        surface: AppColors.white,
        background: AppColors.white,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.primaryNavy,
        onBackground: AppColors.primaryNavy,
        onError: AppColors.white,
      ),
    );
  }
}

/// Custom text styles for specific use cases
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get onboardingTitle => GoogleFonts.dmSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
      );

  static TextStyle get cardTitle => GoogleFonts.dmSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      );

  static TextStyle get buttonText => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.disabledText,
      );

  static TextStyle get chipLabel => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryText,
      );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkOnPrimary,
        secondary: AppColors.darkSecondary,
        onSecondary: AppColors.darkOnSecondary,
        error: AppColors.darkError,
        onError: AppColors.darkOnError,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
        surfaceContainerHighest: AppColors.darkSurfaceVariant,
        onSurfaceVariant: AppColors.darkOnSurfaceVariant,
        outline: AppColors.darkOutline,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _buildTextTheme(
        ThemeData.dark().textTheme,
        AppColors.darkOnSurface,
        AppColors.darkOnSurfaceVariant,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.lightPrimary,
        onPrimary: AppColors.lightOnPrimary,
        secondary: AppColors.lightSecondary,
        onSecondary: AppColors.lightOnSecondary,
        error: AppColors.lightError,
        onError: AppColors.lightOnError,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
        surfaceContainerHighest: AppColors.lightSurfaceVariant,
        onSurfaceVariant: AppColors.lightOnSurfaceVariant,
        outline: AppColors.lightOutline,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: _buildTextTheme(
        ThemeData.light().textTheme,
        AppColors.lightOnSurface,
        AppColors.lightOnSurfaceVariant,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
      ),
    );
  }

  static TextTheme _buildTextTheme(
    TextTheme base,
    Color primaryColor,
    Color secondaryColor,
  ) {
    final textTheme = GoogleFonts.interTextTheme(base);
    return textTheme.copyWith(
      displayLarge: textTheme.displayLarge?.copyWith(color: primaryColor),
      displayMedium: textTheme.displayMedium?.copyWith(color: primaryColor),
      displaySmall: textTheme.displaySmall?.copyWith(color: primaryColor),
      headlineLarge: textTheme.headlineLarge?.copyWith(color: primaryColor),
      headlineMedium: textTheme.headlineMedium?.copyWith(color: primaryColor),
      headlineSmall: textTheme.headlineSmall?.copyWith(color: primaryColor),
      titleLarge: textTheme.titleLarge?.copyWith(color: primaryColor),
      titleMedium: textTheme.titleMedium?.copyWith(color: primaryColor),
      titleSmall: textTheme.titleSmall?.copyWith(color: primaryColor),
      bodyLarge: textTheme.bodyLarge?.copyWith(color: primaryColor),
      bodyMedium: textTheme.bodyMedium?.copyWith(color: primaryColor),
      bodySmall: textTheme.bodySmall?.copyWith(color: secondaryColor),
      labelLarge: textTheme.labelLarge?.copyWith(color: primaryColor),
      labelMedium: textTheme.labelMedium?.copyWith(color: secondaryColor),
      labelSmall: textTheme.labelSmall?.copyWith(color: secondaryColor),
    );
  }
}

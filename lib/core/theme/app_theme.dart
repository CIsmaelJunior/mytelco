import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(AppConstants.primaryOrange),
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppConstants.fontSizeTitle,
          fontWeight: FontWeight.bold,
          color: Color(AppConstants.textDark),
          fontFamily: 'Roboto',
        ),
        displayMedium: TextStyle(
          fontSize: AppConstants.fontSizeXXLarge,
          fontWeight: FontWeight.bold,
          color: Color(AppConstants.textDark),
          fontFamily: 'Roboto',
        ),
        displaySmall: TextStyle(
          fontSize: AppConstants.fontSizeXLarge,
          fontWeight: FontWeight.w600,
          color: Color(AppConstants.textDark),
          fontFamily: 'Roboto',
        ),
        headlineMedium: TextStyle(
          fontSize: AppConstants.fontSizeLarge,
          fontWeight: FontWeight.w600,
          color: Color(AppConstants.textDark),
          fontFamily: 'Roboto',
        ),
        bodyLarge: TextStyle(
          fontSize: AppConstants.fontSizeLarge,
          fontWeight: FontWeight.normal,
          color: Color(AppConstants.textDark),
          fontFamily: 'Roboto',
        ),
        bodyMedium: TextStyle(
          fontSize: AppConstants.fontSizeMedium,
          fontWeight: FontWeight.normal,
          color: Color(AppConstants.textDark),
          fontFamily: 'Roboto',
        ),
        bodySmall: TextStyle(
          fontSize: AppConstants.fontSizeSmall,
          fontWeight: FontWeight.normal,
          color: Color(AppConstants.textGray),
          fontFamily: 'Roboto',
        ),
      ),
      scaffoldBackgroundColor: const Color(AppConstants.backgroundGray),
      cardColor: const Color(AppConstants.cardBackground),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(AppConstants.cardBackground),
        foregroundColor: const Color(AppConstants.textDark),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: AppConstants.fontSizeXLarge,
          fontWeight: FontWeight.bold,
          color: Color(AppConstants.textDark),
          fontFamily: 'Roboto',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(AppConstants.primaryOrange),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: AppConstants.paddingMedium,
          ),
          textStyle: const TextStyle(
            fontSize: AppConstants.fontSizeMedium,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(AppConstants.textDark),
          side: const BorderSide(
            color: Color(AppConstants.textDark),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLarge,
            vertical: AppConstants.paddingMedium,
          ),
          textStyle: const TextStyle(
            fontSize: AppConstants.fontSizeMedium,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(AppConstants.cardBackground),
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(AppConstants.cardBackground),
        selectedItemColor: const Color(AppConstants.primaryOrange),
        unselectedItemColor: const Color(AppConstants.textGray),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: const TextStyle(
          fontSize: AppConstants.fontSizeSmall,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: AppConstants.fontSizeSmall,
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  // Couleurs personnalisées
  static const Color primaryOrange = Color(AppConstants.primaryOrange);
  static const Color secondaryOrange = Color(AppConstants.secondaryOrange);
  static const Color lightOrange = Color(AppConstants.lightOrange);
  static const Color successGreen = Color(AppConstants.successGreen);
  static const Color lightGreen = Color(AppConstants.lightGreen);
  static const Color textDark = Color(AppConstants.textDark);
  static const Color textGray = Color(AppConstants.textGray);
  static const Color textLightGray = Color(AppConstants.textLightGray);
  static const Color backgroundGray = Color(AppConstants.backgroundGray);
  static const Color cardBackground = Color(AppConstants.cardBackground);
}

import 'package:duobr_project/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surfaceBright: AppColors.backgroundLight,
      surface: AppColors.cardLight,
      error: AppColors.errorLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryLight,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textLight),
      bodyMedium: TextStyle(color: AppColors.textLight),
      labelMedium: TextStyle(color: AppColors.textLightQuaternary),
    ),
    cardTheme: const CardTheme(color: AppColors.cardLight, elevation: 2, margin: EdgeInsets.all(8)),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surfaceBright: AppColors.backgroundDark,
      surface: AppColors.cardDark,
      error: AppColors.errorDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryDark,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark),
      bodyMedium: TextStyle(color: AppColors.textDark),
      labelMedium: TextStyle(color: AppColors.textDarkQuaternary),
    ),
    cardTheme: const CardTheme(color: AppColors.cardDark, elevation: 2, margin: EdgeInsets.all(8)),
  );
}

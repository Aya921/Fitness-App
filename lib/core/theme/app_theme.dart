// app theme 

import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(ColorScheme colors) {
    return ThemeData(
      colorScheme: colors,
      scaffoldBackgroundColor: Colors.transparent,
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: const TextStyle(color: AppColors.red, fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        iconColor: AppColors.lightPink,
        hintStyle: TextStyle(
          color: AppColors.gray[AppColors.colorCode10],
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIconColor: AppColors.white,
        suffixIconColor: AppColors.white,
        labelStyle: TextStyle(
          fontSize: 12,
          color: AppColors.gray[AppColors.colorCode10],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10000),
          borderSide: const BorderSide(width: 1, color: AppColors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10000),
          borderSide: const BorderSide(width: 1, color: AppColors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10000),
          borderSide: const BorderSide(width: 1.5, color: AppColors.orange),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10000),
          borderSide: const BorderSide(width: 1, color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10000),
          borderSide: const BorderSide(width: 1, color: AppColors.red),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(
          (AppColors.orange[AppColors.baseColor]),
        ),
        overlayColor: WidgetStatePropertyAll(
          (AppColors.orange[AppColors.baseColor]),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: AppColors.white,
            ),
          ),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 14),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
          ),
          foregroundColor: WidgetStateProperty.all(AppColors.white),
          backgroundColor: WidgetStateProperty.all(
            AppColors.orange[AppColors.baseColor],
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme = getTheme(
    ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.orange[AppColors.baseColor]!,
      onPrimary: AppColors.black,
      secondary: AppColors.deepRed[AppColors.baseColor]!,
      onSecondary: AppColors.black,
      error: AppColors.red,
      onError: AppColors.red,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
  );
}

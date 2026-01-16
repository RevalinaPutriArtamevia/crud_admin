import 'package:flutter/material.dart';

class AppTheme {
  static const primary = Color(0xFF800000);
  static const secondary = Color(0xFFF5E6E6);

  static ThemeData theme = ThemeData(
    primaryColor: primary,

    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}

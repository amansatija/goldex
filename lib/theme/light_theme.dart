import 'package:flutter/material.dart';

class LightTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFD4AF37), // 24K gold color
    scaffoldBackgroundColor: const Color(0xFFF9F9FB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFD4AF37), // 24K gold
      secondary: const Color(0xFFC9A52C), // 22K gold
      tertiary: const Color(0xFFBE9B21), // 18K gold
      background: const Color(0xFFF9F9FB),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onBackground: Colors.black,
      onSurface: Colors.black,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 16,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 14,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 12,
        color: Colors.black54,
      ),
    ),
  );
}

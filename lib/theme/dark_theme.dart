import 'package:flutter/material.dart';

class DarkTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFD4AF37), // 24K gold color
    scaffoldBackgroundColor: const Color(0xFF16213E),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF16213E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFD4AF37), // 24K gold
      secondary: const Color(0xFFC9A52C), // 22K gold
      tertiary: const Color(0xFFBE9B21), // 18K gold
      background: const Color(0xFF16213E),
      surface: const Color(0xFF1A1A2E),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onTertiary: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 16,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 14,
        color: Colors.white70,
      ),
      bodySmall: TextStyle(
        fontFamily: 'DM Sans',
        fontSize: 12,
        color: Colors.white60,
      ),
    ),
  );
}

import 'package:flutter/material.dart';

/// App theme matching Figma design for Pixel 5 (393 x 851 dp)
class AppTheme {
  // Main colors from Figma
  static const Color primaryOrange = Color(0xFFF5A623); // Header orange
  static const Color lightBlue = Color(0xFF7DD3FC); // Card blue background
  static const Color skyBlue = Color(0xFFBAE6FD); // Lighter blue
  static const Color yellowCircle = Color(0xFFFFD93D); // Yellow emoji circle
  static const Color cardWhite = Color(0xFFFFFFFF); // White cards
  static const Color textDark = Color(0xFF1F2937); // Dark text
  static const Color textWhite = Color(0xFFFFFFFF); // White text
  static const Color correctGreen = Color(0xFF22C55E); // Green for correct
  static const Color wrongPink = Color(0xFFFDA4AF); // Pink for wrong
  static const Color wrongRed = Color(0xFFEF4444); // Red accent
  static const Color backgroundGray = Color(
    0xFFF3F4F6,
  ); // Light gray background
  static const Color categoryBlue = Color(0xFF3B82F6); // Blue category icon
  static const Color categoryGreen = Color(0xFF22C55E); // Green category icon
  static const Color categoryYellow = Color(0xFFFBBF24); // Yellow category icon
  static const Color categoryPurple = Color(0xFF8B5CF6); // Purple category icon

  // Pixel 5 dimensions: 393 x 851 dp
  static const double screenWidth = 393;
  static const double screenHeight = 851;

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOrange,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundGray,
      fontFamily: 'Roboto',

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryOrange,
        foregroundColor: textWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textWhite,
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: correctGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: cardWhite,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Text themes
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textWhite,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: textDark),
        bodyMedium: TextStyle(fontSize: 14, color: textDark),
        labelLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }
}

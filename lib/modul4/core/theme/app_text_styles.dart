import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Poppins', // Ganti dengan font pilihan Anda
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Poppins', // Ganti dengan font pilihan Anda
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Poppins', // Ganti dengan font pilihan Anda
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Warna ini cocok dengan foregroundColor di AppButton
  );
}

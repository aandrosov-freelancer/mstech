import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Premium Pizza Palette
  static const Color primary = Color(0xFFFF5A36); // Tomato Orange/Red
  static const Color accent = Color(0xFFFFC72C); // Cheese Yellow

  // Dark Modern Backgrounds
  static const Color darkBg = Color(0xFF121212); // Rich Pitch Dark
  static const Color cardBg = Color(0xFF1E1E1E); // Soft dark surface grey
  static const Color overlay = Color(
    0xFF2C2C2C,
  ); // High-contrast details surface

  // Interactive / State Colors
  static const Color activeDot = Color(0xFFFF5A36);
  static const Color inactiveDot = Color(0x3DFFFFFF);

  // Typography Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textContrast = Color(0xFF121212);
}

import 'package:flutter/material.dart';

class AppColors {
  // PROFESSIONAL FINANCIAL APP COLORS
  static const Color primary = Color(0xFF1E40AF); // Professional Blue
  static const Color primaryDark = Color(0xFF1E3A8A); // Dark Blue
  static const Color primaryLight = Color(0xFF3B82F6); // Light Blue
  static const Color accent = Color(0xFF059669); // Professional Green
  static const Color accentLight = Color(0xFF10B981); // Light Green

  // PROFESSIONAL GRADIENTS
  static const Color gradientStart = Color(0xFF1E40AF);
  static const Color gradientEnd = Color(0xFF3B82F6);
  static const Color gradientAccent = Color(0xFF059669);

  // CLEAN SURFACES
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color background = Color(0xFFF1F5F9);
  static const Color backgroundLight = Color(0xFFFFFFFF);

  // PROFESSIONAL TEXT
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // PROFESSIONAL STATUS COLORS
  static const Color success = Color(0xFF059669);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFD97706);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF0EA5E9);
  static const Color infoLight = Color(0xFFE0F2FE);

  // PROFESSIONAL GRADIENTS
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
    stops: [0.0, 1.0],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, gradientAccent],
    stops: [0.0, 1.0],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    stops: [0.0, 1.0],
  );

  // PROFESSIONAL SHADOWS
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x14000000);
  static const Color shadowHeavy = Color(0x1F000000);

  // PROFESSIONAL GLASS EFFECTS
  static const Color glassBackground = Color(0x20FFFFFF);
  static const Color glassBorder = Color(0x40FFFFFF);
}

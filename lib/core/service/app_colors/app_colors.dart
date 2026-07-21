import 'package:flutter/material.dart';

abstract class BaseThemeColors {
  Color get background;
  Color get surface;
  Color get textPrimary;
  Color get textSecondary;
  Color get descriptionText;
  Color get accentContainer;
  Color get border;

  Color get footerWaveColor;
  Color get footerTextColor; // NEW: Dedicated footer text color getter

  Color get gradientStart;
  Color get gradientEnd;

  List<Color> get gradientColors;
  List<double> get gradientStops;
}

class AppColors {
  static const Color primaryBlue = Color(0xFF0D47A1);
  static const Color navyBackground = Color(0xFF0A192F);

  static const _Light light = _Light();
  static const _Dark dark = _Dark();
}

class _Light implements BaseThemeColors {
  const _Light();

  @override
  final Color background = const Color(0xFFF8FAFC);
  @override
  final Color surface = Colors.white;
  @override
  final Color textPrimary = Colors.white;
  @override
  final Color textSecondary = const Color(0xFFE2E8F0);

  @override
  Color get descriptionText => Colors.white.withOpacity(0.90);

  @override
  final Color accentContainer = const Color(0xFFF1F5F9);
  @override
  final Color border = const Color(0xFFE2E8F0);

  // Light Mode Navy Wave -> Crisp White Text
  @override
  Color get footerWaveColor => AppColors.navyBackground.withOpacity(0.85);
  @override
  Color get footerTextColor => Colors.white;

  @override
  Color get gradientStart => const Color(0xFF8DA9C4);
  @override
  Color get gradientEnd => const Color(0xFF0A192F);

  @override
  List<Color> get gradientColors => const [
        Color(0xFF8DA9C4),
        Color(0xFFC5D3E8),
        Color(0xFF1B365D),
        Color(0xFF0A192F),
      ];

  @override
  List<double> get gradientStops => const [0.0, 0.35, 0.75, 1.0];
}

class _Dark implements BaseThemeColors {
  const _Dark();

  @override
  final Color background = const Color(0xFF0B111E);
  @override
  final Color surface = const Color(0xFF1E293B);
  @override
  final Color textPrimary = const Color(0xFFF8FAFC);
  @override
  final Color textSecondary = const Color(0xFF94A3B8);

  @override
  Color get descriptionText => const Color(0xFFCBD5E1);

  @override
  final Color accentContainer = const Color(0xFF334155);
  @override
  final Color border = const Color(0xFF475569);

  // Dark Mode Light Grey Wave -> Dark Charcoal Text
  @override
  Color get footerWaveColor => const Color(0xFFCBD5E1);
  @override
  Color get footerTextColor => const Color(0xFF0F172A);

  @override
  Color get gradientStart => const Color(0xFF05080E);
  @override
  Color get gradientEnd => const Color(0xFF0D1B2A);

  @override
  List<Color> get gradientColors => const [
        Color(0xFF05080E),
        Color(0xFF0A1120),
        Color(0xFF0D1B2A),
      ];

  @override
  List<double> get gradientStops => const [0.0, 0.5, 1.0];
}
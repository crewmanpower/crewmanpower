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
  Color get footerTextColor;
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
  Color get background => const Color(0xFFFFFFFF);
  @override
  Color get surface => Colors.white;
  @override
  Color get textPrimary => const Color(0xFF0F172A);
  @override
  Color get textSecondary => const Color(0xFF475569);

  @override
  Color get descriptionText => const Color(0xFF334155);

  @override
  Color get accentContainer => const Color(0xFFF1F5F9);
  @override
  Color get border => const Color(0xFFE2E8F0);

  @override
  Color get footerWaveColor => const Color(0xFF0A192F);
  @override
  Color get footerTextColor => Colors.white;

  @override
  Color get gradientStart => const Color(0xFFFFFFFF);
  @override
  Color get gradientEnd => const Color(0xFFF8FAFC);

  @override
  List<Color> get gradientColors => const [
        Color(0xFFFFFFFF),
        Color(0xFFF8FAFC),
        Color(0xFFF1F5F9),
      ];

  @override
  List<double> get gradientStops => const [0.0, 0.5, 1.0];
}

class _Dark implements BaseThemeColors {
  const _Dark();

  @override
  Color get background => const Color(0xFF0A192F); // Deep Dark Blue
  @override
  Color get surface => const Color(0xFF112240); // Lighter Dark Blue Surface
  @override
  Color get textPrimary => const Color(0xFFF8FAFC);
  @override
  Color get textSecondary => const Color(0xFF94A3B8);

  @override
  Color get descriptionText => const Color(0xFFCBD5E1);

  @override
  Color get accentContainer => const Color(0xFF1E3A8A);
  @override
  Color get border => const Color(0xFF1E3A8A);

  @override
  Color get footerWaveColor => const Color(0xFFCBD5E1);
  @override
  Color get footerTextColor => const Color(0xFF0F172A);

  @override
  Color get gradientStart => const Color(0xFF0A192F); // Rich Dark Blue
  @override
  Color get gradientEnd => const Color(0xFF020C1B);   // Deeper Dark Blue

  @override
  List<Color> get gradientColors => const [
        Color(0xFF0A192F),
        Color(0xFF07111E),
        Color(0xFF020C1B),
      ];

  @override
  List<double> get gradientStops => const [0.0, 0.5, 1.0];
}
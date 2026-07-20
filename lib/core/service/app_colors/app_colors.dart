import 'package:flutter/material.dart';

// Public interface that enables unified type casting across files
abstract class BaseThemeColors {
  Color get background;
  Color get surface;
  Color get textPrimary;
  Color get textSecondary;
  Color get accentContainer;
  Color get border;
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
  final Color textPrimary = const Color(0xFF1E293B);
  @override
  final Color textSecondary = const Color(0xFF64748B);
  @override
  final Color accentContainer = const Color(0xFFF1F5F9);
  @override
  final Color border = const Color(0xFFE2E8F0);
}

class _Dark implements BaseThemeColors {
  const _Dark();

  @override
  final Color background = const Color(0xFF0F172A);
  @override
  final Color surface = const Color(0xFF1E293B);
  @override
  final Color textPrimary = const Color(0xFFF8FAFC);
  @override
  final Color textSecondary = const Color(0xFF94A3B8);
  @override
  final Color accentContainer = const Color(0xFF334155);
  @override
  final Color border = const Color(0xFF475569);
}
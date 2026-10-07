import 'package:flutter/material.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class CustomNavButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const CustomNavButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeThemeColors = isDark ? AppColors.dark : AppColors.light;

    // Active tab ke liye vibrant color aur inactive ke liye theme ke mutabiq text color
    final activeColor = Colors.orange[400] ?? Colors.orange;
    final inactiveColor = isDark ? activeThemeColors.textSecondary : activeThemeColors.textPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: (isDark ? Colors.white : Colors.black).withOpacity(0.08),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isActive ? activeColor : inactiveColor,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                width: isActive ? 24 : 0,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
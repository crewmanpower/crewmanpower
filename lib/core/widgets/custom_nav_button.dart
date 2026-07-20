import 'package:flutter/material.dart';

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
    // Using an eye-catching accent color for the active states on a dark surface
    final activeAccentColor = Colors.orange[400] ?? Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        // Changed hover indicator to look pristine on dark backgrounds
        hoverColor: Colors.white.withOpacity(0.08),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  // Active tabs show the vibrant accent color, inactive tabs show clean crisp white
                  color: isActive ? activeAccentColor : Colors.white.withOpacity(0.9),
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
                  color: activeAccentColor,
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
import 'package:flutter/material.dart';

class AnimatedStatCard extends StatelessWidget {
  /// The target numerical value where the count-up animation stops (e.g., 500, 10000, 99)
  final int targetValue;
  
  /// The text suffix added immediately after the counting completes (e.g., "+", "%")
  final String suffix;
  
  /// The descriptive title or description displayed underneath the metric metric
  final String label;
  
  /// The icon representing the statistic node visually
  final IconData icon;

  const AnimatedStatCard({
    super.key,
    required this.targetValue,
    required this.suffix,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Explicit sizing helps provide consistent card structures within Wrap grids
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06), // Subtle translucent glassmorphism finish
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Elegant circular background frame for the icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.orange, size: 28),
          ),
          const SizedBox(height: 16),
          // Pure Flutter Implicit Animation Engine: Automatically tracks from 0 to target
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: targetValue.toDouble()),
            duration: const Duration(milliseconds: 1800), // Smooth counting duration speed
            curve: Curves.easeOutExpo, // Slows down beautifully right before stopping
            builder: (context, value, child) {
              return Text(
                "${value.toInt()}$suffix",
                style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
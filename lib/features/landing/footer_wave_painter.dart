import 'package:flutter/material.dart';

class FooterWavePainter extends CustomPainter {
  final Color backgroundColor;

  // Passes theme color explicitly through constructor
  const FooterWavePainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = backgroundColor;

    // Define a fixed maximum height for the wave curve transition area
    const double waveHeight = 120.0;

    Path baseBodyPath = Path();
    // Start the wave path at the left edge
    baseBodyPath.moveTo(0, waveHeight * 0.5); 
    
    // Use fixed waveHeight calculations so the curve remains consistent on all screens
    baseBodyPath.cubicTo(
      size.width * 0.35, waveHeight * 1.1, 
      size.width * 0.65, waveHeight * 0.1, 
      size.width, waveHeight * 0.6
    );
    
    // Fill the rest of the container down to the bottom
    baseBodyPath.lineTo(size.width, size.height);
    baseBodyPath.lineTo(0, size.height);
    baseBodyPath.close();
    
    canvas.drawPath(baseBodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant FooterWavePainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor;
  }
}
import 'package:flutter/material.dart';

class FooterWavePainter extends CustomPainter {
  final Color backgroundColor;

  const FooterWavePainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = backgroundColor;
    const double waveHeight = 120.0;

    Path baseBodyPath = Path();
    baseBodyPath.moveTo(0, waveHeight * 0.5);

    baseBodyPath.cubicTo(
      size.width * 0.35, waveHeight * 1.1,
      size.width * 0.65, waveHeight * 0.1,
      size.width, waveHeight * 0.6,
    );

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
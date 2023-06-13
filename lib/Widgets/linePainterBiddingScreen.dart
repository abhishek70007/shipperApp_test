import 'package:flutter/material.dart';

class LinePainterBiddingsScreen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFAFAFAF)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(3, 1), Offset(3, 15), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import '/constants/colors.dart';

class LinePainter extends CustomPainter {
  double? height;
  double? width;
  LinePainter({this.height, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = locationLineColor
      ..strokeWidth = width != null ? width! : 2;
    canvas.drawLine(
        Offset(3, 1), Offset(3, height != null ? height! + 1 : 29), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

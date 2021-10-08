import 'package:detector/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';

class BackClipper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = ColorTheme.accentColor2
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height * 0.6000000);
    path_0.quadraticBezierTo(size.width * 0.2781250, size.height * 0.8325200,
        size.width * 0.5250000, size.height * 0.8400000);
    path_0.quadraticBezierTo(size.width * 0.7734500, size.height * 0.8300000,
        size.width, size.height * 0.6400000);
    path_0.lineTo(size.width, 0);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

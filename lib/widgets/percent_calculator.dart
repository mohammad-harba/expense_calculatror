import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vectorMath;



class PercentCircle extends CustomPainter {
  final double percentage;
  final Color color;

  PercentCircle({this.percentage, this.color = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromCircle(center: Offset(0, 0), radius: 50),
        vectorMath.radians(-90),
        vectorMath.radians(percentage),
        true,
        customPaint());
  }

  Paint customPaint() {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    paint.strokeWidth = 10;
    return paint;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

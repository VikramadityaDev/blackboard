import 'dart:ui';

import 'package:canvas/model/draw_point.dart';
import 'package:flutter/material.dart';

class CanvasView extends CustomPainter {
  CanvasView({required this.points, this.defaultPenColor = Colors.white});
  final List<List<DrawPoint>> points;
  final Color defaultPenColor;
  @override
  void paint(Canvas canvas, Size size) {
    points.forEach((draw) {
      for (int index = 0; index < draw.length; index++) {
        if (index < (draw.length - 1)) {
          final paint = Paint()
            ..color = draw[index].color ?? defaultPenColor
            ..strokeCap = StrokeCap.round
            ..strokeWidth = draw[index].thickness;
          canvas.drawLine(draw[index].point, draw[index + 1].point, paint);
        } else {
          final paint = Paint()
            ..color = draw[index].color ?? defaultPenColor
            ..strokeCap = StrokeCap.round
            ..strokeWidth = draw[index].thickness;
          canvas.drawPoints(PointMode.points, [draw.first.point], paint);
        }
      }
    });
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
import 'dart:ui';

class DrawPoint {
  DrawPoint({
    required this.point,
    this.color,
    this.thickness = 4.0
});

final Offset point;
final Color? color;
final double thickness;}
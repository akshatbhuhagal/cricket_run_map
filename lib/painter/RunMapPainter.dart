
import 'dart:math';

import 'package:flutter/material.dart';



class RunMapPainter extends CustomPainter {
  final List<String> positionNames;
  final Offset? tapPoint;
  final int? selectedPosition;
  final Color selectedPositionColor;
  final Color groundColor;

  RunMapPainter(this.positionNames, {
    required this.tapPoint,
    required this.selectedPosition,
    this.selectedPositionColor = Colors.grey,
    this.groundColor = const Color(0xFF669801),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw the circle
    canvas.drawCircle(center, radius, circlePaint);

    final double sliceAngle = 2 * pi / positionNames.length;
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );

    // Draw lines from center to tap point
    if (tapPoint != null) {
      final Paint linePaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawLine(center, tapPoint!, linePaint);

      // Draw dot at the end of the line
      final Paint dotPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;
      canvas.drawCircle(tapPoint!, 4.0, dotPaint);

    }

    for (int i = 0; i < positionNames.length; i++) {
      final Path path = Path();
      path.moveTo(center.dx, center.dy);
      final double startAngle = sliceAngle * i;
      final double endAngle = sliceAngle * (i + 1);
      path.lineTo(
        center.dx + radius * cos(startAngle),
        center.dy + radius * sin(startAngle),
      );
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sliceAngle,
        false,
      );
      path.close();

      // Set color based on selection
      if (selectedPosition != null && i == selectedPosition) {
        paint.color = selectedPositionColor;
      } else {
        paint.color = groundColor;
      }

      canvas.drawPath(path, paint);

      // Inner Border
      final Paint strokePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawPath(path, strokePaint);

      final double midAngle = (startAngle + endAngle) / 2;
      final double textCenterX = center.dx + radius * 0.8 * cos(midAngle);
      final double textCenterY = center.dy + radius * 0.8 * sin(midAngle);

      final textSpan = TextSpan(
        text: positionNames[i],
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textOffset = Offset(
        textCenterX - textPainter.width / 2,
        textCenterY - textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
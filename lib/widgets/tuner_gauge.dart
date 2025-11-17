import 'package:flutter/material.dart';
import 'dart:math' as math;

class TunerGauge extends StatelessWidget {
  final double cents;
  final String status;

  const TunerGauge({
    Key? key,
    required this.cents,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 150),
      painter: _TunerGaugePainter(
        cents: cents,
        status: status,
        colorScheme: Theme.of(context).colorScheme,
      ),
    );
  }
}

class _TunerGaugePainter extends CustomPainter {
  final double cents;
  final String status;
  final ColorScheme colorScheme;

  _TunerGaugePainter({
    required this.cents,
    required this.status,
    required this.colorScheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width * 0.4;

    // Draw arc background
    final arcPaint = Paint()
      ..color = colorScheme.surfaceContainerHighest
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      arcPaint,
    );

    // Draw tick marks
    _drawTickMarks(canvas, center, radius);

    // Draw cents indicator
    _drawCentsIndicator(canvas, center, radius);

    // Draw center indicator
    _drawCenterIndicator(canvas, center, radius);
  }

  void _drawTickMarks(Canvas canvas, Offset center, double radius) {
    final tickPaint = Paint()
      ..color = colorScheme.onSurface.withOpacity(0.3)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Major ticks at -50, -25, 0, 25, 50 cents
    final majorTicks = [-50.0, -25.0, 0.0, 25.0, 50.0];

    for (final tick in majorTicks) {
      final angle = math.pi + (tick / 50) * (math.pi / 2);
      final innerRadius = radius - 15;
      final outerRadius = radius - 5;

      final start = Offset(
        center.dx + math.cos(angle) * innerRadius,
        center.dy + math.sin(angle) * innerRadius,
      );
      final end = Offset(
        center.dx + math.cos(angle) * outerRadius,
        center.dy + math.sin(angle) * outerRadius,
      );

      canvas.drawLine(start, end, tickPaint);
    }
  }

  void _drawCentsIndicator(Canvas canvas, Offset center, double radius) {
    final clampedCents = cents.clamp(-50.0, 50.0);
    final angle = math.pi + (clampedCents / 50) * (math.pi / 2);

    Color indicatorColor;
    if (cents.abs() < 5) {
      indicatorColor = Colors.green;
    } else if (cents.abs() < 15) {
      indicatorColor = Colors.orange;
    } else {
      indicatorColor = Colors.red;
    }

    final needlePaint = Paint()
      ..color = indicatorColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final needleLength = radius - 10;
    final needleEnd = Offset(
      center.dx + math.cos(angle) * needleLength,
      center.dy + math.sin(angle) * needleLength,
    );

    canvas.drawLine(center, needleEnd, needlePaint);

    // Draw needle tip circle
    final circlePaint = Paint()
      ..color = indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(needleEnd, 6, circlePaint);
  }

  void _drawCenterIndicator(Canvas canvas, Offset center, double radius) {
    final centerPaint = Paint()
      ..color = colorScheme.primary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 8, centerPaint);
  }

  @override
  bool shouldRepaint(_TunerGaugePainter oldDelegate) {
    return cents != oldDelegate.cents || status != oldDelegate.status;
  }
}

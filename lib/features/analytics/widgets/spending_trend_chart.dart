import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SpendingTrendChart extends StatelessWidget {
  const SpendingTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Data points normalized to 0-1 range
    final points = [0.87, 0.73, 0.80, 0.40, 0.60, 0.27];

    return SizedBox(
      height: 180,
      child: CustomPaint(
        painter: _LineChartPainter(points: points),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> points;

  _LineChartPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height - 20;

    // Grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 1; i <= 3; i++) {
      final y = h * i / 4;
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }

    // Build offsets
    final offsets = List.generate(points.length, (i) {
      final x = i * w / (points.length - 1);
      final y = h * points[i];
      return Offset(x, y);
    });

    // Gradient fill
    final fillPath = Path()..moveTo(0, h * points[0]);
    for (int i = 1; i < offsets.length; i++) {
      final prev = offsets[i - 1];
      final curr = offsets[i];
      final cpx = (prev.dx + curr.dx) / 2;
      fillPath.cubicTo(cpx, prev.dy, cpx, curr.dy, curr.dx, curr.dy);
    }
    fillPath
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primaryContainer.withOpacity(0.3),
          AppColors.primaryContainer.withOpacity(0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(fillPath, gradientPaint);

    // Main line
    final linePath = Path()..moveTo(offsets[0].dx, offsets[0].dy);
    for (int i = 1; i < offsets.length; i++) {
      final prev = offsets[i - 1];
      final curr = offsets[i];
      final cpx = (prev.dx + curr.dx) / 2;
      linePath.cubicTo(cpx, prev.dy, cpx, curr.dy, curr.dx, curr.dy);
    }

    final linePaint = Paint()
      ..color = AppColors.primaryContainer
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(linePath, linePaint);

    // Highlight point (middle)
    final midPoint = offsets[offsets.length ~/ 2];
    canvas.drawCircle(
      midPoint,
      6,
      Paint()..color = AppColors.primary,
    );
    canvas.drawCircle(
      midPoint,
      4,
      Paint()..color = Colors.white,
    );

    // X-axis labels
    const labels = ['01 Oct', '10 Oct', '20 Oct', '30 Oct'];
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < labels.length; i++) {
      textPainter.text = TextSpan(
        text: labels[i],
        style: const TextStyle(
          color: AppColors.outline,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          i * w / (labels.length - 1) - textPainter.width / 2,
          h + 6,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(_LineChartPainter old) => old.points != points;
}

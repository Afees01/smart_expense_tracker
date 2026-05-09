import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CategoryDonutChart extends StatelessWidget {
  const CategoryDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    const segments = [
      _Segment('Housing', 0.40, AppColors.primary),
      _Segment('Food & Drinks', 0.25, AppColors.primaryContainer),
      _Segment('Transport', 0.15, AppColors.tertiaryContainer),
      _Segment('Others', 0.20, AppColors.outlineVariant),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Donut
        Center(
          child: SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  painter: _DonutPainter(segments: segments),
                  size: const Size(160, 160),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total', style: AppTextStyles.numericData.copyWith(fontSize: 14)),
                    Text(
                      '12 Cats',
                      style: AppTextStyles.labelMd.copyWith(color: AppColors.outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Legend
        ...segments.take(3).map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: s.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(s.label, style: AppTextStyles.bodyMd),
                    ],
                  ),
                  Text(
                    '${(s.value * 100).round()}%',
                    style: AppTextStyles.numericData,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class _Segment {
  final String label;
  final double value;
  final Color color;

  const _Segment(this.label, this.value, this.color);
}

class _DonutPainter extends CustomPainter {
  final List<_Segment> segments;

  _DonutPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 28.0;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    double startAngle = -pi / 2;
    const gap = 0.03;

    for (final seg in segments) {
      final sweepAngle = 2 * pi * seg.value - gap;
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += 2 * pi * seg.value;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) => false;
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ExportReportCard extends StatelessWidget {
  const ExportReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Export Report',
            style: AppTextStyles.headlineMd.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Download your financial statement for the selected period.',
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.primaryFixed.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          _ExportButton(
            icon: Icons.picture_as_pdf_outlined,
            label: 'PDF Report',
          ),
          const SizedBox(height: 8),
          _ExportButton(
            icon: Icons.table_chart_outlined,
            label: 'Excel Sheet',
          ),
        ],
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ExportButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white, size: 22),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: AppTextStyles.bodyLg.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.download, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class IncomeExpenseSummary extends StatelessWidget {
  final double income;
  final double expenses;

  const IncomeExpenseSummary({
    super.key,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'Income',
            amount: income,
            icon: Icons.arrow_downward,
            color: AppColors.primary,
            hoverBorderColor: AppColors.primaryContainer,
          ),
        ),
        const SizedBox(width: AppSpacing.gutterMobile),
        Expanded(
          child: _SummaryCard(
            label: 'Expenses',
            amount: expenses,
            icon: Icons.arrow_upward,
            color: AppColors.error,
            hoverBorderColor: AppColors.error,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;
  final Color color;
  final Color hoverBorderColor;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
    required this.hoverBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.labelMd.copyWith(
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: AppTextStyles.numericData.copyWith(
              color: AppColors.onSurface,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

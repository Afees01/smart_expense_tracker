import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class TotalBudgetSummaryCard extends StatelessWidget {
  final double totalBudget;
  final double spent;
  final String period;

  const TotalBudgetSummaryCard({
    super.key,
    required this.totalBudget,
    required this.spent,
    required this.period,
  });

  double get remaining => totalBudget - spent;
  double get percentage => (spent / totalBudget).clamp(0, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL MONTHLY BUDGET',
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${totalBudget.toStringAsFixed(2)}',
                    style: AppTextStyles.displayLg,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  period,
                  style: AppTextStyles.labelMd.copyWith(
                    color: AppColors.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                  children: [
                    const TextSpan(text: 'Spent: '),
                    TextSpan(
                      text: '\$${spent.toStringAsFixed(2)}',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                  children: [
                    const TextSpan(text: 'Remaining: '),
                    TextSpan(
                      text: '\$${remaining.toStringAsFixed(2)}',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have used ${(percentage * 100).toStringAsFixed(1)}% of your total budget.',
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

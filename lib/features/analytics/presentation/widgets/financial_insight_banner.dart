import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';


class FinancialInsightBanner extends StatelessWidget {
  final String title;
  final String message;

  const FinancialInsightBanner({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.onSecondaryFixedVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lightbulb_outlined,
              color: AppColors.secondaryFixed,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLg.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.onSecondaryContainer.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

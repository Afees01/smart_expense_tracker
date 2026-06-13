import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';
import 'package:smart_expense_tracker/shared/models/budget_model.dart';


class BudgetCategoryCard extends StatelessWidget {
  final BudgetModel budget;

  const BudgetCategoryCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: budget.borderColor, width: 4),
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: budget.iconBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(budget.icon, color: budget.iconColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        budget.title,
                        style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\$${budget.budgeted.toStringAsFixed(2)} budgeted',
                        style: AppTextStyles.labelMd.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '\$${budget.spent.toStringAsFixed(2)}',
                style: AppTextStyles.numericData.copyWith(color: budget.statusColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: budget.percentage,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: AlwaysStoppedAnimation<Color>(budget.statusColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${budget.percentageValue.round()}% used',
                style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant),
              ),
              Text(
                budget.statusLabel,
                style: AppTextStyles.labelMd.copyWith(
                  color: budget.statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

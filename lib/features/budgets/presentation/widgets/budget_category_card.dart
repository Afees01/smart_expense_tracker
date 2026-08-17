import 'package:flutter/material.dart';

import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';

import 'package:smart_expense_tracker/features/budgets/data/models/budget_model.dart';

class BudgetCategoryCard extends StatelessWidget {
  final BudgetModel budget;

  const BudgetCategoryCard({
    super.key,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    final progress = budget.budgeted <= 0
        ? 0.0
        : (budget.spent / budget.budgeted).clamp(0.0, 1.0);

    final percentage = budget.budgeted <= 0
        ? 0
        : ((budget.spent / budget.budgeted) * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: budget.borderColor,
            width: 4,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ==================================================
          // HEADER
          // ==================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: budget.iconBgColor,
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: Icon(
                        budget.icon,
                        color: budget.iconColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            budget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyLg.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '\$${budget.budgeted.toStringAsFixed(2)} budgeted',
                            style: AppTextStyles.labelMd.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                '\$${budget.spent.toStringAsFixed(2)}',
                style: AppTextStyles.numericData.copyWith(
                  color: budget.statusColor,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          // ==================================================
          // PROGRESS BAR
          // ==================================================

          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: AlwaysStoppedAnimation<Color>(
                budget.statusColor,
              ),
              minHeight: 8,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          // ==================================================
          // STATUS
          // ==================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$percentage% used',
                style: AppTextStyles.labelMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
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

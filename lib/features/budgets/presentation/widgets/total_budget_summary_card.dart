import 'package:flutter/material.dart';

import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';

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

  double get remaining {
    final value = totalBudget - spent;

    // Don't show negative remaining amount.
    return value < 0 ? 0 : value;
  }

  double get percentage {
    if (totalBudget <= 0) {
      return 0;
    }

    return (spent / totalBudget).clamp(0.0, 1.0);
  }

  double get actualPercentage {
    if (totalBudget <= 0) {
      return 0;
    }

    return (spent / totalBudget) * 100;
  }

  bool get isOverspent {
    return spent > totalBudget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,

        borderRadius:
            BorderRadius.circular(12),

        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ==================================================
          // HEADER
          // ==================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    'TOTAL MONTHLY BUDGET',

                    style: AppTextStyles
                        .labelMd
                        .copyWith(
                      color: AppColors
                          .onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    '\$${totalBudget.toStringAsFixed(2)}',

                    style:
                        AppTextStyles.displayLg,
                  ),
                ],
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color:
                      AppColors.secondaryContainer,

                  borderRadius:
                      BorderRadius.circular(
                    9999,
                  ),
                ),

                child: Text(
                  period,

                  style: AppTextStyles
                      .labelMd
                      .copyWith(
                    color: AppColors
                        .onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          // ==================================================
          // SPENT / REMAINING
          // ==================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyMd
                      .copyWith(
                    color: AppColors
                        .onSurfaceVariant,
                  ),

                  children: [
                    const TextSpan(
                      text: 'Spent: ',
                    ),

                    TextSpan(
                      text:
                          '\$${spent.toStringAsFixed(2)}',

                      style: AppTextStyles
                          .bodyMd
                          .copyWith(
                        color: isOverspent
                            ? AppColors.error
                            : AppColors.onSurface,

                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyMd
                      .copyWith(
                    color: AppColors
                        .onSurfaceVariant,
                  ),

                  children: [
                    const TextSpan(
                      text: 'Remaining: ',
                    ),

                    TextSpan(
                      text:
                          '\$${remaining.toStringAsFixed(2)}',

                      style: AppTextStyles
                          .bodyMd
                          .copyWith(
                        color: isOverspent
                            ? AppColors.error
                            : AppColors.primary,

                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          // ==================================================
          // PROGRESS
          // ==================================================

          ClipRRect(
            borderRadius:
                BorderRadius.circular(9999),

            child: LinearProgressIndicator(
              value: percentage,

              backgroundColor:
                  AppColors.surfaceContainer,

              valueColor:
                  AlwaysStoppedAnimation<Color>(
                isOverspent
                    ? AppColors.error
                    : AppColors.primary,
              ),

              minHeight: 12,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          // ==================================================
          // STATUS MESSAGE
          // ==================================================

          Text(
            isOverspent
                ? 'You have exceeded your total budget by \$${(spent - totalBudget).toStringAsFixed(2)}.'
                : 'You have used ${actualPercentage.toStringAsFixed(1)}% of your total budget.',

            style: AppTextStyles.labelMd
                .copyWith(
              color: isOverspent
                  ? AppColors.error
                  : AppColors.onSurfaceVariant,

              fontStyle:
                  FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
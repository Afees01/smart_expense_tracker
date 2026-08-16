import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/core/constants/app_spacing.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';
import 'package:smart_expense_tracker/shared/widgets/app_card.dart';
import 'package:smart_expense_tracker/shared/widgets/wealthflow_app_bar.dart';
import '../widgets/spending_trend_chart.dart';
import '../widgets/category_donut_chart.dart';
import '../widgets/export_report_card.dart';
import '../widgets/financial_insight_banner.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WealthFlowAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.marginMobile,
          vertical: AppSpacing.stackLg,
        ),
        child: Column(
          children: [
            // View Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _ToggleButton(label: 'Weekly', isSelected: false),
                  _ToggleButton(label: 'Monthly', isSelected: true),
                  _ToggleButton(label: 'Yearly', isSelected: false),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.stackLg),

            // Spending Trend Card
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Spending Trend', style: AppTextStyles.headlineMd),
                          Text(
                            'Last 30 Days Overview',
                            style: AppTextStyles.bodyMd.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$4,285.50',
                            style: AppTextStyles.displayLg.copyWith(
                              color: AppColors.primary,
                              fontSize: 24,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.trending_down,
                                size: 14,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '12% decrease',
                                style: AppTextStyles.labelMd.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const SpendingTrendChart(),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.stackMd),

            // Category + Export grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category Analysis', style: AppTextStyles.headlineMd),
                        const SizedBox(height: 16),
                        const CategoryDonutChart(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.stackMd),
            const ExportReportCard(),
            const SizedBox(height: AppSpacing.stackMd),
            const FinancialInsightBanner(
              title: 'Financial Insight',
              message:
                  "You've saved \$120 more in \"Food\" this month compared to September. Keep it up!",
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _ToggleButton({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: isSelected
              ? BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelMd.copyWith(
              color: isSelected ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

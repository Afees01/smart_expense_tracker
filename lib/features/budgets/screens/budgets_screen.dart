import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/models/budget_model.dart';
import '../../../shared/widgets/wealthflow_app_bar.dart';
import '../widgets/total_budget_summary_card.dart';
import '../widgets/budget_category_card.dart';
import '../widgets/smart_allocation_card.dart';

class BudgetsScreen extends StatelessWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WealthFlowAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryContainer,
        foregroundColor: AppColors.onPrimaryContainer,
        elevation: 4,
        child: const Icon(Icons.add, size: 32),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.marginMobile,
          vertical: AppSpacing.stackLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TotalBudgetSummaryCard(
              totalBudget: 4250.00,
              spent: 2145.50,
              period: 'Oct 2023',
            ),
            const SizedBox(height: AppSpacing.stackLg),

            // Category header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories', style: AppTextStyles.headlineMd),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Text(
                      'View All',
                      style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
                    ),
                    label: const Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.stackMd),

            // Budget cards grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: AppSpacing.stackMd,
                childAspectRatio: 2.8,
              ),
              itemCount: sampleBudgets.length,
              itemBuilder: (context, index) {
                return BudgetCategoryCard(budget: sampleBudgets[index]);
              },
            ),
            const SizedBox(height: AppSpacing.stackLg),

            SmartAllocationCard(
              message:
                  "Based on your last month's spending, we recommend increasing your 'Transport' budget by \$50.",
              onReview: () {},
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

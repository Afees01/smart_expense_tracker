import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/models/transaction_model.dart';
import '../../../shared/widgets/wealthflow_app_bar.dart';
import '../widgets/balance_hero_card.dart';
import '../widgets/income_expense_summary.dart';
import '../widgets/savings_overview_card.dart';
import '../widgets/recent_transactions_section.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback? onViewAllTransactions;

  const DashboardScreen({super.key, this.onViewAllTransactions});

  @override
  Widget build(BuildContext context) {
    final recentTx = sampleTransactions.take(3).toList();

    return Scaffold(
      appBar: const WealthFlowAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.marginMobile,
          vertical: AppSpacing.stackLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BalanceHeroCard(balance: 12450.85, changePercent: 2.5),
            const SizedBox(height: AppSpacing.stackLg),
            const IncomeExpenseSummary(income: 5200.00, expenses: 2840.15),
            const SizedBox(height: AppSpacing.stackLg),
            const SavingsOverviewCard(currentAmount: 13000, goalAmount: 20000),
            const SizedBox(height: AppSpacing.stackLg),
            RecentTransactionsSection(
              transactions: recentTx,
              onViewAll: onViewAllTransactions,
            ),
            const SizedBox(height: 80), // bottom nav space
          ],
        ),
      ),
    );
  }
}

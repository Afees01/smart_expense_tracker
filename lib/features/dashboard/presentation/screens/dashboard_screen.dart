import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_expense_tracker/core/constants/app_spacing.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_state.dart';
import 'package:smart_expense_tracker/shared/models/transaction_model.dart';
import 'package:smart_expense_tracker/shared/widgets/wealthflow_app_bar.dart';

import '../widgets/balance_hero_card.dart';
import '../widgets/income_expense_summary.dart';
import '../widgets/savings_overview_card.dart';
import '../widgets/recent_transactions_section.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback? onViewAllTransactions;

  const DashboardScreen({
    super.key,
    this.onViewAllTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final List<TransactionModel> recentTx;

        if (state is TransactionLoadSuccess) {
          recentTx = state.transactions.take(3).toList();
        } else {
          recentTx = [];
        }

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
                const BalanceHeroCard(
                  balance: 12450.85,
                  changePercent: 2.5,
                ),
                const SizedBox(height: AppSpacing.stackLg),
                const IncomeExpenseSummary(
                  income: 5200.00,
                  expenses: 2840.15,
                ),
                const SizedBox(height: AppSpacing.stackLg),
                const SavingsOverviewCard(
                  currentAmount: 13000,
                  goalAmount: 20000,
                ),
                const SizedBox(height: AppSpacing.stackLg),
                RecentTransactionsSection(
                  transactions: recentTx,
                  onViewAll: onViewAllTransactions,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }
}

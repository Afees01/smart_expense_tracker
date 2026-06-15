import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/bloc/bloc/budget_bloc.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/bloc/bloc/budget_state.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/widgets/budget_category_card.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/widgets/total_budget_summary_card.dart';
import 'package:smart_expense_tracker/shared/widgets/wealthflow_app_bar.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        if (state is BudgetLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is BudgetLoadSuccess) {
          final budgets = state.budgets;

          final totalBudget = budgets.fold<double>(
            0,
            (sum, b) => sum + b.budgeted,
          );

          final spent = budgets.fold<double>(
            0,
            (sum, b) => sum + b.spent,
          );

          return Scaffold(
            appBar: const WealthFlowAppBar(),
            body: Column(
              children: [
                TotalBudgetSummaryCard(
                  totalBudget: totalBudget,
                  spent: spent,
                  period: 'June 2026',
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: budgets.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, index) {
                      return BudgetCategoryCard(
                        budget: budgets[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

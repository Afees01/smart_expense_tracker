import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_expense_tracker/features/budgets/presentation/bloc/bloc/budget_bloc.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/bloc/bloc/budget_state.dart';

import 'package:smart_expense_tracker/features/budgets/presentation/widgets/budget_category_card.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/widgets/total_budget_summary_card.dart';

import 'package:smart_expense_tracker/shared/widgets/wealthflow_app_bar.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        // =====================================================
        // LOADING
        // =====================================================

        if (state is BudgetLoading) {
          return const Scaffold(
            appBar: WealthFlowAppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // =====================================================
        // ERROR
        // =====================================================

        if (state is BudgetLoadFailure) {
          return Scaffold(
            appBar: const WealthFlowAppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Failed to load budgets',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        // Reload can be added here
                      },
                      child: const Text(
                        'Try Again',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // =====================================================
        // SUCCESS
        // =====================================================

        if (state is BudgetLoadSuccess) {
          final budgets = state.budgets;

          // ---------------------------------------------------
          // TOTAL BUDGET
          // ---------------------------------------------------

          final totalBudget = budgets.fold<double>(
            0,
            (sum, budget) {
              return sum + budget.budgeted;
            },
          );

          // ---------------------------------------------------
          // TOTAL SPENT
          // ---------------------------------------------------

          final spent = budgets.fold<double>(
            0,
            (sum, budget) {
              return sum + budget.spent;
            },
          );

          // ---------------------------------------------------
          // MONTH
          // ---------------------------------------------------

          String period = 'August 2026';

          if (budgets.isNotEmpty) {
            final month = budgets.first.month;

            final parts = month.split('-');

            if (parts.length == 2) {
              final year = parts[0];
              final monthNumber =
                  int.tryParse(parts[1]);

              if (monthNumber != null &&
                  monthNumber >= 1 &&
                  monthNumber <= 12) {
                const monthNames = [
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December',
                ];

                period =
                    '${monthNames[monthNumber - 1]} $year';
              }
            }
          }

          // ---------------------------------------------------
          // UI
          // ---------------------------------------------------

          return Scaffold(
            appBar: const WealthFlowAppBar(),

            body: Column(
              children: [
                TotalBudgetSummaryCard(
                  totalBudget: totalBudget,
                  spent: spent,
                  period: period,
                ),

                Expanded(
                  child: budgets.isEmpty
                      ? const Center(
                          child: Text(
                            'No budgets found',
                          ),
                        )
                      : ListView.separated(
                          padding:
                              const EdgeInsets.all(16),

                          itemCount:
                              budgets.length,

                          separatorBuilder:
                              (_, __) =>
                                  const SizedBox(
                            height: 16,
                          ),

                          itemBuilder:
                              (_, index) {
                            return BudgetCategoryCard(
                              budget:
                                  budgets[index],
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        }

        // =====================================================
        // INITIAL
        // =====================================================

        return const Scaffold(
          appBar: WealthFlowAppBar(),
          body: Center(
            child: Text(
              'Loading budgets...',
            ),
          ),
        );
      },
    );
  }
}
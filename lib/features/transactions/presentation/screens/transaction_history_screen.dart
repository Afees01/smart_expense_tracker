import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/core/constants/app_spacing.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_state.dart';
import 'package:smart_expense_tracker/shared/models/transaction_model.dart';
import 'package:smart_expense_tracker/shared/widgets/wealthflow_app_bar.dart';
import '../widgets/transaction_group_section.dart';

enum TransactionFilterType { all, income, expense }

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  TransactionFilterType _filterType = TransactionFilterType.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TransactionModel> _filterTransactions(
      List<TransactionModel> transactions) {
    final query = _searchController.text.trim().toLowerCase();

    return transactions.where((transaction) {
      if (_filterType == TransactionFilterType.income &&
          transaction.type != TransactionType.income) {
        return false;
      }
      if (_filterType == TransactionFilterType.expense &&
          transaction.type != TransactionType.expense) {
        return false;
      }
      if (query.isEmpty) return true;

      return transaction.title.toLowerCase().contains(query) ||
          transaction.subtitle.toLowerCase().contains(query) ||
          transaction.category.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final transactions = state is TransactionLoadSuccess
            ? state.transactions
            : sampleTransactions;
        final filteredTransactions = _filterTransactions(transactions);

        final today = filteredTransactions
            .where((t) =>
                t.date.day == DateTime.now().day &&
                t.date.month == DateTime.now().month)
            .toList();

        final yesterday = filteredTransactions
            .where((t) =>
                t.date.day ==
                    DateTime.now().subtract(const Duration(days: 1)).day &&
                t.date.month == DateTime.now().month)
            .toList();

        final older = filteredTransactions
            .where((t) => t.date
                .isBefore(DateTime.now().subtract(const Duration(days: 1))))
            .toList();

        return Scaffold(
          appBar: const WealthFlowAppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.marginMobile,
              vertical: AppSpacing.stackMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search and Filter Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Search transactions...',
                            hintStyle: AppTextStyles.bodyLg.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.outline,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        final selected =
                            await showModalBottomSheet<TransactionFilterType>(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text('All'),
                                  selected:
                                      _filterType == TransactionFilterType.all,
                                  onTap: () => Navigator.pop(
                                      context, TransactionFilterType.all),
                                ),
                                ListTile(
                                  title: const Text('Income'),
                                  selected: _filterType ==
                                      TransactionFilterType.income,
                                  onTap: () => Navigator.pop(
                                      context, TransactionFilterType.income),
                                ),
                                ListTile(
                                  title: const Text('Expense'),
                                  selected: _filterType ==
                                      TransactionFilterType.expense,
                                  onTap: () => Navigator.pop(
                                      context, TransactionFilterType.expense),
                                ),
                              ],
                            );
                          },
                        );
                        if (selected != null) {
                          setState(() => _filterType = selected);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.filter_list,
                              color: AppColors.onSurfaceVariant,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Filter',
                              style: AppTextStyles.labelMd.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.stackLg),
                if (_searchController.text.isNotEmpty ||
                    _filterType != TransactionFilterType.all)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.stackLg),
                    child: Text(
                      '${filteredTransactions.length} transaction(s) found',
                      style: AppTextStyles.bodyMd
                          .copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ),
                // Groups
                if (today.isNotEmpty) ...[
                  TransactionGroupSection(
                    groupLabel: 'Today',
                    transactions: today,
                    timeLabels: today
                        .map((t) => t.type == TransactionType.income
                            ? '10:15 AM'
                            : '2:45 PM')
                        .toList(),
                  ),
                  const SizedBox(height: AppSpacing.stackLg),
                ],
                if (yesterday.isNotEmpty) ...[
                  TransactionGroupSection(
                    groupLabel: 'Yesterday',
                    transactions: yesterday,
                    timeLabels: yesterday.map((_) => '6:30 PM').toList(),
                  ),
                  const SizedBox(height: AppSpacing.stackLg),
                ],
                if (older.isNotEmpty) ...[
                  TransactionGroupSection(
                    groupLabel: 'October 24',
                    transactions: older.take(2).toList(),
                    timeLabels: ['1:12 PM', '12:30 PM'],
                  ),
                ],
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }
}

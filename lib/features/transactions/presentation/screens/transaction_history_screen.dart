import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_expense_tracker/core/constants/app_spacing.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_state.dart';
import 'package:smart_expense_tracker/features/transactions/data/models/transaction_model.dart';
import 'package:smart_expense_tracker/shared/widgets/wealthflow_app_bar.dart';

import '../widgets/transaction_group_section.dart';

enum TransactionFilterType {
  all,
  income,
  expense,
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({
    super.key,
  });

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
    List<TransactionModel> transactions,
  ) {
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

      if (query.isEmpty) {
        return true;
      }

      return transaction.title.toLowerCase().contains(query) ||
          transaction.subtitle.toLowerCase().contains(query) ||
          transaction.category.toLowerCase().contains(query);
    }).toList();
  }

  bool _isSameDay(
    DateTime first,
    DateTime second,
  ) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  String _formatDate(DateTime date) {
    const months = [
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

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour == 0
        ? 12
        : date.hour > 12
            ? date.hour - 12
            : date.hour;

    final minute = date.minute.toString().padLeft(2, '0');

    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoadInProgress) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is TransactionLoadFailure) {
          return Scaffold(
            appBar: const WealthFlowAppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        final transactions = state is TransactionLoadSuccess
            ? state.transactions
            : <TransactionModel>[];

        final filteredTransactions = _filterTransactions(transactions);

        final now = DateTime.now();

        final today = filteredTransactions
            .where((transaction) => _isSameDay(transaction.date, now))
            .toList();

        final yesterday = filteredTransactions
            .where(
              (transaction) => _isSameDay(
                transaction.date,
                now.subtract(
                  const Duration(days: 1),
                ),
              ),
            )
            .toList();

        final otherTransactions = filteredTransactions.where((transaction) {
          return !_isSameDay(transaction.date, now) &&
              !_isSameDay(
                transaction.date,
                now.subtract(
                  const Duration(days: 1),
                ),
              );
        }).toList();

        // Sort newest first
        today.sort(
          (a, b) => b.date.compareTo(a.date),
        );

        yesterday.sort(
          (a, b) => b.date.compareTo(a.date),
        );

        otherTransactions.sort(
          (a, b) => b.date.compareTo(a.date),
        );

        // Group older/future transactions by actual date
        final Map<String, List<TransactionModel>> groupedOtherTransactions = {};

        for (final transaction in otherTransactions) {
          final key = _formatDate(transaction.date);

          groupedOtherTransactions.putIfAbsent(key, () => []).add(transaction);
        }

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
                // Search + Filter
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.outlineVariant,
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) {
                            setState(() {});
                          },
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
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
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
                                  title: const Text(
                                    'All',
                                  ),
                                  selected:
                                      _filterType == TransactionFilterType.all,
                                  onTap: () => Navigator.pop(
                                    context,
                                    TransactionFilterType.all,
                                  ),
                                ),
                                ListTile(
                                  title: const Text(
                                    'Income',
                                  ),
                                  selected: _filterType ==
                                      TransactionFilterType.income,
                                  onTap: () => Navigator.pop(
                                    context,
                                    TransactionFilterType.income,
                                  ),
                                ),
                                ListTile(
                                  title: const Text(
                                    'Expense',
                                  ),
                                  selected: _filterType ==
                                      TransactionFilterType.expense,
                                  onTap: () => Navigator.pop(
                                    context,
                                    TransactionFilterType.expense,
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (selected != null) {
                          setState(() {
                            _filterType = selected;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.outlineVariant,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.filter_list,
                              color: AppColors.onSurfaceVariant,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
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

                const SizedBox(
                  height: AppSpacing.stackLg,
                ),

                if (_searchController.text.isNotEmpty ||
                    _filterType != TransactionFilterType.all)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSpacing.stackLg,
                    ),
                    child: Text(
                      '${filteredTransactions.length} transaction(s) found',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),

                // Empty state
                if (filteredTransactions.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 80,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 56,
                            color: AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'No transactions found',
                            style: AppTextStyles.headlineMd,
                          ),
                        ],
                      ),
                    ),
                  ),

                // Today
                if (today.isNotEmpty) ...[
                  TransactionGroupSection(
                    groupLabel: 'Today',
                    transactions: today,
                    timeLabels: today
                        .map(
                          (transaction) => _formatTime(
                            transaction.date,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: AppSpacing.stackLg,
                  ),
                ],

                // Yesterday
                if (yesterday.isNotEmpty) ...[
                  TransactionGroupSection(
                    groupLabel: 'Yesterday',
                    transactions: yesterday,
                    timeLabels: yesterday
                        .map(
                          (transaction) => _formatTime(
                            transaction.date,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: AppSpacing.stackLg,
                  ),
                ],

                // All other dates
                ...groupedOtherTransactions.entries.map(
                  (entry) {
                    final groupTransactions = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.stackLg,
                      ),
                      child: TransactionGroupSection(
                        groupLabel: entry.key,
                        transactions: groupTransactions,
                        timeLabels: groupTransactions
                            .map(
                              (transaction) => _formatTime(
                                transaction.date,
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
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

import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';
import 'package:smart_expense_tracker/shared/models/transaction_model.dart';

class RecentTransactionsSection extends StatelessWidget {
  final List<TransactionModel> transactions;
  final VoidCallback? onViewAll;

  const RecentTransactionsSection({
    super.key,
    required this.transactions,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: AppTextStyles.headlineMd,
              ),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'View All',
                  style: AppTextStyles.labelMd.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        if (transactions.isEmpty)
          _buildEmptyState()
        else
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: List.generate(
                transactions.length,
                (index) {
                  final transaction = transactions[index];
                  final isLast =
                      index == transactions.length - 1;

                  return Column(
                    children: [
                      _TransactionTile(
                        transaction: transaction,
                      ),

                      if (!isLast)
                        const Divider(
                          height: 1,
                          color: AppColors.surfaceVariant,
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48,
            color: AppColors.onSurfaceVariant,
          ),

          const SizedBox(height: 12),

          Text(
            'No transactions yet',
            style: AppTextStyles.bodyLg,
          ),

          const SizedBox(height: 4),

          Text(
            'Your recent transactions will appear here.',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const _TransactionTile({
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncome =
        transaction.type == TransactionType.income;

    final Color amountColor =
        isIncome
            ? AppColors.primary
            : AppColors.error;

    final Color iconBg =
        isIncome
            ? AppColors.primaryContainer
            : AppColors.secondaryContainer;

    final Color iconColor =
        isIncome
            ? AppColors.onPrimary
            : AppColors.onSecondaryContainer;

    final IconData icon =
        _getCategoryIcon(transaction.category);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO: Open transaction details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: iconBg,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLg.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      transaction.subtitle.isNotEmpty
                          ? transaction.subtitle
                          : transaction.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Text(
                '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                style: AppTextStyles.numericData.copyWith(
                  color: amountColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
      case 'restaurant':
      case 'grocery':
        return Icons.restaurant;

      case 'shopping':
        return Icons.shopping_bag;

      case 'transport':
      case 'transportation':
        return Icons.directions_car;

      case 'entertainment':
        return Icons.movie;

      case 'bills':
      case 'bill':
        return Icons.receipt_long;

      case 'health':
      case 'medical':
        return Icons.medical_services;

      case 'home':
      case 'rent':
        return Icons.home;

      case 'salary':
        return Icons.account_balance_wallet;

      case 'investment':
        return Icons.trending_up;

      case 'education':
        return Icons.school;

      case 'travel':
        return Icons.flight;

      default:
        return Icons.receipt_long;
    }
  }
}
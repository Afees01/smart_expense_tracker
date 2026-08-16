import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';
import 'package:smart_expense_tracker/shared/models/transaction_model.dart';

class TransactionListTile extends StatelessWidget {
  final TransactionModel transaction;
  final String timeLabel;

  const TransactionListTile({
    super.key,
    required this.transaction,
    required this.timeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncome = transaction.type == TransactionType.income;

    final Color amountColor = isIncome ? AppColors.primary : AppColors.error;

    final Color iconBg = isIncome
        ? AppColors.primaryContainer.withOpacity(0.15)
        : AppColors.secondaryContainer.withOpacity(0.3);

    final Color iconColor =
        isIncome ? AppColors.primaryContainer : AppColors.onSecondaryContainer;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: iconBg,
                child: Icon(
                  _getCategoryIcon(transaction.category),
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                    style: AppTextStyles.numericData.copyWith(
                      color: amountColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    timeLabel,
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.outline,
                    ),
                  ),
                ],
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
      case 'dining':
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

      case 'freelance':
        return Icons.work;

      case 'other':
        return Icons.category;
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

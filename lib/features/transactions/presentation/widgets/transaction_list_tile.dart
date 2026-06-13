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
    final isIncome = transaction.type == TransactionType.income;
    final amountColor = isIncome ? AppColors.primary : AppColors.error;
    final iconBg = isIncome
        ? AppColors.primaryContainer.withOpacity(0.15)
        : AppColors.secondaryContainer.withOpacity(0.3);
    final iconColor = isIncome ? AppColors.primaryContainer : AppColors.onSecondaryContainer;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: iconBg,
                child: Icon(transaction.icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      transaction.subtitle,
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                    style: AppTextStyles.numericData.copyWith(color: amountColor),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    timeLabel,
                    style: AppTextStyles.labelMd.copyWith(color: AppColors.outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

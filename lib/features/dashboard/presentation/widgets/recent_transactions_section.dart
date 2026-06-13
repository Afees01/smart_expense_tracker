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
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions', style: AppTextStyles.headlineMd),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'View All',
                  style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            children: List.generate(transactions.length, (i) {
              final tx = transactions[i];
              final isLast = i == transactions.length - 1;
              return Column(
                children: [
                  _TransactionTile(transaction: tx),
                  if (!isLast)
                    const Divider(
                      height: 1,
                      color: AppColors.surfaceVariant,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final amountColor = isIncome ? AppColors.primary : AppColors.error;
    final iconBg = isIncome ? AppColors.primaryContainer : AppColors.secondaryContainer;
    final iconColor = isIncome ? AppColors.onPrimary : AppColors.onSecondaryContainer;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: iconBg,
                child: Icon(transaction.icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: AppTextStyles.bodyLg.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
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
              Text(
                '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                style: AppTextStyles.numericData.copyWith(color: amountColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';
import 'package:smart_expense_tracker/shared/models/transaction_model.dart';
import 'transaction_list_tile.dart';

class TransactionGroupSection extends StatelessWidget {
  final String groupLabel;
  final List<TransactionModel> transactions;
  final List<String> timeLabels;

  const TransactionGroupSection({
    super.key,
    required this.groupLabel,
    required this.transactions,
    required this.timeLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            groupLabel.toUpperCase(),
            style: AppTextStyles.labelMd.copyWith(color: AppColors.outline),
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
                  TransactionListTile(
                    transaction: tx,
                    timeLabel: timeLabels[i],
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
            }),
          ),
        ),
      ],
    );
  }
}

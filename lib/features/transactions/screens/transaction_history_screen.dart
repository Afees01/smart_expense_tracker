import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/models/transaction_model.dart';
import '../../../shared/widgets/wealthflow_app_bar.dart';
import '../widgets/transaction_group_section.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = sampleTransactions.where((t) =>
        t.date.day == DateTime.now().day &&
        t.date.month == DateTime.now().month).toList();

    final yesterday = sampleTransactions.where((t) =>
        t.date.day == DateTime.now().subtract(const Duration(days: 1)).day &&
        t.date.month == DateTime.now().month).toList();

    final older = sampleTransactions.where((t) =>
        t.date.isBefore(DateTime.now().subtract(const Duration(days: 1)))).toList();

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
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              ],
            ),
            const SizedBox(height: AppSpacing.stackLg),

            // Groups
            if (today.isNotEmpty) ...[
              TransactionGroupSection(
                groupLabel: 'Today',
                transactions: today,
                timeLabels: today.map((t) =>
                    t.type == TransactionType.income ? '10:15 AM' : '2:45 PM').toList(),
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
  }
}

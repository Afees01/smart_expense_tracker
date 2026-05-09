import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum BudgetStatus { onTrack, nearLimit, overspent }

class BudgetModel {
  final String id;
  final String title;
  final double budgeted;
  final double spent;
  final IconData icon;

  const BudgetModel({
    required this.id,
    required this.title,
    required this.budgeted,
    required this.spent,
    required this.icon,
  });

  double get percentage => (spent / budgeted).clamp(0, 1);
  double get percentageValue => (spent / budgeted * 100).clamp(0, 999);
  double get remaining => (budgeted - spent).clamp(0, double.infinity);
  double get overspentBy => spent > budgeted ? spent - budgeted : 0;

  BudgetStatus get status {
    if (percentageValue > 100) return BudgetStatus.overspent;
    if (percentageValue >= 80) return BudgetStatus.nearLimit;
    return BudgetStatus.onTrack;
  }

  Color get statusColor {
    switch (status) {
      case BudgetStatus.onTrack:
        return AppColors.primary;
      case BudgetStatus.nearLimit:
        return AppColors.amber400;
      case BudgetStatus.overspent:
        return AppColors.error;
    }
  }

  Color get borderColor => statusColor;

  String get statusLabel {
    switch (status) {
      case BudgetStatus.onTrack:
        return 'On Track';
      case BudgetStatus.nearLimit:
        return 'Near Limit';
      case BudgetStatus.overspent:
        return 'Overspent by \$${overspentBy.toStringAsFixed(2)}';
    }
  }

  Color get iconBgColor {
    switch (status) {
      case BudgetStatus.onTrack:
        return AppColors.secondaryContainer;
      case BudgetStatus.nearLimit:
        return AppColors.amber100;
      case BudgetStatus.overspent:
        return AppColors.errorContainer;
    }
  }

  Color get iconColor {
    switch (status) {
      case BudgetStatus.onTrack:
        return AppColors.onSecondaryContainer;
      case BudgetStatus.nearLimit:
        return AppColors.amber700;
      case BudgetStatus.overspent:
        return AppColors.onErrorContainer;
    }
  }
}

final List<BudgetModel> sampleBudgets = [
  BudgetModel(
    id: '1',
    title: 'Groceries',
    budgeted: 600.00,
    spent: 325.40,
    icon: Icons.shopping_cart_outlined,
  ),
  BudgetModel(
    id: '2',
    title: 'Entertainment',
    budgeted: 250.00,
    spent: 215.00,
    icon: Icons.theater_comedy_outlined,
  ),
  BudgetModel(
    id: '3',
    title: 'Transport',
    budgeted: 150.00,
    spent: 182.20,
    icon: Icons.commute_outlined,
  ),
  BudgetModel(
    id: '4',
    title: 'Dining Out',
    budgeted: 400.00,
    spent: 120.00,
    icon: Icons.restaurant_outlined,
  ),
];

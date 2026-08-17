import 'package:flutter/material.dart';

enum BudgetStatus {
  onTrack,
  overspent,
}

class BudgetModel {
  final int id;
  final String title;
  final double budgeted;
  final double spent;
  final String category;
  final String month;
  final BudgetStatus status;
  final double remaining;

  BudgetModel({
    required this.id,
    required this.title,
    required this.budgeted,
    required this.spent,
    required this.category,
    required this.month,
    required this.status,
    required this.remaining,
  });

  factory BudgetModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return BudgetModel(
      id: json['id'] as int,
      title: json['title'] ?? '',
      budgeted: (json['budgeted'] as num).toDouble(),
      spent: (json['spent'] as num).toDouble(),
      category: json['category'] ?? '',
      month: json['month'] ?? '',
      status: json['status'] == 'overspent'
          ? BudgetStatus.overspent
          : BudgetStatus.onTrack,
      remaining: (json['remaining'] as num).toDouble(),
    );
  }

  // ============================================================
  // PERCENTAGE
  // ============================================================

  double get percentage {
    if (budgeted <= 0) {
      return 0;
    }

    return (spent / budgeted).clamp(0.0, 1.0);
  }

  double get percentageValue {
    if (budgeted <= 0) {
      return 0;
    }

    return (spent / budgeted) * 100;
  }

  // ============================================================
  // STATUS
  // ============================================================

  String get statusLabel {
    switch (status) {
      case BudgetStatus.onTrack:
        return 'On Track';

      case BudgetStatus.overspent:
        return 'Overspent';
    }
  }

  Color get statusColor {
    switch (status) {
      case BudgetStatus.onTrack:
        return const Color(0xFF006C49);

      case BudgetStatus.overspent:
        return const Color(0xFFBA1A1A);
    }
  }

  // ============================================================
  // CATEGORY ICON
  // ============================================================

  IconData get icon {
    switch (category.toLowerCase()) {
      case 'food':
      case 'grocery':
        return Icons.restaurant;

      case 'dining':
      case 'restaurant':
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

      case 'rent':
      case 'home':
        return Icons.home;

      case 'education':
        return Icons.school;

      case 'travel':
        return Icons.flight;

      case 'investment':
        return Icons.trending_up;

      case 'freelance':
        return Icons.work_outline;

      default:
        return Icons.account_balance_wallet_outlined;
    }
  }

  // ============================================================
  // ICON COLOR
  // ============================================================

  Color get iconColor {
    switch (category.toLowerCase()) {
      case 'food':
      case 'grocery':
      case 'dining':
      case 'restaurant':
        return const Color(0xFFE65100);

      case 'shopping':
        return const Color(0xFF7B1FA2);

      case 'transport':
      case 'transportation':
        return const Color(0xFF1565C0);

      case 'entertainment':
        return const Color(0xFFC62828);

      case 'bills':
      case 'bill':
        return const Color(0xFF6A1B9A);

      case 'health':
      case 'medical':
        return const Color(0xFF00838F);

      case 'rent':
      case 'home':
        return const Color(0xFF4527A0);

      case 'education':
        return const Color(0xFF2E7D32);

      case 'travel':
        return const Color(0xFF0277BD);

      case 'investment':
        return const Color(0xFF00695C);

      case 'freelance':
        return const Color(0xFFEF6C00);

      default:
        return const Color(0xFF006C49);
    }
  }

  // ============================================================
  // ICON BACKGROUND
  // ============================================================

  Color get iconBgColor {
    return iconColor.withOpacity(0.12);
  }

  // ============================================================
  // LEFT BORDER COLOR
  // ============================================================

  Color get borderColor {
    return statusColor;
  }

  // ============================================================
  // JSON
  // ============================================================

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'budgeted': budgeted,
      'spent': spent,
      'category': category,
      'month': month,
      'status': status == BudgetStatus.overspent
          ? 'overspent'
          : 'onTrack',
      'remaining': remaining,
    };
  }
}
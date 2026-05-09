import 'package:flutter/material.dart';

enum TransactionType { income, expense }

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String category;
  final IconData icon;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
    required this.icon,
  });
}

// Sample data
final List<TransactionModel> sampleTransactions = [
  TransactionModel(
    id: '1',
    title: 'Whole Foods Market',
    subtitle: 'Visa ending in 4291',
    amount: 142.50,
    type: TransactionType.expense,
    date: DateTime.now(),
    category: 'Groceries',
    icon: Icons.shopping_bag_outlined,
  ),
  TransactionModel(
    id: '2',
    title: 'Client Retainer - Acme Corp',
    subtitle: 'Direct Deposit',
    amount: 2500.00,
    type: TransactionType.income,
    date: DateTime.now(),
    category: 'Income',
    icon: Icons.payments_outlined,
  ),
  TransactionModel(
    id: '3',
    title: 'Tesla Supercharger',
    subtitle: 'Mastercard ending in 0023',
    amount: 24.80,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 1)),
    category: 'Transport',
    icon: Icons.directions_car_outlined,
  ),
  TransactionModel(
    id: '4',
    title: 'Apple Store',
    subtitle: 'Apple Pay',
    amount: 1299.00,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 2)),
    category: 'Shopping',
    icon: Icons.home_repair_service_outlined,
  ),
  TransactionModel(
    id: '5',
    title: 'The Green Bistro',
    subtitle: 'Visa ending in 4291',
    amount: 86.42,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 2)),
    category: 'Dining',
    icon: Icons.restaurant_outlined,
  ),
  TransactionModel(
    id: '6',
    title: 'Starbucks',
    subtitle: 'Today, 08:45 AM',
    amount: 5.50,
    type: TransactionType.expense,
    date: DateTime.now(),
    category: 'Food',
    icon: Icons.local_cafe_outlined,
  ),
  TransactionModel(
    id: '7',
    title: 'Salary',
    subtitle: 'Yesterday, 09:00 AM',
    amount: 3500.00,
    type: TransactionType.income,
    date: DateTime.now().subtract(const Duration(days: 1)),
    category: 'Income',
    icon: Icons.payments_outlined,
  ),
  TransactionModel(
    id: '8',
    title: 'Rent',
    subtitle: 'Sep 1, 2023',
    amount: 1200.00,
    type: TransactionType.expense,
    date: DateTime.now().subtract(const Duration(days: 30)),
    category: 'Housing',
    icon: Icons.home_outlined,
  ),
];

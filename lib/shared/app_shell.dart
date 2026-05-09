import 'package:flutter/material.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/transactions/screens/transaction_history_screen.dart';
import '../features/add_transaction/screens/add_transaction_screen.dart';
import '../features/budgets/screens/budgets_screen.dart';
import '../features/analytics/screens/analytics_screen.dart';
import 'widgets/bottom_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _navigateTo(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardScreen(onViewAllTransactions: () => _navigateTo(1)),
          const TransactionHistoryScreen(),
          const AddTransactionScreen(),
          const BudgetsScreen(),
          const AnalyticsScreen(),
        ],
      ),
      bottomNavigationBar: WealthFlowBottomNav(
        currentIndex: _currentIndex,
        onTap: _navigateTo,
      ),
    );
  }
}

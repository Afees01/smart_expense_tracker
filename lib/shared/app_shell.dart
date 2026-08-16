import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/features/add_transaction/presentation/screens/add_transaction_screen.dart';
import 'package:smart_expense_tracker/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/screens/budgets_screen.dart';
import 'package:smart_expense_tracker/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:smart_expense_tracker/features/transactions/data/usecases/get_transactions.dart';
import 'package:smart_expense_tracker/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:smart_expense_tracker/features/transactions/data/datasources/transaction_remote_data_source.dart';
import 'package:smart_expense_tracker/core/network/network_client.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/screens/transaction_history_screen.dart';
import 'package:smart_expense_tracker/shared/widgets/bottom_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;
  late final TransactionBloc _transactionBloc;

  @override
  void initState() {
    super.initState();
    _transactionBloc = TransactionBloc(
      getTransactions: GetTransactions(
        TransactionRepositoryImpl(
          remoteDataSource: TransactionRemoteDataSource(
            client: NetworkClient(),
          ),
        ),
      ),
    )..add(const LoadTransactions(limit: 1000, page: 1));
  }

  @override
  void dispose() {
    _transactionBloc.close();
    super.dispose();
  }

  void _navigateTo(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _transactionBloc,
      child: Scaffold(
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
      ),
    );
  }
}

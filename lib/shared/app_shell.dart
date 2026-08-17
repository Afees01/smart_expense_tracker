import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// AUTH
// ============================================================

import 'package:smart_expense_tracker/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:smart_expense_tracker/features/auth/presentation/bloc/bloc/auth_state.dart';
import 'package:smart_expense_tracker/features/auth/presentation/screens/Loginscreen.dart';

// ============================================================
// TRANSACTIONS
// ============================================================

import 'package:smart_expense_tracker/features/transactions/data/usecases/create_trasactions.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:smart_expense_tracker/features/transactions/data/usecases/get_transactions.dart';
import 'package:smart_expense_tracker/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:smart_expense_tracker/features/transactions/data/datasources/transaction_remote_data_source.dart';
import 'package:smart_expense_tracker/core/network/network_client.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/screens/transaction_history_screen.dart';

// ============================================================
// OTHER SCREENS
// ============================================================

import 'package:smart_expense_tracker/features/add_transaction/presentation/screens/add_transaction_screen.dart';
import 'package:smart_expense_tracker/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/screens/budgets_screen.dart';
import 'package:smart_expense_tracker/features/dashboard/presentation/screens/dashboard_screen.dart';

import 'package:smart_expense_tracker/shared/widgets/bottom_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  late final TransactionBloc _transactionBloc;

  @override
  void initState() {
    super.initState();

    // ========================================================
    // TRANSACTION REPOSITORY
    // ========================================================

    final repository = TransactionRepositoryImpl(
      remoteDataSource: TransactionRemoteDataSource(
        client: NetworkClient(),
      ),
    );

    // ========================================================
    // TRANSACTION BLOC
    // ========================================================

    _transactionBloc = TransactionBloc(
      getTransactions: GetTransactions(
        repository,
      ),
      createTransaction: CreateTransaction(
        repository,
      ),
    );

    // ========================================================
    // LOAD TRANSACTIONS
    // ========================================================

    _transactionBloc.add(
      const LoadTransactions(
        limit: 20,
        page: 1,
      ),
    );
  }

  @override
  void dispose() {
    _transactionBloc.close();
    super.dispose();
  }

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      // ======================================================
      // LISTEN FOR AUTH STATE CHANGES
      // ======================================================

      listener: (context, state) {
        // ----------------------------------------------------
        // LOGOUT SUCCESS
        // ----------------------------------------------------

        if (state is AuthUnauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }

        // ----------------------------------------------------
        // AUTH ERROR
        // ----------------------------------------------------

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
              ),
            ),
          );
        }
      },

      // ======================================================
      // TRANSACTION BLOC PROVIDER
      // ======================================================

      child: BlocProvider.value(
        value: _transactionBloc,
        child: Scaffold(
          // ==================================================
          // SCREENS
          // ==================================================

          body: IndexedStack(
            index: _currentIndex,
            children: [
              // Dashboard
              DashboardScreen(
                onViewAllTransactions: () {
                  _navigateTo(1);
                },
              ),

              // Transaction History
              const TransactionHistoryScreen(),

              // Add Transaction
              const AddTransactionScreen(),

              // Budgets
              const BudgetsScreen(),

              // Analytics
              const AnalyticsScreen(),
            ],
          ),

          // ==================================================
          // BOTTOM NAVIGATION
          // ==================================================

          bottomNavigationBar: WealthFlowBottomNav(
            currentIndex: _currentIndex,
            onTap: _navigateTo,
          ),
        ),
      ),
    );
  }
}

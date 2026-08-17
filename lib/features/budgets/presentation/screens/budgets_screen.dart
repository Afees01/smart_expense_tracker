import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_expense_tracker/core/network/network_client.dart';

import 'package:smart_expense_tracker/features/budgets/data/datasources/budget_remote_datasource.dart';
import 'package:smart_expense_tracker/features/budgets/data/repositories/budget_repository_imp.dart';

import 'package:smart_expense_tracker/features/budgets/presentation/bloc/bloc/budget_bloc.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/bloc/bloc/budget_event.dart';

import 'package:smart_expense_tracker/features/budgets/presentation/screens/budget_view.dart';

class BudgetsScreen extends StatelessWidget {
  const BudgetsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BudgetBloc>(
      create: (_) {
        final budgetRepository = BudgetRepositoryImp(
          BudgetRemoteDatasource(
            client: NetworkClient(),
          ),
        );

        return BudgetBloc(
          repository: budgetRepository,
        )..add(
            const LoadBudgets(
              month: '2026-08',
            ),
          );
      },
      child: const BudgetView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/bloc/bloc/budget_bloc.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/bloc/bloc/budget_event.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/screens/budget_view.dart';

class BudgetsScreen extends StatelessWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BudgetBloc()
        ..add( LoadBudgets()),
      child: const BudgetView(),
    );
  }
}
import 'package:smart_expense_tracker/features/budgets/data/datasources/budget_remote_datasource.dart';
import 'package:smart_expense_tracker/features/budgets/data/models/budget_model.dart';
import 'package:smart_expense_tracker/features/budgets/presentation/repositories/budget_repository.dart';

class BudgetRepositoryImp implements BudgetRepository {
  final BudgetRemoteDatasource remotedatasource;

  BudgetRepositoryImp(this.remotedatasource);

  @override
  Future<List<BudgetModel>> getbudget({String? month}) async {
    return await remotedatasource.fetchbuget(month: month);
  }
}

import 'package:smart_expense_tracker/features/transactions/data/models/transaction_model.dart';
import '../../presentation/repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<TransactionModel>> call({
    int limit = 20,
    int page = 1,
    String? type,
    String? category,
    String? startDate,
    String? endDate,
  }) {
    return repository.getTransactions(
      limit: limit,
      page: page,
      type: type,
      category: category,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
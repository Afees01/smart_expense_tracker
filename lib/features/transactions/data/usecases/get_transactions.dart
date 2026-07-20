import '../../../../shared/models/transaction_model.dart';
import '../../presentation/repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<List<TransactionModel>> call({
    int limit = 20,
    String type = 'all',
    String userId = '123',
  }) {
    return repository.getTransactions(limit: limit, type: type, userId: userId);
  }
}

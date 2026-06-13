import '../../../../shared/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionModel>> getTransactions({
    int limit = 20,
    String type = 'all',
    String userId = '123',
  });
}

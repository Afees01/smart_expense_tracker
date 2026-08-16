import '../../../../shared/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionModel>> getTransactions({
    int limit = 20,
    int page = 1,
    String? type,
    String? category,
    String? startDate,
    String? endDate,
  });
}




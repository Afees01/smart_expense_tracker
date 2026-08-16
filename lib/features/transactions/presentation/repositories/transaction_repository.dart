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

  Future<TransactionModel> addTransaction({
    required String title,
    required String subtitle,
    required double amount,
    required TransactionType type,
    required DateTime date,
    required String category,
  });
}




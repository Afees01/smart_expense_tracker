import 'package:smart_expense_tracker/features/transactions/data/datasources/transaction_remote_data_source.dart';
import 'package:smart_expense_tracker/features/transactions/presentation/repositories/transaction_repository.dart';
import 'package:smart_expense_tracker/shared/models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<TransactionModel>> getTransactions({
    int limit = 20,
    int page = 1,
    String? type,
    String? category,
    String? startDate,
    String? endDate,
  }) async {
    return await remoteDataSource.fetchTransactions(
      limit: limit,
      page: page,
      type: type,
      category: category,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
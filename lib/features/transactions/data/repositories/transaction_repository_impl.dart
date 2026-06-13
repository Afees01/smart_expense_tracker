import '../../../../shared/models/transaction_model.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_remote_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TransactionModel>> getTransactions({
    int limit = 20,
    String type = 'all',
    String userId = '123',
  }) async {
    try {
      return await remoteDataSource.fetchTransactions(
        limit: limit,
        type: type,
        userId: userId,
      );
    } catch (_) {
      return sampleTransactions;
    }
  }
}

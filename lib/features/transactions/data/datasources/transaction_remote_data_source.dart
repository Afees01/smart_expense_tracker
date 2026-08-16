import 'package:smart_expense_tracker/core/network/network_client.dart';
import 'package:smart_expense_tracker/shared/models/transaction_model.dart';

class TransactionRemoteDataSource {
  final NetworkClient client;

  TransactionRemoteDataSource({
    required this.client,
  });

  Future<List<TransactionModel>> fetchTransactions({
    int limit = 20,
    int page = 1,
    String? type,
    String? category,
    String? startDate,
    String? endDate,
  }) async {
    final response = await client.get(
      '/transactions',
      queryparameters: {
        'limit': limit,
        'page': page,
        if (type != null && type != 'all') 'type': type,
        if (category != null) 'category': category,
        if (startDate != null) 'startDate': startDate,
        if (endDate != null) 'endDate': endDate,
      },
    );

    final responseData = response.data;

    if (responseData['success'] != true) {
      throw Exception(
        responseData['message'] ??
            'Failed to load transactions',
      );
    }

    final List<dynamic> transactionData =
        responseData['data'] ?? [];

    return transactionData
        .map(
          (json) => TransactionModel.fromJson(
            Map<String, dynamic>.from(json),
          ),
        )
        .toList();
  }

  Future<TransactionModel> addTransaction({
    required String title,
    required String subtitle,
    required double amount,
    required TransactionType type,
    required DateTime date,
    required String category,
  }) async {
    final response = await client.post(
      '/transactions',
      {
        'title': title,
        'subtitle': subtitle,
        'amount': amount,
        'type': type.name,
        'date': date.toUtc().toIso8601String(),
        'category': category,
      },
    );

    final responseData = response.data;

    if (responseData['success'] != true) {
      throw Exception(
        responseData['message'] ??
            'Failed to create transaction',
      );
    }

    return TransactionModel.fromJson(
      Map<String, dynamic>.from(
        responseData['data'],
      ),
    );
  }
}
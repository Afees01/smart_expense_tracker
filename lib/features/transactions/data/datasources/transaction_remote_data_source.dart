import 'dart:convert';

import '../../../../core/network/network_client.dart';
import '../../../../shared/models/transaction_model.dart';

class TransactionRemoteDataSource {
  final NetworkClient client;

  TransactionRemoteDataSource({required this.client});

  /// Fake API endpoint example:
  /// https://api.example.com/transactions?userId=123&limit=20&type=all
  ///
  /// Request parameters:
  /// - userId: id of the current user
  /// - limit: number of transactions to return
  /// - type: filter by transaction type ('all', 'income', 'expense')
  Future<List<TransactionModel>> fetchTransactions({
    int limit = 20,
    String type = 'all',
    String userId = '123',
  }) async {
    final uri = Uri.https(
      'api.example.com',
      '/transactions',
      {
        'userId': userId,
        'limit': '$limit',
        'type': type,
      },
    );

    final response = await client.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer FAKE_TOKEN_123',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Transaction API error: ${response.statusCode}');
    }

    final jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList
        .map((jsonItem) =>
            TransactionModel.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  }
}

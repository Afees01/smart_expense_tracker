
import 'package:smart_expense_tracker/core/network/network_client.dart';
import 'package:smart_expense_tracker/features/budgets/data/models/budget_model.dart';

class BudgetRemoteDatasource {
  final NetworkClient client;

  BudgetRemoteDatasource(
  {  required this.client,}
  );

  Future<List<BudgetModel>> fetchbuget({String? month}) async {
    final response = await client.get('/budgets', queryparameters: {
      if (month != null && month.isNotEmpty) "month": month
    });
    final responsedata = response.data;
    if (responsedata['success'] != true) {
      throw Exception(responsedata['message'] ?? 'Failed to load budegt');
    }

    final List<dynamic> budgetdata = responsedata['data'] ?? [];
    return budgetdata
        .map(
          (json) => BudgetModel.fromJson(
            Map<String, dynamic>.from(json),
          ),
        )
        .toList();
  }
}

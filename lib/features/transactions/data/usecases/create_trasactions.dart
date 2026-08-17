import 'package:smart_expense_tracker/features/transactions/data/models/transaction_model.dart';
import '../../presentation/repositories/transaction_repository.dart';

class CreateTransaction {
  final TransactionRepository repository;

  CreateTransaction(this.repository);

  Future<TransactionModel> call({
    required String title,
    required String subtitle,
    required double amount,
    required TransactionType type,
    required DateTime date,
    required String category,
  }) {
    return repository.addTransaction(
      title: title,
      subtitle: subtitle,
      amount: amount,
      type: type,
      date: date,
      category: category,
    );
  }
}
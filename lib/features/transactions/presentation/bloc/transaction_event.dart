import '../../../../shared/models/transaction_model.dart';

abstract class TransactionEvent {
  const TransactionEvent();
}

class LoadTransactions extends TransactionEvent {
  final int limit;
  final String type;
  final String userId;

  const LoadTransactions(
      {this.limit = 20, this.type = 'all', this.userId = '123'});
}

class AddTransaction extends TransactionEvent {
  final TransactionModel transaction;

  const AddTransaction(this.transaction);
}

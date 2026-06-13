import '../../../../shared/models/transaction_model.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoadInProgress extends TransactionState {}

class TransactionLoadSuccess extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionLoadSuccess(this.transactions);
}

class TransactionLoadFailure extends TransactionState {
  final String message;

  TransactionLoadFailure(this.message);
}

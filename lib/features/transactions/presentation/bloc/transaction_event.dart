import 'package:equatable/equatable.dart';

import '../../data/models/transaction_model.dart';

abstract class TransactionEvent  extends Equatable{
  const TransactionEvent();
    @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {
  final int limit;
  final int page;
  final String? type;
  final String? category;
  final String? startDate;
  final String? endDate;

  const LoadTransactions({
    this.limit = 20,
    this.page = 1,
    this.type,
    this.category,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [
        limit,
        page,
        type,
        category,
        startDate,
        endDate,
      ];
}

class AddTransaction extends TransactionEvent {
  final TransactionModel transaction;

  const AddTransaction(this.transaction);

   @override
  List<Object?> get props => [
        transaction,
      ];

}

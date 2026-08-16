import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/usecases/get_transactions.dart';
import '../../../../shared/models/transaction_model.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;

  TransactionBloc({required this.getTransactions})
      : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoadInProgress());

    try {
      final transactions = await getTransactions(
        limit: event.limit,
        page: event.page,
        type: event.type,
        category: event.category,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(TransactionLoadSuccess(transactions));
    } catch (error) {
      emit(TransactionLoadFailure(error.toString()));
    }
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    final currentState = state;
    if (currentState is TransactionLoadSuccess) {
      final updated = List<TransactionModel>.from(currentState.transactions)
        ..insert(0, event.transaction);
      emit(TransactionLoadSuccess(updated));
    } else if (currentState is TransactionLoadFailure ||
        currentState is TransactionInitial ||
        currentState is TransactionLoadInProgress) {
      emit(TransactionLoadSuccess([event.transaction]));
    }
  }
}

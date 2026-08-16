import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/features/transactions/data/usecases/create_trasactions.dart';

import '../../data/usecases/get_transactions.dart';
import '../../../../shared/models/transaction_model.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;
    final CreateTransaction createTransaction;


  TransactionBloc({required this.getTransactions, required this.createTransaction})
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
    try {
      // Send transaction to API
      final createdTransaction =
          await createTransaction(
        title: event.transaction.title,
        subtitle: event.transaction.subtitle,
        amount: event.transaction.amount,
        type: event.transaction.type,
        date: event.transaction.date,
        category: event.transaction.category,
      );

      // Add the API-created transaction to the current list
      final currentState = state;

      if (currentState is TransactionLoadSuccess) {
        final updated =
            List<TransactionModel>.from(
          currentState.transactions,
        )..insert(
            0,
            createdTransaction,
          );

        emit(
          TransactionLoadSuccess(updated),
        );
      } else {
        emit(
          TransactionLoadSuccess(
            [createdTransaction],
          ),
        );
      }
    } catch (error) {
      emit(
        TransactionLoadFailure(
          error.toString(),
        ),
      );
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/features/auth/presentation/repositories/auth_repository.dart';
import 'package:smart_expense_tracker/features/auth/presentation/bloc/bloc/auth_event.dart';
import 'package:smart_expense_tracker/features/auth/presentation/bloc/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository)
      : super(AuthInitial()) {

    on<LoginRequested>(_login);
    on<RegisterRequested>(_signUp);
    on<LogoutRequested>(_logout);
  }

  Future<void> _login(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {

    emit(AuthLoading());

    try {
      await repository.login(
        event.email,
        event.password,
      );

      emit(AuthAuthenticated());
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }

  Future<void> _signUp(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {

    emit(AuthLoading());

    try {
      await repository.signUp(
        event.name,
        event.email,
        event.password,
      );

      emit(AuthAuthenticated());
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }
  
  Future<void> _logout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await repository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }


}
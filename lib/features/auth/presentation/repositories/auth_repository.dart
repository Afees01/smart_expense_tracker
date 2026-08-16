import 'package:smart_expense_tracker/features/auth/data/datasources/AuthRemoteDataSource.dart';

class AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepository({required this.dataSource});

  Future<void> login(
    String email,
    String password,
  ) {
    return dataSource.login(email, password);
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
  ) {
    return dataSource.register(name, email, password);
  }
}

class AuthRepository {

  Future<void> login(
    String email,
    String password,
  ) async {

    // Call API here
    await Future.delayed(
      const Duration(seconds: 2),
    );
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
  ) async {

    // Call API here
    await Future.delayed(
      const Duration(seconds: 2),
    );
  }
}
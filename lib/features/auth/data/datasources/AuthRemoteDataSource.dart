class AuthRemoteDataSource {
  Future<void> login(
    String email,
    String password,
  ) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (email != "admin" || password != "123") {
      throw Exception("Invalid credentials");
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
  ) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
  }
}

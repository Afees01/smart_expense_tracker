import 'package:smart_expense_tracker/core/network/network_client.dart';
import 'package:smart_expense_tracker/core/network/securetoken.dart';
import 'package:smart_expense_tracker/features/auth/data/models/loginmodel.dart';

class AuthRemoteDataSource {
  final NetworkClient networkClient;
  final Securetoken securetoken;

  AuthRemoteDataSource(this.networkClient, this.securetoken);
  Future<Loginmodel> login(
    String email,
    String password,
  ) async {
    final data = {"email": email, "password": password};
    try {
      final response = await networkClient.post("/auth/login", data);
      final loginmodel = Loginmodel.fromJson(response.data);
      await securetoken.savetoken(loginmodel.token);
      return loginmodel;
    } catch (e) {
      throw Exception("Login Failed$e");
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
  ) async {
    final data = {
      "name": name,
      "email": email,
      "password": password,
    };

    try {
      await networkClient.post(
        "/auth/register",
        data,
      );
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }
  
  Future<void> logout() async {
    try {
      await networkClient.post("/auth/logout", {});
      await securetoken.deleteToken();
    } catch (e) {
      throw Exception("Logout failed: $e");
    }
  }

}

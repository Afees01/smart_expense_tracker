import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Securetoken {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String token = "token";

  Future<void> savetoken(String jwttoken) async {
    await _secureStorage.write(key: token, value: jwttoken);
  }

  Future<String?> gettoken() async {
    return await _secureStorage.read(key: token);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(
      key: token,
    );
  }
}

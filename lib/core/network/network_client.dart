import 'package:http/http.dart' as http;

class NetworkClient {
  final http.Client client;

  NetworkClient({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) {
    return client.get(uri, headers: headers);
  }
}

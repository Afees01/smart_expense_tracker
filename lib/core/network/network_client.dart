import 'package:dio/dio.dart';
import 'package:smart_expense_tracker/core/network/securetoken.dart';

class NetworkClient {
  late final Dio dio;
  static const String baseUrl = "https://afeesbackendsmart.vercel.app/api/v1";

  NetworkClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = Securetoken();
        final token = await prefs.gettoken();

        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }

        print("REQUEST => ${options.method} ${options.uri}");
        print("Headers => ${options.headers}");
        print("Body => ${options.data}");
        handler.next(options);
      },
      onResponse: (response, handler) {
        print("response $response");
        handler.next(response);
      },
      onError: (DioException e, handler) {
        print("Error $e");
        handler.next(e);
      },
    ));
  }

  Future<Response> post(String endpoint, dynamic data,
      {Map<String, dynamic>? queryparameters}) async {
    try {
      final response = await dio.post(endpoint,
          data: data, queryParameters: queryparameters);
      return response;
    } on DioException catch (e) {
      throw Exception("Failed Post request $e");
    }
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryparameters}) async {
    try {
      final response =
          await dio.get(endpoint, queryParameters: queryparameters);
      return response;
    } on DioException catch (e) {
      throw Exception("Failed to get response $e");
    }
  }

  Future<Response> put(String endpoint, dynamic data) async {
    try {
      final response = await dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception("Failed to put request $e");
    }
  }

  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      final response = await dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception("Failed to put request $e");
    }
  }
}

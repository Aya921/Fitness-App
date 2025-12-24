import 'package:dio/dio.dart';
import 'package:fitness/core/storage/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;

  TokenInterceptor(this._secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}

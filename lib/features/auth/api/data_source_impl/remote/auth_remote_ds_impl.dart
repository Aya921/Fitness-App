import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/features/auth/api/client/auth_api_services.dart';
import 'package:fitness/core/storage/secure_storage_service.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  final AuthApiServices _api;
  final SecureStorageService _secureStorage;

  AuthRemoteDsImpl(this._api, this._secureStorage);

  @override
  Future<Result<AuthEntity>> logIn(String email, String password) {
    return safeApiCall(() async {
      final response = await _api.logIn({
        Constants.email: email,
        Constants.password: password,
      });

      if (response.error != null) {
        throw ResponseException(message: response.error!);
      }
      if (response.token == null || response.user == null) {
        throw const ResponseException(message: Constants.invalidResponse);
      }

      await _secureStorage.saveToken(response.token!);

      return response.toEntity();
    });
  }

  @override
  Future<Result<AuthEntity>> getLoggedUser() {
    return safeApiCall(() async {
      final response = await _api.getLoggedUser();

      if (response.error != null) {
        throw ResponseException(message: response.error!);
      }

      final entity = response.toEntity();
      UserManager().setUser(entity.user!);

      return entity;
    });
  }
}

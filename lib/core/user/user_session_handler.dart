import 'package:fitness/core/storage/secure_storage_service.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/use_case/get_logged_user_use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserSessionHandler {
  final SecureStorageService _secureStorage;
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  UserSessionHandler(this._secureStorage, this._getLoggedUserUseCase);

  Future<bool> checkIfUserLoggedIn() async {
    final token = await _secureStorage.getToken();
    if (token == null) return false;

    final result = await _getLoggedUserUseCase.call();

    switch (result) {
      case SuccessResult<AuthEntity>():
        UserManager().setUser(result.successResult.user!);
        return true;
      case FailedResult<AuthEntity>():
        await _secureStorage.clearToken();
        return false;
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearToken();
    UserManager().clearUser();
  }
}

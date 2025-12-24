import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/features/auth/api/client/auth_api_services.dart';
import 'package:fitness/core/storage/secure_storage_service.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/forget_pass_request_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/reset_pass_request_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/send_code_request_model.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  final AuthApiServices _authApiServices;
  final SecureStorageService _secureStorage;

  AuthRemoteDsImpl(this._authApiServices, this._secureStorage);

  @override
  Future<Result<AuthEntity>> logIn(String email, String password) {
    return safeApiCall(() async {
      final response = await _authApiServices.logIn({
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
      final response = await _authApiServices.getLoggedUser();

      if (response.error != null) {
        throw ResponseException(message: response.error!);
      }

      final entity = response.toEntity();
      UserManager().setUser(entity.user!);

      return entity;
    });
  }

  @override
  Future<Result<ForgetPassResponse>> forgetPass({
    required ForgetPassRequest forgetPassReq,
  }) async {
    return safeApiCall(() async {
      final forgetPassResponseModel = await _authApiServices.forgetPassword(
        ForgetPassRequestModel.toModel(forgetPassReq),
      );
      return (forgetPassResponseModel.toEntity());
    });
  }

  @override
  Future<Result<void>> sendCode({required SendCodeRequest code}) {
    return safeApiCall(() async {
      await _authApiServices.sendCode(SendCodeRequestModel.toModel(code));
      return (null);
    });
  }

  @override
  Future<Result<void>> resetPassword({required ResetPassRequest code}) {
    return safeApiCall(() async {
      await _authApiServices.resetPass(ResetPassRequestModel.toModel(code));
      return (null);
    });
  }
  
@override
  Future<Result<UserEntity>> register(RegisterRequest request) async {
    return safeApiCall(() async {
      final response = await _authApiServices.register(request);

      return response.user!.toEntity();
    });

}
}
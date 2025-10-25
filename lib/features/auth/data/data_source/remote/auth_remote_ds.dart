import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';

abstract interface class AuthRemoteDs {
  Future<Result<AuthEntity>> logIn(String email, String password);
  Future<Result<AuthEntity>> getLoggedUser();
  Future<Result<ForgetPassResponse>> forgetPass({
    required ForgetPassRequest forgetPassReq,
  });
  Future<Result<void>> sendCode({required SendCodeRequest code});
  Future<Result<void>> resetPassword({required ResetPassRequest code});
  Future<Result<UserEntity>>register(RegisterRequest request);
}

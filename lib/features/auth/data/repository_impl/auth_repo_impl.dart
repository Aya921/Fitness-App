import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:fitness/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDs _authRemoteDs;

  AuthRepoImpl(this._authRemoteDs);

  @override
  Future<Result<ForgetPassResponse>> forgetPass({
    required ForgetPassRequest forgetPassReq,
  }) async {
    return await _authRemoteDs.forgetPass(forgetPassReq: forgetPassReq);
  }

  @override
  Future<Result<void>> sendCode({required SendCodeRequest code}) async {
    return await _authRemoteDs.sendCode(code: code);
  }

  @override
  Future<Result<void>> resetPass({required ResetPassRequest resetReq}) async {
    return await _authRemoteDs.resetPassword(code: resetReq);
  }
}

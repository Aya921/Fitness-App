import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPassUseCase {
  final AuthRepo _authRepo;
  ForgetPassUseCase(this._authRepo);

  Future<Result<ForgetPassResponse>> forgetPass({required ForgetPassRequest forgetPassReq}) async {
    return await _authRepo.forgetPass(forgetPassReq: forgetPassReq);
  }
}

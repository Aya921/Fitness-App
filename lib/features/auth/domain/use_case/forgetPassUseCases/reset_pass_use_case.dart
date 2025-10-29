import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPassUseCase {
  final AuthRepo _authRepo;
  ResetPassUseCase(this._authRepo);

  Future<Result<void>> resetPass({required 
    ResetPassRequest req,
  })async {
    return await _authRepo.resetPass(resetReq: req);
  }
}

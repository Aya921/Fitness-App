import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:fitness/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendCodeUseCase {
  final AuthRepo _authRepo;
  SendCodeUseCase(this._authRepo);

  Future<Result<void>> sendCode({
    required SendCodeRequest code,
  }) async {
    return await _authRepo.sendCode(code: code);
  }
}

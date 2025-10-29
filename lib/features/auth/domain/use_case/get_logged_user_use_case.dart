import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLoggedUserUseCase {
  final AuthRepo _authRepo;
  GetLoggedUserUseCase(this._authRepo);

  Future<Result<AuthEntity>> call(){
    return _authRepo.getLoggedUser();
  }
}
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/repo/logout/logout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final LogoutRepo _logoutRepo;
  LogoutUseCase(this._logoutRepo);

  Future<Result<void>> call(){
    return _logoutRepo.logout();
  }
}
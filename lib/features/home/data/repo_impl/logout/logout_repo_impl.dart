import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/logout/logout_ds.dart';
import 'package:fitness/features/home/domain/repo/logout/logout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepo)
class LogoutRepoImpl implements LogoutRepo{
  final LogoutDs _logoutDs;
  const LogoutRepoImpl(this._logoutDs);

  @override
  Future<Result<void>> logout() async {
    return await _logoutDs.logout();
  }
}
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDs _authRemoteDs;

  AuthRepoImpl(this._authRemoteDs);

  @override
  Future<Result<AuthEntity>> logIn(String email, String password) {
    return _authRemoteDs.logIn(email, password);
  }

  @override
  Future<Result<AuthEntity>> getLoggedUser() {
    return _authRemoteDs.getLoggedUser();
  }
}

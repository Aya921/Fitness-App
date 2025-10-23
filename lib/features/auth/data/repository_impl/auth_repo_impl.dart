import 'package:fitness/features/auth/data/data_source/local/auth_local_ds.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:fitness/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../../api/models/register/request/register_request.dart';
import '../../domain/entity/auth/user_entity.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo{
  final AuthRemoteDs _authRemoteDs;
  final AuthLocalDs _authLocalDs;

  AuthRepoImpl(
      this._authRemoteDs,
      this._authLocalDs
      );
  @override
  Future<Result<UserEntity>> register(RegisterRequest request)async {
    return await _authRemoteDs.register(request);
  }
}
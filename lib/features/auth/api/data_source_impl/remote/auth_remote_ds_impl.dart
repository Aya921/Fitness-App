import 'package:fitness/features/auth/api/client/auth_api_services.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/result/result.dart';
import '../../../../../core/safe_api_call/safe_api_call.dart';
import '../../../domain/entity/auth/user_entity.dart';
import '../../models/register/request/register_request.dart';

@Injectable(as:AuthRemoteDs )
class AuthRemoteDsImpl implements AuthRemoteDs {
  final AuthApiServices _authApiServices;
  AuthRemoteDsImpl(this._authApiServices);
  @override
  Future<Result<UserEntity>> register(RegisterRequest request) async {
    return safeApiCall(() async {
      final response = await _authApiServices.register(request);

      return response.user!.toEntity();
    });
  }
}

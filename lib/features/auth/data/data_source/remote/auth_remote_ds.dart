import '../../../../../core/result/result.dart';
import '../../../api/models/register/request/register_request.dart';
import '../../../domain/entity/auth/user_entity.dart';

abstract interface  class AuthRemoteDs {
  Future<Result<UserEntity>>register(RegisterRequest request);

}
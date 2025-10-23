import '../../../../core/result/result.dart';
import '../../api/models/register/request/register_request.dart';
import '../entity/auth/user_entity.dart';

abstract interface  class AuthRepo {
  Future<Result<UserEntity>> register(RegisterRequest request);

}
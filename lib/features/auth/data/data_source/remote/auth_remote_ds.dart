import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';

abstract interface class AuthRemoteDs {
  Future<Result<AuthEntity>> logIn(String email, String password);
  Future<Result<AuthEntity>> getLoggedUser();
}

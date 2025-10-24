import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';

class AuthEntity {
  final String? message;
  final UserEntity? user;
  final String? token;

  const AuthEntity({
    this.message,
    this.user,
    this.token,
  });
}

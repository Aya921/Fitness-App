import 'package:equatable/equatable.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';

class AuthEntity extends Equatable {
  final UserEntity? user;
  final String? token;

  const AuthEntity({
    this.user,
    this.token,
  });

  @override
  List<Object?> get props => [user,token];
}

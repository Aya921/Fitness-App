import 'package:equatable/equatable.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';

class AuthEntity extends Equatable {
  final String? message;
  final UserEntity? user;
  final String? token;
  final String? error;

  const AuthEntity({
    this.message,
    this.user,
    this.token,
    this.error
  });

  @override
  List<Object?> get props => [message,user,token,error];
}

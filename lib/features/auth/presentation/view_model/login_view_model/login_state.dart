import 'package:equatable/equatable.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';

final class LoginState extends Equatable {
  final StateStatus<AuthEntity> loginStatus;
  final bool isEmailValid;
  final bool isPasswordValid;

  const LoginState({
    this.loginStatus = const StateStatus.initial(),
    this.isEmailValid = false,
    this.isPasswordValid = false,
  });

  LoginState copyWith({
    StateStatus<AuthEntity>? loginStatus,
    final bool? isEmailValid,
    final bool? isPasswordValid,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  bool get isLoginValid => isEmailValid && isPasswordValid;
  @override
  List<Object?> get props => [
    loginStatus,
    isEmailValid,
    isPasswordValid,
  ];
}

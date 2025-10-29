import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/core/user/user_session_handler.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/use_case/login_use_case.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'login_intent.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _signInUseCase;
  final UserSessionHandler _userSessionHandler;

  LoginCubit(this._signInUseCase, this._userSessionHandler)
    : super(const LoginState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> doIntent({required LoginIntent intent}) async {
    switch (intent) {
      case LoginWithEmailAndPasswordIntent():
        await _login();
        break;
      case UpdateEmailIntent():
        _updateEmailValid(emailController.text.trim().isNotEmpty);
        break;
      case UpdatePasswordIntent():
        _updatePasswordValid(passwordController.text.trim().isNotEmpty);
        break;
    }
  }

  void _updateEmailValid(bool isValid) =>
      emit(state.copyWith(isEmailValid: isValid));

  void _updatePasswordValid(bool isValid) =>
      emit(state.copyWith(isPasswordValid: isValid));

  Future<void> _login() async {

    if (!state.isLoginValid) {
      emit(
        state.copyWith(
          loginStatus: const StateStatus.failure(
            ResponseException(message: "Please fill all fields correctly"),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(loginStatus: const StateStatus.loading(),),
    );

    final result = await _signInUseCase.call(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    switch (result) {
      case SuccessResult<AuthEntity>():
        if (result.successResult.user != null) {
          UserManager().setUser(result.successResult.user!);
        }

        await _userSessionHandler.checkIfUserLoggedIn();

        emit(
          state.copyWith(
            loginStatus: StateStatus.success(result.successResult),
          ),
        );
        break;

      case FailedResult<AuthEntity>():
        emit(
          state.copyWith(
            loginStatus: StateStatus.failure(
              ResponseException(message: result.errorMessage),
            ),
          ),
        );
        break;
    }
  }
}

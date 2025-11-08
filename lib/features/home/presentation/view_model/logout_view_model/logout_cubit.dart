import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/features/home/domain/usecase/logout/logout_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/logout_view_model/logout_intent.dart';
import 'package:injectable/injectable.dart';

import 'logout_state.dart';

@injectable
class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase _logoutUseCase;

  LogoutCubit(this._logoutUseCase) : super(const LogoutState());

  Future<void> doIntent({required LogoutIntent intent}) async {
    switch (intent) {
      case LogoutBtnSubmitted():
        await _logout();
        break;
    }
  }

  Future<void> _logout() async {
    final result = await _logoutUseCase.call();
    switch (result) {
      case SuccessResult<void>():
        UserManager().clearUser();
        emit(state.copyWith(logoutStatus: const StateStatus.success(null)));
      case FailedResult<void>():
        emit(
          state.copyWith(
            logoutStatus: StateStatus.failure(
              ResponseException(message: result.errorMessage),
            ),
          ),
        );
    }
  }
}

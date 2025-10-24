import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:fitness/features/auth/domain/use_case/forgetPassUseCases/forget_pass_use_case.dart';
import 'package:fitness/features/auth/domain/use_case/forgetPassUseCases/reset_pass_use_case.dart';
import 'package:fitness/features/auth/domain/use_case/forgetPassUseCases/send_code_use_case.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_event.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPassCubit extends Cubit<ForgetPasswordState> {
  final ForgetPassUseCase _forgetPassUseCase;
  final SendCodeUseCase _sendCodeUseCase;
  final ResetPassUseCase _resetPassUseCase;

  ForgetPassCubit(
    this._forgetPassUseCase,
    this._sendCodeUseCase,
    this._resetPassUseCase,
  ) : super(const ForgetPasswordState());

  Future<void> doIntent(ForgetPassEvent intent) async {
    switch (intent) {
      case SendForgetPassEmailEvent():
        return _forgetPassword(intent.forgetPassRequest);
      case SendCodeEvent():
        return _sendCode(intent.sendCodeRequest);

      case ResetPassEvent():
        return _resetPass(intent.resetPassRequest);
    }
  }

  Future<void> _forgetPassword(ForgetPassRequest request) async {
    emit(
      state.copyWith(status: const StateStatus<ForgetPassResponse>.loading()),
    );
    final res = await _forgetPassUseCase.forgetPass(forgetPassReq: request);
    switch (res) {
      case SuccessResult<ForgetPassResponse>():
        emit(
          state.copyWith(
            status: StateStatus<ForgetPassResponse>.success(res.successResult),
          ),
        );
      case FailedResult<ForgetPassResponse>():
        emit(state.copyWith(status: StateStatus<ForgetPassResponse>.failure(ResponseException(message: res.errorMessage))));
    }
  }

  Future<void> _sendCode(SendCodeRequest request) async {
    emit(state.copyWith(status: const StateStatus<void>.loading()));
    final res = await _sendCodeUseCase.sendCode(code: request);
    switch (res) {
      case SuccessResult<void>():
        emit(
          state.copyWith(status: StateStatus<void>.success(res.successResult)),
        );
      case FailedResult<void>():
        emit(state.copyWith(status: StateStatus.failure(ResponseException(message: res.errorMessage))));
    }
  }

  Future<void> _resetPass(ResetPassRequest request) async {
    emit(state.copyWith(status: const StateStatus<void>.loading()));
    final res = await _resetPassUseCase.resetPass(req: request);
    switch (res) {
      case SuccessResult<void>():
        emit(
          state.copyWith(status: StateStatus<void>.success(res.successResult)),
        );
      case FailedResult<void>():
        emit(state.copyWith(status: StateStatus.failure(ResponseException(message: res.errorMessage))));
    }
  }
}

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
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_event.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_pass_cubit_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([SendCodeUseCase, ForgetPassUseCase, ResetPassUseCase])
void main() {
  late ForgetPassCubit forgetPassCubit;
  late MockSendCodeUseCase mockSendCodeUseCase;
  late MockForgetPassUseCase mockForgetPassUseCase;
  late MockResetPassUseCase mockResetPassUseCase;
  late ForgetPassRequest forgetPassRequest;
  late SendCodeRequest sendCodeRequest;
  late ResetPassRequest resetPassRequest;
  late ForgetPassResponse forgetPassResponse;

  setUp(() {
    mockSendCodeUseCase = MockSendCodeUseCase();
    mockForgetPassUseCase = MockForgetPassUseCase();
    mockResetPassUseCase = MockResetPassUseCase();
    forgetPassCubit = ForgetPassCubit(
      mockForgetPassUseCase,
      mockSendCodeUseCase,

      mockResetPassUseCase,
    );
    forgetPassResponse = const ForgetPassResponse(info: 'Success');

    forgetPassRequest = ForgetPassRequest(email: 'aya@test.com');
    sendCodeRequest = SendCodeRequest(otpCode: '1234');
    resetPassRequest = ResetPassRequest(
      email: 'aya@test.com',
      newPass: 'abcd1234',
    );
  });

  // -------------------------------------------------------------------

  group("test _forgetPass fn", () {
    blocTest<ForgetPassCubit, ForgetPasswordState>(
      "should emite loading and state.sucess when sucessResult back",
      build: () {
        forgetPassCubit = ForgetPassCubit(
          mockForgetPassUseCase,
          mockSendCodeUseCase,
          mockResetPassUseCase,
        );
        final mockResult = SuccessResult<ForgetPassResponse>(
          forgetPassResponse,
        );
        provideDummy<Result<ForgetPassResponse>>(mockResult);

        when(
          mockForgetPassUseCase.forgetPass(forgetPassReq: forgetPassRequest),
        ).thenAnswer((_) async => mockResult);

       

        return forgetPassCubit;
      },
      act: (bloc) => bloc.doIntent(SendForgetPassEmailEvent(forgetPassRequest: forgetPassRequest)),
      expect: () {
        return [

         const ForgetPasswordState(forgetPasswordState:StateStatus<ForgetPassResponse>.loading() ),
          ForgetPasswordState(forgetPasswordState:StateStatus<ForgetPassResponse>.success(forgetPassResponse) ),
          ];
      },
    );
 
    blocTest<ForgetPassCubit, ForgetPasswordState>(
      "should emite loading and state.falied when failedResult back",
      build: () {
        forgetPassCubit = ForgetPassCubit(
          mockForgetPassUseCase,
          mockSendCodeUseCase,
          mockResetPassUseCase,
        );
        final mockResult = FailedResult<ForgetPassResponse>(
          "error",
        );
        provideDummy<Result<ForgetPassResponse>>(mockResult);

        when(
          mockForgetPassUseCase.forgetPass(forgetPassReq: forgetPassRequest),
        ).thenAnswer((_) async => mockResult);

       

        return forgetPassCubit;
      },
      act: (bloc) => bloc.doIntent(SendForgetPassEmailEvent(forgetPassRequest: forgetPassRequest)),
      expect: () {
        return [

         const ForgetPasswordState(forgetPasswordState:StateStatus<ForgetPassResponse>.loading() ),
          const ForgetPasswordState(forgetPasswordState:StateStatus<ForgetPassResponse>.failure(ResponseException(message: "error")) ),
          ];
      },
    );
 
    group("test _sendCode fn", () {
  blocTest<ForgetPassCubit, ForgetPasswordState>(
    "should emit loading and state.success when SuccessResult back",
    build: () {
      forgetPassCubit = ForgetPassCubit(
        mockForgetPassUseCase,
        mockSendCodeUseCase,
        mockResetPassUseCase,
      );

      final mockResult = SuccessResult<void>(null);
      provideDummy<Result<void>>(mockResult);

      when(mockSendCodeUseCase.sendCode(code: sendCodeRequest))
          .thenAnswer((_) async => mockResult);

      return forgetPassCubit;
    },
    act: (bloc) => bloc.doIntent(SendCodeEvent(sendCodeRequest: sendCodeRequest)),
    expect: () => [
      const ForgetPasswordState(
        forgetPasswordState: StateStatus<void>.loading(),
      ),
      const ForgetPasswordState(
        forgetPasswordState: StateStatus<void>.success(null),
      ),
    ],
  );

  blocTest<ForgetPassCubit, ForgetPasswordState>(
    "should emit loading and state.failed when FailedResult back",
    build: () {
      forgetPassCubit = ForgetPassCubit(
        mockForgetPassUseCase,
        mockSendCodeUseCase,
        mockResetPassUseCase,
      );

      final mockResult = FailedResult<void>("error");
      provideDummy<Result<void>>(mockResult);

      when(mockSendCodeUseCase.sendCode(code: sendCodeRequest))
          .thenAnswer((_) async => mockResult);

      return forgetPassCubit;
    },
    act: (bloc) => bloc.doIntent(SendCodeEvent(sendCodeRequest: sendCodeRequest)),
    expect: () => [
      const ForgetPasswordState(
        forgetPasswordState: StateStatus<void>.loading(),
      ),
      const ForgetPasswordState(
        forgetPasswordState:
            StateStatus<void>.failure(ResponseException(message: "error")),
      ),
    ],
  );
});


// -------------------------------------------------------------------

group("test _resetPass fn", () {
  blocTest<ForgetPassCubit, ForgetPasswordState>(
    "should emit loading and state.success when SuccessResult back",
    build: () {
      forgetPassCubit = ForgetPassCubit(
        mockForgetPassUseCase,
        mockSendCodeUseCase,
        mockResetPassUseCase,
      );

      final mockResult = SuccessResult<void>(null);
      provideDummy<Result<void>>(mockResult);

      when(mockResetPassUseCase.resetPass(req: resetPassRequest))
          .thenAnswer((_) async => mockResult);

      return forgetPassCubit;
    },
    act: (bloc) => bloc.doIntent(
      ResetPassEvent(resetPassRequest: resetPassRequest),
    ),
    expect: () => [
      const ForgetPasswordState(
        forgetPasswordState: StateStatus<void>.loading(),
      ),
      const ForgetPasswordState(
        forgetPasswordState: StateStatus<void>.success(null),
      ),
    ],
  );

  blocTest<ForgetPassCubit, ForgetPasswordState>(
    "should emit loading and state.failed when FailedResult back",
    build: () {
      forgetPassCubit = ForgetPassCubit(
        mockForgetPassUseCase,
        mockSendCodeUseCase,
        mockResetPassUseCase,
      );

      final mockResult = FailedResult<void>("error");
      provideDummy<Result<void>>(mockResult);

      when(mockResetPassUseCase.resetPass(req: resetPassRequest))
          .thenAnswer((_) async => mockResult);

      return forgetPassCubit;
    },
    act: (bloc) => bloc.doIntent(
      ResetPassEvent(resetPassRequest: resetPassRequest),
    ),
    expect: () => [
      const ForgetPasswordState(
        forgetPasswordState: StateStatus<void>.loading(),
      ),
      const ForgetPasswordState(
        forgetPasswordState:
            StateStatus<void>.failure(ResponseException(message: "error")),
      ),
    ],
  );
});

 
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/user/user_session_handler.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/domain/use_case/login_use_case.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase, UserSessionHandler])
void main() {
  late LoginCubit loginCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockUserSessionHandler mockUserSessionHandler;

  setUp(() {
    provideDummy<Result<AuthEntity>>(
      SuccessResult(const AuthEntity(token: 'dummy', user: null)),
    );
    mockLoginUseCase = MockLoginUseCase();
    mockUserSessionHandler = MockUserSessionHandler();
    loginCubit = LoginCubit(mockLoginUseCase, mockUserSessionHandler);
  });

  tearDown(() {
    loginCubit.close();
  });

  const fakeAuthEntity = AuthEntity(
    token: 'fake_token',
    user: UserEntity(
      personalInfo: PersonalInfoEntity(
        email: "test@gmail.com",
        gender: "female",
        age: 21,
      ),
    ),
  );

  group("LoginCubit Tests", () {
    blocTest<LoginCubit, LoginState>(
      "emits [loading, success] when login succeeds",
      build: () {
        when(
          mockLoginUseCase.call(any, any),
        ).thenAnswer((_) async => SuccessResult(fakeAuthEntity));
        when(
          mockUserSessionHandler.checkIfUserLoggedIn(),
        ).thenAnswer((_) async => true);

        loginCubit.emailController.text = "test@test.com";
        loginCubit.passwordController.text = "123456";

        loginCubit.emit(
          loginCubit.state.copyWith(
            loginStatus: const StateStatus.success(fakeAuthEntity),
            isEmailValid: true,
            isPasswordValid: true,
          ),
        );

        return loginCubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.isEmailValid, 'isEmailValid', true)
            .having((s) => s.isPasswordValid, 'isPasswordValid', true)
            .having(
              (s) => s.loginStatus,
              'loginStatus',
              isA<StateStatus<AuthEntity>>(),
            ),
        isA<LoginState>().having(
          (s) => s.loginStatus,
          'loginStatus',
          isA<StateStatus<AuthEntity>>(),
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "emits [failure] when fields are empty",
      build: () {
        loginCubit.emailController.text = "";
        loginCubit.passwordController.text = "";
        return loginCubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        const LoginState(
          loginStatus: StateStatus.failure(
            ResponseException(message: "Please fill all fields correctly"),
          ),
          isEmailValid: false,
          isPasswordValid: false,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "emits [loading, failure] when login fails from usecase",
      build: () {
        when(mockLoginUseCase.call(any, any)).thenAnswer(
          (_) async => FailedResult<AuthEntity>("Invalid credentials"),
        );

        loginCubit.emailController.text = "test@test.com";
        loginCubit.passwordController.text = "wrongpassword";
        loginCubit.emit(
          loginCubit.state.copyWith(isEmailValid: true, isPasswordValid: true),
        );
        return loginCubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        isA<LoginState>()
            .having((s) => s.isEmailValid, 'isEmailValid', true)
            .having((s) => s.isPasswordValid, 'isPasswordValid', true)
            .having(
              (s) => s.loginStatus,
              'loginStatus',
              isA<StateStatus<AuthEntity>>(),
            ),
        isA<LoginState>()
            .having((s) => s.isEmailValid, 'isEmailValid', true)
            .having((s) => s.isPasswordValid, 'isPasswordValid', true)
            .having(
              (s) => s.loginStatus,
              'loginStatus',
              isA<StateStatus<AuthEntity>>().having(
                (f) => f.error?.message,
                'errorMessage',
                "Invalid credentials",
              ),
            ),
      ],
    );

    group("Validation tests", () {
      blocTest<LoginCubit, LoginState>(
        "updates email validation",
        build: () => loginCubit,
        act: (cubit) {
          loginCubit.emailController.text = "test@test.com";
          cubit.doIntent(intent: UpdateEmailIntent());
        },
        wait: const Duration(milliseconds: 300),
        expect: () => [
          const LoginState(
            isEmailValid: true,
            isPasswordValid: false,
            loginStatus: StateStatus.initial(),
          ),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        "updates password validation",
        build: () => loginCubit,
        act: (cubit) {
          loginCubit.passwordController.text = "123456";
          cubit.doIntent(intent: UpdatePasswordIntent());
        },
        wait: const Duration(milliseconds: 300),
        expect: () => [
          const LoginState(
            isEmailValid: false,
            isPasswordValid: true,
            loginStatus: StateStatus.initial(),
          ),
        ],
      );
    });
  });
}

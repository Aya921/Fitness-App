import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:fitness/features/auth/api/data_source_impl/remote/auth_remote_ds_impl.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:fitness/features/auth/data/repository_impl/auth_repo_impl.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDsImpl, AuthRemoteDs])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockAuthRemoteDsImpl mockAuthRemoteDsImpl;

  // Forget password variables
  late ForgetPassRequest forgetPassRequest;
  late SendCodeRequest sendCodeRequest;
  late ResetPassRequest resetPassRequest;

  // Auth variables
  const String email = "Test@gmail.com";
  const String password = "password";

  const fakeAuthEntity = AuthEntity(
    token: "token",
    user: UserEntity(
      personalInfo: PersonalInfoEntity(
        id: "123",
        firstName: "Rana",
        lastName: "Gebril",
        photo: "",
        age: 21,
        gender: "female",
        email: email,
      ),
      bodyInfo: BodyInfoEntity(weight: 70, height: 165),
      activityLevel: "Level 1",
      goal: "Gain weight",
    ),
  );

  // Register mock data
  const successResponse = UserEntity(
    personalInfo: PersonalInfoEntity(
      firstName: "Elevate",
      lastName: "Tech",
      email: "mariam2@gmail.com",
      gender: "female",
      photo: "default-profile.png",
      id: "68f664789762f45e2a989bd4",
      age: 70,
    ),
    createdAt: "",
    activityLevel: "high level",
    goal: "Gain weight",
    bodyInfo: BodyInfoEntity(height: 170, weight: 60),
  );

  final registerRequest = RegisterRequest(
    userBodyInfo: UserBodyInfo(
      height: 170,
      weight: 70,
      age: 70,
      goal: "Gain weight",
      activityLevel: "level1",
    ),
    userInfo: UserInfo(
      firstName: "Elevate",
      lastName: "Tech",
      email: "mariam2@gmail.com",
      password: "Mariam257@",
      rePassword: "Mariam257@",
      gender: "female",
    ),
  );

  setUp(() {
    mockAuthRemoteDsImpl = MockAuthRemoteDsImpl();
    authRepoImpl = AuthRepoImpl(mockAuthRemoteDsImpl);

    provideDummy<Result<UserEntity>>(FailedResult("Dummy"));
    provideDummy<Result<AuthEntity>>(FailedResult("Dummy"));
    provideDummy<Result<void>>(FailedResult("Dummy"));
    provideDummy<Result<ForgetPassResponse>>(FailedResult("Dummy"));

    forgetPassRequest = ForgetPassRequest(email: 'aya@test.com');
    sendCodeRequest = SendCodeRequest(otpCode: '1234');
    resetPassRequest = ResetPassRequest(email: 'aya@test.com', newPass: 'abcd1234');
  });

  //======================= Register =======================//
  group("Register Repo", () {
    test("return SuccessResult when remote data source success", () async {
      when(mockAuthRemoteDsImpl.register(registerRequest))
          .thenAnswer((_) async => SuccessResult(successResponse));

      final result = await authRepoImpl.register(registerRequest);

      expect(result, isA<Result>());
      expect((result as SuccessResult).successResult, successResponse);
      verify(mockAuthRemoteDsImpl.register(registerRequest)).called(1);
    });

    test("return FailedResult when remote data source failed", () async {
      final exception = Exception("Throw Exception");
      when(mockAuthRemoteDsImpl.register(registerRequest))
          .thenAnswer((_) async => FailedResult(exception.toString()));

      final result = await authRepoImpl.register(registerRequest);

      expect(result, isA<Result>());
      expect((result as FailedResult).errorMessage, exception.toString());
      verify(mockAuthRemoteDsImpl.register(registerRequest)).called(1);
    });
  });

  //======================= Forget Password =======================//
  group('forgetPass()', () {
    const forgetPassResponse = ForgetPassResponse(info: 'Success');

    test('should return SuccessResult on success', () async {
      final mockResult = SuccessResult<ForgetPassResponse>(forgetPassResponse);
      provideDummy<Result<ForgetPassResponse>>(mockResult);

      when(mockAuthRemoteDsImpl.forgetPass(forgetPassReq: forgetPassRequest))
          .thenAnswer((_) async => mockResult);

      final result =
          await authRepoImpl.forgetPass(forgetPassReq: forgetPassRequest);

      expect(result, isA<SuccessResult<ForgetPassResponse>>());
      verify(mockAuthRemoteDsImpl.forgetPass(
              forgetPassReq: forgetPassRequest))
          .called(1);
    });

    test('should return FailedResult on error', () async {
      final mockResult = FailedResult<ForgetPassResponse>("error");
      provideDummy<Result<ForgetPassResponse>>(mockResult);

      when(mockAuthRemoteDsImpl.forgetPass(forgetPassReq: forgetPassRequest))
          .thenAnswer((_) async => mockResult);

      final result =
          await authRepoImpl.forgetPass(forgetPassReq: forgetPassRequest);

      expect(result, isA<FailedResult<ForgetPassResponse>>());
      verify(mockAuthRemoteDsImpl.forgetPass(
              forgetPassReq: forgetPassRequest))
          .called(1);
    });
  });

  //======================= Send Code =======================//
  group('sendCode()', () {
    test('should return SuccessResult<void> on success', () async {
      final mockResult = SuccessResult<void>(null);
      provideDummy<Result<void>>(mockResult);

      when(mockAuthRemoteDsImpl.sendCode(code: sendCodeRequest))
          .thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.sendCode(code: sendCodeRequest);

      expect(result, isA<SuccessResult<void>>());
      verify(mockAuthRemoteDsImpl.sendCode(code: sendCodeRequest)).called(1);
    });

    test('should return FailedResult<void> on error', () async {
      final mockResult = FailedResult<void>("error");
      provideDummy<Result<void>>(mockResult);

      when(mockAuthRemoteDsImpl.sendCode(code: sendCodeRequest))
          .thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.sendCode(code: sendCodeRequest);

      expect(result, isA<FailedResult<void>>());
      verify(mockAuthRemoteDsImpl.sendCode(code: sendCodeRequest)).called(1);
    });
  });

  //======================= Reset Password =======================//
  group('resetPass()', () {
    test('should return SuccessResult<void> on success', () async {
      final mockResult = SuccessResult<void>(null);
      provideDummy<Result<void>>(mockResult);

      when(mockAuthRemoteDsImpl.resetPassword(code: resetPassRequest))
          .thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.resetPass(resetReq: resetPassRequest);

      expect(result, isA<SuccessResult<void>>());
      verify(mockAuthRemoteDsImpl.resetPassword(code: resetPassRequest))
          .called(1);
    });

    test('should return FailedResult<void> on error', () async {
      final mockResult = FailedResult<void>("error");
      provideDummy<Result<void>>(mockResult);

      when(mockAuthRemoteDsImpl.resetPassword(code: resetPassRequest))
          .thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.resetPass(resetReq: resetPassRequest);

      expect(result, isA<FailedResult<void>>());
      verify(mockAuthRemoteDsImpl.resetPassword(code: resetPassRequest))
          .called(1);
    });
  });

  //======================= Login / GetLoggedUser =======================//
  group("logIn test", () {
    test("Should return SuccessResult when data source success", () async {
      when(mockAuthRemoteDsImpl.logIn(any, any))
          .thenAnswer((_) async => SuccessResult<AuthEntity>(fakeAuthEntity));

      final result = await authRepoImpl.logIn(email, password);

      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = (result as SuccessResult<AuthEntity>).successResult;
      expect(success, fakeAuthEntity);
      expect(success.user?.personalInfo?.gender, "female");
      expect(success.user?.activityLevel, "Level 1");
      expect(success.user?.bodyInfo?.height, 165);
    });

    test("Should return FailedResult when data source failed", () async {
      when(mockAuthRemoteDsImpl.logIn(any, any))
          .thenAnswer((_) async => FailedResult("logIn errorMessage"));

      final result = await authRepoImpl.logIn(email, password);

      expect(result, isA<FailedResult<AuthEntity>>());
      final failure = (result as FailedResult<AuthEntity>).errorMessage;
      expect(failure, contains("logIn errorMessage"));
    });
  });

  group("getLoggedUser test", () {
    test("Should return SuccessResult when data source success", () async {
      when(mockAuthRemoteDsImpl.getLoggedUser())
          .thenAnswer((_) async => SuccessResult<AuthEntity>(fakeAuthEntity));

      final result = await authRepoImpl.getLoggedUser();

      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = (result as SuccessResult<AuthEntity>).successResult;
      expect(success, fakeAuthEntity);
      expect(success.user?.personalInfo?.gender, "female");
      expect(success.user?.activityLevel, "Level 1");
      expect(success.user?.bodyInfo?.height, 165);
    });

    test("Should return FailedResult when data source failed", () async {
      when(mockAuthRemoteDsImpl.getLoggedUser())
          .thenAnswer((_) async => FailedResult("server errorMessage"));

      final result = await authRepoImpl.getLoggedUser();

      expect(result, isA<FailedResult<AuthEntity>>());
      final failure = (result as FailedResult<AuthEntity>).errorMessage;
      expect(failure, contains("server errorMessage"));
    });
  });
}

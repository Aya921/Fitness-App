import 'package:dio/dio.dart';
import 'package:fitness/core/constants/exception_constant.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/error/api_error.dart';
import 'package:fitness/core/storage/secure_storage_service.dart';
import 'package:fitness/features/auth/api/client/auth_api_services.dart';
import 'package:fitness/features/auth/api/data_source_impl/remote/auth_remote_ds_impl.dart';
import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/auth/api/models/auth_response/user_response.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/forget_pass_response_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/reset_pass_response_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/send_code_response_model.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_ds_impl_test.mocks.dart';

@GenerateMocks([AuthApiServices, SecureStorageService])
void main() {
  late AuthRemoteDsImpl authRemoteDsImpl;
  late MockAuthApiServices mockAuthApiServices;
  late MockSecureStorageService mockSecureStorageService;

  // Forget Password / Send Code / Reset Password variables
  late ForgetPassResponseModel forgetPassResponseModel;
  late ForgetPassRequest forgetPassRequest;
  late SendCodeRequest sendCodeRequest;
  late SendCodeResponseModel sendCodeResponseModel;
  late ResetPassRequest resetPassRequest;
  late ResetPassResponseModel resetPassResponseModel;

  // Login / GetLoggedUser variables
  const String email = "test@gmail.com";
  const String password = "password";
  final fakeAuthResponse = AuthResponse(
    message: "message",
    token: "token",
    user: UserResponse(
        id: "123",
        firstName: "Rana",
        lastName: "Gebril",
        photo: "",
        age: 21,
        gender: "female",
        email: email,
      weight: 70, height: 165,
      activityLevel: "Level 1",
      goal: "Gain weight",
      createdAt: "",
    ),
  );
  
  final request = RegisterRequest(
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

  setUpAll(() {
    mockAuthApiServices = MockAuthApiServices();
    mockSecureStorageService = MockSecureStorageService();
    authRemoteDsImpl = AuthRemoteDsImpl(
      mockAuthApiServices,
      mockSecureStorageService,
    );

    forgetPassResponseModel = ForgetPassResponseModel(
      message: "success",
      info: '',
    );
    forgetPassRequest = ForgetPassRequest(email: "");
    sendCodeRequest = SendCodeRequest(otpCode: "1234");
    sendCodeResponseModel = SendCodeResponseModel(status: "");
    resetPassResponseModel = ResetPassResponseModel(email: '', token: '');
    resetPassRequest = ResetPassRequest(email: '', newPass: '');
  });

  group("Register Remote Data Source", () {
    test("return SuccessResult when api call success", () async {
      when(mockAuthApiServices.register(request))
          .thenAnswer((_) async => fakeAuthResponse);

      final result = await authRemoteDsImpl.register(request);
      final user = fakeAuthResponse.user!.toEntity();

      expect(result, isA<Result<UserEntity>>());
      expect((result as SuccessResult).successResult, user);
      verify(mockAuthApiServices.register(request)).called(1);
    });

    test("return FailedResult when api failed on dio exception", () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: "/"),
        type: DioExceptionType.sendTimeout,
      );

      when(mockAuthApiServices.register(request)).thenThrow(dioException);

      final result = await authRemoteDsImpl.register(request);

      expect(result, isA<Result>());
      expect((result as FailedResult).errorMessage,
          ExceptionConstants.sendTimeout);
      verify(mockAuthApiServices.register(request)).called(1);
    });

    test("return FailedResult when api failed on exception", () async {
      final exception = Exception("throw Exception");
      when(mockAuthApiServices.register(request)).thenThrow(exception);

      final result = await authRemoteDsImpl.register(request);

      expect(result, isA<Result>());
      expect((result as FailedResult).errorMessage, exception.toString());
      verify(mockAuthApiServices.register(request)).called(1);
    });
  });

  group("Forget Password Tests", () {
    test("forgetPass returns SuccessResult on success", () async {
      when(mockAuthApiServices.forgetPassword(any))
          .thenAnswer((_) async => forgetPassResponseModel);

      final res =
          await authRemoteDsImpl.forgetPass(forgetPassReq: forgetPassRequest);

      expect(res, isA<SuccessResult<ForgetPassResponse>>());
      final acResult = res as SuccessResult<ForgetPassResponse>;
      expect(acResult.successResult.info, forgetPassResponseModel.info);

      verify(mockAuthApiServices.forgetPassword(any)).called(1);
    });

    test("forgetPass returns FailedResult on DioException", () async {
      final dioEx = DioException(
        requestOptions: RequestOptions(path: ''),
        message: "dio Exception",
      );
      when(mockAuthApiServices.forgetPassword(any)).thenThrow(dioEx);

      final res =
          await authRemoteDsImpl.forgetPass(forgetPassReq: forgetPassRequest);

      expect(res, isA<FailedResult<ForgetPassResponse>>());
      final acResult = res as FailedResult<ForgetPassResponse>;
      expect(acResult.errorMessage, ServerFailure.fromDioError(dioEx).error);

      verify(mockAuthApiServices.forgetPassword(any)).called(1);
    });

    test("forgetPass returns FailedResult on other Exception", () async {
      final ex = Exception("Some error");
      when(mockAuthApiServices.forgetPassword(any)).thenThrow(ex);

      final res =
          await authRemoteDsImpl.forgetPass(forgetPassReq: forgetPassRequest);

      expect(res, isA<FailedResult<ForgetPassResponse>>());
      final acResult = res as FailedResult<ForgetPassResponse>;
      expect(acResult.errorMessage.toString(), "Exception: Some error");

      verify(mockAuthApiServices.forgetPassword(any)).called(1);
    });

    // Send Code
    test("sendCode returns SuccessResult<void> on success", () async {
      when(mockAuthApiServices.sendCode(any))
          .thenAnswer((_) async => sendCodeResponseModel);

      final res = await authRemoteDsImpl.sendCode(code: sendCodeRequest);

      expect(res, isA<SuccessResult<void>>());
      verify(mockAuthApiServices.sendCode(any)).called(1);
    });

    test("sendCode returns FailedResult<void> on DioException", () async {
      final dioEx = DioException(
        requestOptions: RequestOptions(path: ''),
        message: "dio Exception",
      );
      when(mockAuthApiServices.sendCode(any)).thenThrow(dioEx);

      final res = await authRemoteDsImpl.sendCode(code: sendCodeRequest);

      expect(res, isA<FailedResult<void>>());
      final acResult = res as FailedResult<void>;
      expect(acResult.errorMessage, ServerFailure.fromDioError(dioEx).error);
      verify(mockAuthApiServices.sendCode(any)).called(1);
    });

    test("sendCode returns FailedResult<void> on other Exception", () async {
      final ex = Exception("Unexpected Exception");
      when(mockAuthApiServices.sendCode(any)).thenThrow(ex);

      final res = await authRemoteDsImpl.sendCode(code: sendCodeRequest);

      expect(res, isA<FailedResult<void>>());
      final acResult = res as FailedResult<void>;
      expect(acResult.errorMessage.toString(),
          "Exception: Unexpected Exception");
      verify(mockAuthApiServices.sendCode(any)).called(1);
    });

    // Reset Password
    test("resetPassword returns SuccessResult<void> on success", () async {
      when(mockAuthApiServices.resetPass(any))
          .thenAnswer((_) async => resetPassResponseModel);

      final res = await authRemoteDsImpl.resetPassword(code: resetPassRequest);

      expect(res, isA<SuccessResult<void>>());
      verify(mockAuthApiServices.resetPass(any)).called(1);
    });

    test("resetPassword returns FailedResult<void> on DioException", () async {
      final dioEx = DioException(
        requestOptions: RequestOptions(path: ''),
        message: "dio Exception",
      );
      when(mockAuthApiServices.resetPass(any)).thenThrow(dioEx);

      final res = await authRemoteDsImpl.resetPassword(code: resetPassRequest);

      expect(res, isA<FailedResult<void>>());
      final acResult = res as FailedResult<void>;
      expect(acResult.errorMessage, ServerFailure.fromDioError(dioEx).error);
      verify(mockAuthApiServices.resetPass(any)).called(1);
    });

    test("resetPassword returns FailedResult<void> on other Exception",
        () async {
      final ex = Exception("Unexpected Exception");
      when(mockAuthApiServices.resetPass(any)).thenThrow(ex);

      final res = await authRemoteDsImpl.resetPassword(code: resetPassRequest);

      expect(res, isA<FailedResult<void>>());
      final acResult = res as FailedResult<void>;
      expect(acResult.errorMessage.toString(),
          "Exception: Unexpected Exception");
      verify(mockAuthApiServices.resetPass(any)).called(1);
    });
  });

  group("Login Tests", () {
    test("logIn returns SuccessResult on success", () async {
      when(mockAuthApiServices.logIn(any))
          .thenAnswer((_) async => fakeAuthResponse);
      when(mockSecureStorageService.saveToken(any)).thenAnswer((_) async {});

      final res = await authRemoteDsImpl.logIn(email, password);

      expect(res, isA<SuccessResult<AuthEntity>>());
      final success = (res as SuccessResult<AuthEntity>).successResult;
      expect(success.token, "token");
      expect(success.user?.personalInfo?.firstName, "Rana");
      expect(success.user?.bodyInfo?.height, 165);

      verify(mockSecureStorageService.saveToken("token")).called(1);
    });

    test("logIn returns FailedResult on Exception", () async {
      when(mockAuthApiServices.logIn(any)).thenThrow(Exception("error"));

      final res = await authRemoteDsImpl.logIn(email, password);

      expect(res, isA<FailedResult<AuthEntity>>());
      final error = (res as FailedResult<AuthEntity>).errorMessage;
      expect(error, contains("error"));
    });

    test("getLoggedUser returns SuccessResult on success", () async {
      when(mockAuthApiServices.getLoggedUser())
          .thenAnswer((_) async => fakeAuthResponse);

      final res = await authRemoteDsImpl.getLoggedUser();

      expect(res, isA<SuccessResult<AuthEntity>>());
      final success = (res as SuccessResult<AuthEntity>).successResult;
      expect(success.user?.personalInfo?.firstName, "Rana");
      expect(success.user?.bodyInfo?.height, 165);
      verify(mockAuthApiServices.getLoggedUser()).called(1);
    });

    test("getLoggedUser returns FailedResult on Exception", () async {
      when(mockAuthApiServices.getLoggedUser())
          .thenThrow(Exception("Server error"));

      final res = await authRemoteDsImpl.getLoggedUser();

      expect(res, isA<FailedResult<AuthEntity>>());
      final error = (res as FailedResult<AuthEntity>).errorMessage;
      expect(error, contains("Server error"));
    });
  });
}

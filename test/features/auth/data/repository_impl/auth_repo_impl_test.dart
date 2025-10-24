import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:fitness/features/auth/data/repository_impl/auth_repo_impl.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDs])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockAuthRemoteDs mockAuthRemoteDs;

  late ForgetPassRequest forgetPassRequest;
  late SendCodeRequest sendCodeRequest;
  late ResetPassRequest resetPassRequest;

  setUp(() {
    mockAuthRemoteDs = MockAuthRemoteDs();
    authRepoImpl = AuthRepoImpl(mockAuthRemoteDs);

    forgetPassRequest = ForgetPassRequest(email: 'aya@test.com');
    sendCodeRequest = SendCodeRequest(otpCode: '1234');
    resetPassRequest =
        ResetPassRequest(email: 'aya@test.com', newPass: 'abcd1234');
  });

  // -------------------------------------------------------------------
  group('forgetPass()', () {
    const forgetPassResponse = ForgetPassResponse(info: 'Success');

    test('should return SuccessResult on success', () async {
      final mockResult = SuccessResult<ForgetPassResponse>(
        forgetPassResponse,
      );
      provideDummy<Result<ForgetPassResponse>>(mockResult);

      when(
        mockAuthRemoteDs.forgetPass(forgetPassReq: forgetPassRequest),
      ).thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.forgetPass(
        forgetPassReq: forgetPassRequest,
      );

      expect(result, isA<SuccessResult<ForgetPassResponse>>());
      verify(
        mockAuthRemoteDs.forgetPass(forgetPassReq: forgetPassRequest),
      ).called(1);
    });

    test('should return FailedResult when Exception occurs', () async {
      final mockResult = FailedResult<ForgetPassResponse>("error");
      provideDummy<Result<ForgetPassResponse>>(mockResult);

      when(
        mockAuthRemoteDs.forgetPass(forgetPassReq: forgetPassRequest),
      ).thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.forgetPass(
        forgetPassReq: forgetPassRequest,
      );

      expect(result, isA<FailedResult<ForgetPassResponse>>());
      verify(
        mockAuthRemoteDs.forgetPass(forgetPassReq: forgetPassRequest),
      ).called(1);
    });
  });

  // -------------------------------------------------------------------
  group('sendCode()', () {
    test('should return SuccessResult<void> on success', () async {
      final mockResult = SuccessResult<void>(null);
      provideDummy<Result<void>>(mockResult);

      when(
        mockAuthRemoteDs.sendCode(code: sendCodeRequest),
      ).thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.sendCode(code: sendCodeRequest);

      expect(result, isA<SuccessResult<void>>());
      verify(
        mockAuthRemoteDs.sendCode(code: sendCodeRequest),
      ).called(1);
    });

    test('should return FailedResult<void> when Exception occurs', () async {
      final mockResult = FailedResult<void>("error");
      provideDummy<Result<void>>(mockResult);

      when(
        mockAuthRemoteDs.sendCode(code: sendCodeRequest),
      ).thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.sendCode(code: sendCodeRequest);

      expect(result, isA<FailedResult<void>>());
      verify(
        mockAuthRemoteDs.sendCode(code: sendCodeRequest),
      ).called(1);
    });
  });

  // -------------------------------------------------------------------
  group('resetPass()', () {
    test('should return SuccessResult<void> on success', () async {
      final mockResult = SuccessResult<void>(null);
      provideDummy<Result<void>>(mockResult);

      when(
        mockAuthRemoteDs.resetPassword(code: resetPassRequest),
      ).thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.resetPass(resetReq: resetPassRequest);

      expect(result, isA<SuccessResult<void>>());
      verify(
        mockAuthRemoteDs.resetPassword(code: resetPassRequest),
      ).called(1);
    });

    test('should return FailedResult<void> when Exception occurs', () async {
      final mockResult = FailedResult<void>("error");
      provideDummy<Result<void>>(mockResult);

      when(
        mockAuthRemoteDs.resetPassword(code: resetPassRequest),
      ).thenAnswer((_) async => mockResult);

      final result = await authRepoImpl.resetPass(resetReq: resetPassRequest);

      expect(result, isA<FailedResult<void>>());
      verify(
        mockAuthRemoteDs.resetPassword(code: resetPassRequest),
      ).called(1);
    });
  });
}

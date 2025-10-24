import 'package:dio/dio.dart';
import 'package:fitness/core/error/api_error.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/client/auth_api_services.dart';
import 'package:fitness/features/auth/api/data_source_impl/remote/auth_remote_ds_impl.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/forget_pass_response_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/reset_pass_response_model.dart';
import 'package:fitness/features/auth/api/models/forget_pass_models/send_code_response_model.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_ds_impl_test.mocks.dart';

@GenerateMocks([AuthApiServices])
void main() {
  late AuthRemoteDsImpl authRemoteDsImp;

  late ForgetPassResponseModel forgetPassResponseModel;
  late ForgetPassRequest forgetPassRequest;
  late SendCodeRequest sendCodeRequest;
  late SendCodeResponseModel sendCodeResponseModel;
  late ResetPassRequest resetPassRequest;
  late ResetPassResponseModel resetPassResponseModel;

  late MockAuthApiServices mockAuthApiServices;

  setUpAll(() {
    mockAuthApiServices = MockAuthApiServices();
    authRemoteDsImp = AuthRemoteDsImpl(mockAuthApiServices);

    forgetPassResponseModel = ForgetPassResponseModel(
      message: "sucess",
      info: '',
    );
    forgetPassRequest = ForgetPassRequest(email: "");

    sendCodeRequest = SendCodeRequest(otpCode: "1234");

    sendCodeResponseModel = SendCodeResponseModel(status: "");

    resetPassResponseModel = ResetPassResponseModel(email: '', token: '');
    resetPassRequest = ResetPassRequest(email: '', newPass: '');
  });

  group("test forgetPass fn ", () {
    test(
      "when call forgetPass with correct parameters it should return successResult",
      () async {
        // arrane
        when(
          mockAuthApiServices.forgetPassword(any),
        ).thenAnswer((_) async => forgetPassResponseModel);

        // act
        final res = await authRemoteDsImp.forgetPass(
          forgetPassReq: forgetPassRequest,
        );

        //assert
        expect(res, isA<SuccessResult>());
        final acResult = res as SuccessResult<ForgetPassResponse>;
        expect(acResult.successResult.info, forgetPassResponseModel.info);

        verify(mockAuthApiServices.forgetPassword(any)).called(1);
      },
    );

    //..........................................................................

    test(
      "when call forget pass and somthing went wrong in dio it should return Failed Result with dioException  ",
      () async {
        const String dioException = "dio Exception";
        final DioException mockDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          message: dioException,
        );

        when(
          mockAuthApiServices.forgetPassword(any),
        ).thenThrow(mockDioException);

        // act

        final res = await authRemoteDsImp.forgetPass(
          forgetPassReq: forgetPassRequest,
        );

        //assert

        expect(res, isA<FailedResult<ForgetPassResponse>>());
        final acResult = res as FailedResult<ForgetPassResponse>;
        expect(
          acResult.errorMessage,
          ServerFailure.fromDioError(mockDioException).error,
        );
        verify(mockAuthApiServices.forgetPassword(any)).called(1);
      },
    );

    //................................................................................................................

    test(
      "when call forget passs and any other exception happened it should return Failed Result with that exception   ",
      () async {
        const String exceptionMessage = "Exception";
        final Exception mockException = Exception(exceptionMessage);

        when(mockAuthApiServices.forgetPassword(any)).thenThrow(mockException);

        // act

        final res = await authRemoteDsImp.forgetPass(
          forgetPassReq: forgetPassRequest,
        );

        //assert

        expect(res, isA<FailedResult<ForgetPassResponse>>());
        final acResult = res as FailedResult<ForgetPassResponse>;
        expect(
          acResult.errorMessage.toString(),
          "Exception: $exceptionMessage",
        );

        verify(mockAuthApiServices.forgetPassword(any)).called(1);
      },
    );
  });

  group("test sendCode fn ", () {
    test(
      " when call sendCode with correct parameters it should return SuccessResult<void>",
      () async {
        // arrange
        when(
          mockAuthApiServices.sendCode(any),
        ).thenAnswer((_) async => sendCodeResponseModel);

        // act
        final res = await authRemoteDsImp.sendCode(code: sendCodeRequest);

        // assert
        expect(res, isA<SuccessResult<void>>());
        verify(mockAuthApiServices.sendCode(any)).called(1);
      },
    );

    //............................................................................................

    test(
      "when DioException happens it should return FailedResult<void> with correct error message",
      () async {
        const String dioException = "dio Exception";
        final DioException mockDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          message: dioException,
        );

        when(mockAuthApiServices.sendCode(any)).thenThrow(mockDioException);

        // act
        final res = await authRemoteDsImp.sendCode(code: sendCodeRequest);

        // assert
        expect(res, isA<FailedResult<void>>());
        final acResult = res as FailedResult<void>;
        expect(
          acResult.errorMessage,
          ServerFailure.fromDioError(mockDioException).error,
        );

        verify(mockAuthApiServices.sendCode(any)).called(1);
      },
    );

    //............................................................................................

    test(
      " when any other Exception happens it should return FailedResult<void> with that exception message",
      () async {
        const String exceptionMessage = "Unexpected Exception";
        final Exception mockException = Exception(exceptionMessage);

        when(mockAuthApiServices.sendCode(any)).thenThrow(mockException);

        // act
        final res = await authRemoteDsImp.sendCode(code: sendCodeRequest);

        // assert
        expect(res, isA<FailedResult<void>>());
        final acResult = res as FailedResult<void>;
        expect(
          acResult.errorMessage.toString(),
          "Exception: $exceptionMessage",
        );

        verify(mockAuthApiServices.sendCode(any)).called(1);
      },
    );
  });

  group("test resetPassword fn ", () {
    test(
      "when call resetPassword with correct parameters it should return SuccessResult<void>",
      () async {
        // arrange
        when(
          mockAuthApiServices.resetPass(any),
        ).thenAnswer((_) async => resetPassResponseModel);

        // act
        final res = await authRemoteDsImp.resetPassword(code: resetPassRequest);

        // assert
        expect(res, isA<SuccessResult<void>>());
        verify(mockAuthApiServices.resetPass(any)).called(1);
      },
    );

    //.....................................................................................

    test(
      "when DioException happens it should return FailedResult<void> with correct error message",
      () async {
        const String dioException = "dio Exception";
        final DioException mockDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          message: dioException,
        );

        when(mockAuthApiServices.resetPass(any)).thenThrow(mockDioException);

        // act
        final res = await authRemoteDsImp.resetPassword(code: resetPassRequest);

        // assert
        expect(res, isA<FailedResult<void>>());
        final acResult = res as FailedResult<void>;
        expect(
          acResult.errorMessage,
          ServerFailure.fromDioError(mockDioException).error,
        );

        verify(mockAuthApiServices.resetPass(any)).called(1);
      },
    );

    //.....................................................................................

    test(
      "when any other Exception happens it should return FailedResult<void> with that exception message",
      () async {
        const String exceptionMessage = "Unexpected Exception";
        final Exception mockException = Exception(exceptionMessage);

        when(mockAuthApiServices.resetPass(any)).thenThrow(mockException);

        // act
        final res = await authRemoteDsImp.resetPassword(code: resetPassRequest);

        // assert
        expect(res, isA<FailedResult<void>>());
        final acResult = res as FailedResult<void>;
        expect(
          acResult.errorMessage.toString(),
          "Exception: $exceptionMessage",
        );

        verify(mockAuthApiServices.resetPass(any)).called(1);
      },
    );
  });
}

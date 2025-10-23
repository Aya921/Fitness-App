import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';
import 'package:fitness/core/constants/exception_constant.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/client/auth_api_services.dart';
import 'package:fitness/features/auth/api/data_source_impl/remote/auth_remote_ds_impl.dart';
import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/auth/api/models/auth_response/body_info.dart';
import 'package:fitness/features/auth/api/models/auth_response/personal_info.dart';
import 'package:fitness/features/auth/api/models/auth_response/user_response.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_ds_impl_test.mocks.dart';

@GenerateMocks([AuthApiServices])
void main() {
  late MockAuthApiServices mockAuthApiServices;
  late AuthRemoteDsImpl authRemoteDsImpl;
  setUp(() {
    mockAuthApiServices = MockAuthApiServices();
    authRemoteDsImpl = AuthRemoteDsImpl(mockAuthApiServices);
  });
  group("Register Remote Data Source", () {
    final successResponse = AuthResponse(
      message: "success",
      user: UserResponse(
        personalInfo: const PersonalInfo(
          firstName: "Elevate",
          lastName: "Tech",
          email: "mariam2@gmail.com",
          gender: "female",
          photo: "default-profile.png",
          id: "68f664789762f45e2a989bd4",
          age: 70,
        ),

        bodyInfo: const BodyInfo(weight: 70, height: 170),
        activityLevel: "level1",
        goal: "Gain weight",

        createdAt: "2025-10-20T16:34:00.820Z",
      ),
      token:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhmNjY0Nzg5NzYyZjQ1ZTJhOTg5YmQ0IiwiaWF0IjoxNzYwOTc4MDQwfQ.0MZxirgu6bA-9Z1W2iZUY5IwDT3G7tl1KqxI88U72iA",
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
    test("return SuccessResult when api call success", () async {
      //Arrange
      when(
        mockAuthApiServices.register(request),
      ).thenAnswer((_) async => successResponse);
      //Act
      final result = await authRemoteDsImpl.register(request);
      final user=successResponse.user!.toEntity();
      //Assert
      expect(result, isA<Result<UserEntity>>());
      expect((result as SuccessResult).successResult, user);
      verify(mockAuthApiServices.register(request)).called(1);
    });
    test("return Failed Result when api failed on dio exception", ()async{
      final dioException=DioException(requestOptions: RequestOptions(
          path: "/"
      ),type: DioExceptionType.sendTimeout);
      //Arrange
      when(mockAuthApiServices.register(request)).thenThrow(dioException);
      //Act
      final result = await authRemoteDsImpl.register(request);
      //Assert
      expect(result, isA<Result>());
      expect((result as FailedResult).errorMessage,ExceptionConstants.sendTimeout );
      verify(mockAuthApiServices.register(request)).called(1);

    });
    test("return Failed Result when api failed on exception", ()async{
      final exception=Exception("throw Exception");
      when(mockAuthApiServices.register(request)).thenThrow(exception);
      //Act
      final result = await authRemoteDsImpl.register(request);
      //Assert
      expect(result, isA<Result>());
      expect((result as FailedResult).errorMessage,exception.toString() );
      verify(mockAuthApiServices.register(request)).called(1);
    });
  });
}
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:fitness/features/auth/data/data_source/local/auth_local_ds.dart';
import 'package:fitness/features/auth/data/data_source/remote/auth_remote_ds.dart';
import 'package:fitness/features/auth/data/repository_impl/auth_repo_impl.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDs, AuthLocalDs])
void main() {
  late MockAuthRemoteDs mockAuthRemoteDs;
  late MockAuthLocalDs mockAuthLocalDs;
  late AuthRepoImpl authRepoImpl;
  setUp(() {
    mockAuthRemoteDs = MockAuthRemoteDs();
    mockAuthLocalDs = MockAuthLocalDs();
    authRepoImpl = AuthRepoImpl(mockAuthRemoteDs, mockAuthLocalDs);
    provideDummy<Result<UserEntity>>(FailedResult("Dummy "));
  });
  group("Register Repo", () {
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
    test("return Success Result when remote data Source Success", () async {
      //Arrange
      when(
        mockAuthRemoteDs.register(request),
      ).thenAnswer((_) async => SuccessResult(successResponse));
      //Act
      final result = await authRepoImpl.register(request);
      //Assert
      expect(result, isA<Result>());
      expect((result as SuccessResult).successResult, successResponse);
      verify(mockAuthRemoteDs.register(request)).called(1);
    });
    test("return SuccessResult when remote data source failed", () async {
      final exception = Exception("Throw Exception");
      //Arrange
      when(
        mockAuthRemoteDs.register(request),
      ).thenAnswer((_) async => FailedResult(exception.toString()));
      //ACT
      final result = await authRepoImpl.register(request);
      //Assert
      expect(result, isA<Result>());
      expect((result as FailedResult).errorMessage, exception.toString());
      verify(mockAuthRemoteDs.register(request)).called(1);
    });
  });
}
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/data_source_impl/remote/auth_remote_ds_impl.dart';
import 'package:fitness/features/auth/data/repository_impl/auth_repo_impl.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDsImpl])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockAuthRemoteDsImpl mockAuthRemoteDsImpl;

  setUpAll(() {
    provideDummy<Result<AuthEntity>>(FailedResult("Dummy Error"));
    mockAuthRemoteDsImpl = MockAuthRemoteDsImpl();
    authRepoImpl = AuthRepoImpl(mockAuthRemoteDsImpl);
  });
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

  group("logIn test", () {
    test("Should return SuccessResult when data source success", () async {
      //arrange
      when(
        mockAuthRemoteDsImpl.logIn(any, any),
      ).thenAnswer((_) async => SuccessResult<AuthEntity>(fakeAuthEntity));

      //act
      final result = await authRepoImpl.logIn(email, password);

      //assert
      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = (result as SuccessResult<AuthEntity>).successResult;
      expect(success, fakeAuthEntity);
      expect(success.user?.personalInfo?.gender, "female");
      expect(success.user?.activityLevel, "Level 1");
      expect(success.user?.bodyInfo?.height, 165);
    });

    test("Should return FailedResult when data source failed", () async {
      //Arrange
      when(
        mockAuthRemoteDsImpl.logIn(any, any),
      ).thenAnswer((_) async => FailedResult("logIn errorMessage"));

      //Act
      final result = await authRepoImpl.logIn(email, password);

      //Assert
      expect(result, isA<FailedResult<AuthEntity>>());
      final failure = (result as FailedResult<AuthEntity>).errorMessage;
      expect(failure, contains("logIn errorMessage"));
    });
  });

  group("getLoggedUser test", () {
    test("Should return SuccessResult when data source success", () async {
      //arrange
      when(
        mockAuthRemoteDsImpl.getLoggedUser(),
      ).thenAnswer((_) async => SuccessResult<AuthEntity>(fakeAuthEntity));

      //act
      final result = await authRepoImpl.getLoggedUser();

      //assert
      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = (result as SuccessResult<AuthEntity>).successResult;
      expect(success, fakeAuthEntity);
      expect(success.user?.personalInfo?.gender, "female");
      expect(success.user?.activityLevel, "Level 1");
      expect(success.user?.bodyInfo?.height, 165);
    });

    test("Should return FailedResult when data source failed", () async {
      //Arrange
      when(
        mockAuthRemoteDsImpl.getLoggedUser(),
      ).thenAnswer((_) async => FailedResult("server errorMessage"));

      //Act
      final result = await authRepoImpl.getLoggedUser();

      //Assert
      expect(result, isA<FailedResult<AuthEntity>>());
      final failure = (result as FailedResult<AuthEntity>).errorMessage;
      expect(failure, contains("server errorMessage"));
    });
  });
}

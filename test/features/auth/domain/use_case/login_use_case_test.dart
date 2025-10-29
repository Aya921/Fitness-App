import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/data/repository_impl/auth_repo_impl.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/domain/use_case/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepoImpl])
void main() {
  late LoginUseCase signInUseCase;
  late MockAuthRepoImpl mockAuthRepoImpl;

  setUpAll(() {
    provideDummy<Result<AuthEntity>>(FailedResult("Dummy Error"));
    mockAuthRepoImpl = MockAuthRepoImpl();
    signInUseCase = LoginUseCase(mockAuthRepoImpl);
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

  test("Should return ApiSuccessResult when AuthRepo success", () async {
    //arrange
    when(
      mockAuthRepoImpl.logIn(any, any),
    ).thenAnswer((_) async => SuccessResult<AuthEntity>(fakeAuthEntity));

    //act
    final result = await signInUseCase.call(email, password);

    //assert
    expect(result, isA<SuccessResult<AuthEntity>>());
    final success = (result as SuccessResult<AuthEntity>).successResult;
    expect(success, fakeAuthEntity);
    expect(success.user?.personalInfo?.gender, "female");
    expect(success.user?.activityLevel, "Level 1");
    expect(success.user?.bodyInfo?.height, 165);
  });

  test("Should return ApiSuccessResult when authRepo failed", () async {
    //Arrange
    when(
      mockAuthRepoImpl.logIn(any, any),
    ).thenAnswer((_) async => FailedResult("sigIn errorMessage"));

    //Act
    final result = await signInUseCase.call(email, password);

    //Assert
    expect(result, isA<FailedResult<AuthEntity>>());
    final failure = (result as FailedResult<AuthEntity>).errorMessage;
    expect(failure, contains("sigIn errorMessage"));
  });
}

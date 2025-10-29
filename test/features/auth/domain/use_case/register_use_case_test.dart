import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/domain/repository/auth_repo.dart';
import 'package:fitness/features/auth/domain/use_case/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_use_case_test.mocks.dart';
@GenerateMocks([AuthRepo])
void main() {
late MockAuthRepo mockAuthRepo;
late RegisterUseCase registerUseCase;
setUp((){
  mockAuthRepo=MockAuthRepo();
  registerUseCase=RegisterUseCase(mockAuthRepo);
  provideDummy<Result<UserEntity>>(FailedResult("Dummy Error"));
});
const successResponse=UserEntity(
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
    bodyInfo: BodyInfoEntity(
        height: 170,
        weight: 60
    )
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
test("return Success Result when repo success", ()async{

  //  Arrange
  when(mockAuthRepo.register(request)).
  thenAnswer((_)async=>SuccessResult(successResponse));
  //Act
  final result=await registerUseCase.register(request);
  //Assert
  expect(result, isA<Result<UserEntity>>());
  expect((result as SuccessResult).successResult, successResponse);
  verify(mockAuthRepo.register(request)).called(1);
});
test("return Failed Result when repo failled", ()async{
const error="user already exist";
  //  Arrange
  when(mockAuthRepo.register(request)).
  thenAnswer((_)async=>FailedResult(error));
  //Act
  final result=await registerUseCase.register(request);
  //Assert
  expect(result, isA<Result<UserEntity>>());
  expect((result as FailedResult).errorMessage, error);
  verify(mockAuthRepo.register(request)).called(1);
});
}
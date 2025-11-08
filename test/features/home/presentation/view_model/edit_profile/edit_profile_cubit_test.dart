import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/enum/levels.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/domain/usecase/edit_profile/edit_profile_use_case.dart';
import 'package:fitness/features/home/domain/usecase/edit_profile/upload_photo_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase, UploadPhotoUseCase])
void main() {
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;
  late EditProfileCubit cubit;

  setUp(() {
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();
    cubit = EditProfileCubit(mockEditProfileUseCase, mockUploadPhotoUseCase);
  });

  const dummyUser = UserEntity(personalInfo: PersonalInfoEntity(firstName: "Aya", lastName: "Saber", email: "aya@test.com"));
  const dummyAuth = AuthEntity(user: dummyUser, token: "token");
  final dummyRequest = EditProfileRequest(firstName: "Aya", lastName: "Saber", email: "aya@test.com");

  blocTest<EditProfileCubit, EditProfileState>(
    'EditBtnSubmittedIntent emits loading -> success -> initial',
    build: () {
      final mockResult = SuccessResult<AuthEntity>(dummyAuth);
      provideDummy<Result<AuthEntity>>(mockResult);
      when(mockEditProfileUseCase.call(dummyRequest))
          .thenAnswer((_) async => mockResult);
      return cubit;
    },
    act: (bloc) => bloc.doIntent(intent: EditBtnSubmittedIntent(request: dummyRequest)),
    expect: () => [
      cubit.state.copyWith(editProfileStatus: const StateStatus.loading()),
      cubit.state.copyWith(
        editProfileStatus: const StateStatus.success(dummyAuth),
        hasChanges: false,
      ),
      cubit.state.copyWith(editProfileStatus: const StateStatus.initial()),
    ],
  );

  blocTest<EditProfileCubit, EditProfileState>(
    'EditBtnSubmittedIntent emits loading -> failure',
    build: () {
      final mockResult = FailedResult<AuthEntity>("error");
      provideDummy<Result<AuthEntity>>(mockResult);
      when(mockEditProfileUseCase.call(dummyRequest))
          .thenAnswer((_) async => mockResult);
      return cubit;
    },
    act: (bloc) => bloc.doIntent(intent: EditBtnSubmittedIntent(request: dummyRequest)),
    expect: () => [
      cubit.state.copyWith(editProfileStatus: const StateStatus.loading()),
      cubit.state.copyWith(
        editProfileStatus: const StateStatus.failure(ResponseException(message: "error")),
      ),
    ],
  );

  blocTest<EditProfileCubit, EditProfileState>(
    'WeightChangedIntent updates selectedWeight',
    build: () => cubit,
    act: (bloc) => bloc.doIntent(intent: WeightChangedIntent(70)),
    expect: () => [
      cubit.state.copyWith(selectedWeight: 70),
    ],
  );

  blocTest<EditProfileCubit, EditProfileState>(
    'GoalChangedIntent updates updatedGoal',
    build: () => cubit,
    act: (bloc) => bloc.doIntent(intent: GoalChangedIntent("Lose Weight")),
    expect: () => [
      cubit.state.copyWith(updatedGoal: "Lose Weight"),
    ],
  );

  blocTest<EditProfileCubit, EditProfileState>(
    'LevelChangedIntent updates updatedLevel',
    build: () => cubit,
    act: (bloc) => bloc.doIntent(intent: LevelChangedIntent(ActivityLevel.level1)),
    expect: () => [
      cubit.state.copyWith(updatedLevel: ActivityLevel.level1),
    ],
  );

 

 

}

import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/domain/use_case/get_logged_user_use_case.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/domain/usecase/explore_use_case/explore_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_intents.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'explore_cubit_test.mocks.dart';
@GenerateMocks([ ExploreUseCase, GetLoggedUserUseCase])
void main(){
TestWidgetsFlutterBinding.ensureInitialized();
late MockExploreUseCase mockExploreUseCase;
late MockGetLoggedUserUseCase mockGetLoggedUserUseCase;
late ExploreCubit exploreCubit;
late Result<AuthEntity> expectedAuthSuccessResult;
late Result<List<MusclesGroupEntity>> expectedMusclesGroupSuccessResult;
late Result<List<MuscleEntity>> expectedRandomMusclesSuccessResult;
late FailedResult<AuthEntity> expectedAuthFailedResult;
late FailedResult<List<MusclesGroupEntity>> expectedMusclesGroupFailedResult;
late FailedResult<List<MuscleEntity>> expectedRandomMusclesFailedResult;
late Result<MusclesGroupIdResponseEntity> expectedMuscleGroupByIdSuccessResult;
late FailedResult<MusclesGroupIdResponseEntity> expectedMuscleGroupByIdFailedResult;
setUpAll((){
  mockExploreUseCase = MockExploreUseCase();
  mockGetLoggedUserUseCase = MockGetLoggedUserUseCase();
  const authEntity = AuthEntity(
    message: 'success',
    token: 'token',
    user: UserEntity(
      activityLevel: 'active',
      createdAt: '2025',
      goal: 'lose weight',
      bodyInfo: BodyInfoEntity(
        height: 123,
        weight: 70
      ),
      personalInfo: PersonalInfoEntity(
        age: 33,
        email: 'test@example.com',
        firstName: 'omar',
        gender: 'male',
        lastName: 'ali',
        id: '1',
        photo: 'https://example.com/photo.jpg',
      )
    ) 
  );
  const muscleGroupEntity = MusclesGroupEntity(
    id: '1',
    name: 'chest'
  );
  const muscleEntity = MuscleEntity(
     id: '1',
     name: 'chest',
     image: 'https://example.com/muscle.jpg',
  );
  const musclesGroupIdResponseEntity =MusclesGroupIdResponseEntity(
    message: 'success',
    muscles: [muscleEntity],
    musclesGroup: muscleGroupEntity
  );
  expectedAuthSuccessResult = SuccessResult<AuthEntity>(authEntity);
  expectedMusclesGroupSuccessResult = SuccessResult<List<MusclesGroupEntity>>([muscleGroupEntity]);
  expectedRandomMusclesSuccessResult = SuccessResult<List<MuscleEntity>>([muscleEntity]);
  expectedMuscleGroupByIdSuccessResult = SuccessResult<MusclesGroupIdResponseEntity>(musclesGroupIdResponseEntity);
  expectedAuthFailedResult = FailedResult<AuthEntity>('failed');
  expectedMusclesGroupFailedResult = FailedResult<List<MusclesGroupEntity>>('failed');
  expectedRandomMusclesFailedResult = FailedResult<List<MuscleEntity>>('failed');
  expectedMuscleGroupByIdFailedResult = FailedResult<MusclesGroupIdResponseEntity>('failed');
  provideDummy<Result<AuthEntity>>(expectedAuthSuccessResult);
  provideDummy<Result<List<MusclesGroupEntity>>>(expectedMusclesGroupSuccessResult);
  provideDummy<Result<List<MuscleEntity>>>(expectedRandomMusclesSuccessResult);
  provideDummy<Result<MusclesGroupIdResponseEntity>>(expectedMuscleGroupByIdSuccessResult);
  provideDummy<Result<AuthEntity>>(expectedAuthFailedResult);
  provideDummy<Result<List<MusclesGroupEntity>>>(expectedMusclesGroupFailedResult);
  provideDummy<Result<List<MuscleEntity>>>(expectedRandomMusclesFailedResult);
  provideDummy<Result<MusclesGroupIdResponseEntity>>(expectedMuscleGroupByIdFailedResult);
});

setUp((){
  exploreCubit= ExploreCubit(mockExploreUseCase,mockGetLoggedUserUseCase);
});

blocTest<ExploreCubit, ExploreState>(
  'should emit [Loading,success] when getHomeData Success',
build: (){

  when(mockGetLoggedUserUseCase.call()).thenAnswer((_) async => expectedAuthSuccessResult);
  when(mockExploreUseCase.getMusclesGroup()).thenAnswer((_) async => expectedMusclesGroupSuccessResult);
  when(mockExploreUseCase.getRandomMuscles()).thenAnswer((_) async => expectedRandomMusclesSuccessResult);
  when(mockExploreUseCase.getAllMusclesGroupById('1')).thenAnswer((_) async => expectedMuscleGroupByIdSuccessResult);
  return exploreCubit;
},
act: (cubit) => [
  cubit.doIntent(intent: GetHomeData())
],

expect:() => [
 isA<ExploreState>()
      .having((state) => state.userData.isLoading, 'userData loading',equals(true))
      .having((state) => state.musclesGroupState.isInitial, 'musclesGroupState initial', equals(true))
      .having((state) => state.randomMusclesState.isInitial, 'randomMusclesState initial',equals(true))
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', equals(true)),
    
    isA<ExploreState>()
      .having((state) => state.userData.isLoading, 'userData loading', equals(true))
      .having((state) => state.musclesGroupState.isLoading, 'musclesGroupState loading', equals(true))
      .having((state) => state.randomMusclesState.isInitial, 'randomMusclesState initial', equals(true))
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', equals(true)),
    
    isA<ExploreState>()
      .having((state) => state.userData.isLoading, 'userData loading',equals(true))
      .having((state) => state.musclesGroupState.isLoading, 'musclesGroupState loading', equals(true))
      .having((state) => state.randomMusclesState.isLoading, 'randomMusclesState loading', equals(true))
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', equals(true)),
    
    isA<ExploreState>()
      .having((state) => state.userData.isSuccess, 'userData success', equals(true))
      .having((state) => state.musclesGroupState.isLoading, 'musclesGroupState loading', equals(true))
      .having((state) => state.randomMusclesState.isLoading, 'randomMusclesState loading',equals(true))
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial',equals(true)),
    
    isA<ExploreState>()
      .having((state) => state.userData.isSuccess, 'userData success', equals(true))
      .having((state) => state.musclesGroupState.isSuccess, 'musclesGroupState success', equals(true))
      .having((state) => state.randomMusclesState.isLoading, 'randomMusclesState loading',equals(true))
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', equals(true)),
    
    isA<ExploreState>()
      .having((state) => state.userData.isSuccess, 'userData success',equals(true))
      .having((state) => state.musclesGroupState.isSuccess, 'musclesGroupState success',equals(true))
      .having((state) => state.randomMusclesState.isLoading, 'randomMusclesState loading', equals(true))
      .having((state) => state.musclesGroupById.isLoading, 'musclesGroupById loading', equals(true)),
    isA<ExploreState>()
      .having((state) => state.userData.isSuccess, 'userData success',equals(true))
      .having((state) => state.musclesGroupState.isSuccess, 'musclesGroupState success',equals(true))
      .having((state) => state.randomMusclesState.isSuccess, 'randomMusclesState success', equals(true))
      .having((state) => state.musclesGroupById.isLoading, 'musclesGroupById loading', equals(true)),
    isA<ExploreState>()
      .having((state) => state.userData.isSuccess, 'userData success', equals(true))
      .having((state) => state.musclesGroupState.isSuccess, 'musclesGroupState success',equals(true))
      .having((state) => state.randomMusclesState.isSuccess, 'randomMusclesState success', equals(true))
      .having((state) => state.musclesGroupById.isSuccess, 'musclesGroupById success', equals(true)),
],
verify: (cubit) => [
  verify(mockGetLoggedUserUseCase.call()).called(1),
  verify(mockExploreUseCase.getMusclesGroup()).called(1),
  verify(mockExploreUseCase.getRandomMuscles()).called(1),
  verify(mockExploreUseCase.getAllMusclesGroupById('1')).called(1)
],
);

blocTest<ExploreCubit, ExploreState>(
  'should emit correct failure states when getHomeData fails',
  build: () {
    when(mockGetLoggedUserUseCase.call()).thenAnswer((_) async => expectedAuthFailedResult);
    when(mockExploreUseCase.getMusclesGroup()).thenAnswer((_) async => expectedMusclesGroupFailedResult);
    when(mockExploreUseCase.getRandomMuscles()).thenAnswer((_) async => expectedRandomMusclesFailedResult);
    
    return exploreCubit;
  },
  act: (cubit) => cubit.doIntent(intent: GetHomeData()),
  expect: () => [
   
    isA<ExploreState>()
      .having((state) => state.userData.isLoading, 'userData loading', true)
      .having((state) => state.musclesGroupState.isInitial, 'musclesGroupState initial', true)
      .having((state) => state.randomMusclesState.isInitial, 'randomMusclesState initial', true)
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', true),
    
    
    isA<ExploreState>()
      .having((state) => state.userData.isLoading, 'userData loading', true)
      .having((state) => state.musclesGroupState.isLoading, 'musclesGroupState loading', true)
      .having((state) => state.randomMusclesState.isInitial, 'randomMusclesState initial', true)
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', true),
    
  
    isA<ExploreState>()
      .having((state) => state.userData.isLoading, 'userData loading', true)
      .having((state) => state.musclesGroupState.isLoading, 'musclesGroupState loading', true)
      .having((state) => state.randomMusclesState.isLoading, 'randomMusclesState loading', true)
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', true),
    
    isA<ExploreState>()
      .having((state) => state.userData.isFailure, 'userData failure', true)
      .having((state) => state.musclesGroupState.isLoading, 'musclesGroupState loading', true)
      .having((state) => state.randomMusclesState.isLoading, 'randomMusclesState loading', true)
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', true),
    
    isA<ExploreState>()
      .having((state) => state.userData.isFailure, 'userData failure', true)
      .having((state) => state.musclesGroupState.isFailure, 'musclesGroupState failure', true)
      .having((state) => state.randomMusclesState.isLoading, 'randomMusclesState loading', true)
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', true),

    isA<ExploreState>()
      .having((state) => state.userData.isFailure, 'userData failure', true)
      .having((state) => state.musclesGroupState.isFailure, 'musclesGroupState failure', true)
      .having((state) => state.randomMusclesState.isFailure, 'randomMusclesState failure', true)
      .having((state) => state.musclesGroupById.isInitial, 'musclesGroupById initial', true),
  ],
  verify: (cubit) {
    verify(mockGetLoggedUserUseCase.call()).called(1);
    verify(mockExploreUseCase.getMusclesGroup()).called(1);
    verify(mockExploreUseCase.getRandomMuscles()).called(1);
   
  },
);
}
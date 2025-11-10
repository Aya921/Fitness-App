
import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/domain/use_case/get_logged_user_use_case.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/domain/use_case/explore_use_case/explore_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_intents.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'explore_cubit_test.mocks.dart';

@GenerateMocks([ExploreUseCase, GetLoggedUserUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ExploreCubit exploreCubit;
  late MockExploreUseCase mockExploreUseCase;
  late MockGetLoggedUserUseCase mockGetLoggedUserUseCase;

  // Success responses
  late Result<List<MusclesGroupEntity>> expectedMusclesGroupSuccessResult;
  late Result<List<MuscleEntity>> expectedRandomMusclesSuccessResult;
  late Result<MusclesGroupIdResponseEntity> expectedMusclesGroupByIdSuccessResult;
  late Result<AuthEntity> expectedUserDataSuccessResult;

  // Failure responses
  late FailedResult<List<MusclesGroupEntity>> expectedMusclesGroupFailureResult;
  late FailedResult<List<MuscleEntity>> expectedRandomMusclesFailureResult;
  late FailedResult<MusclesGroupIdResponseEntity> expectedMusclesGroupByIdFailureResult;
  late FailedResult<AuthEntity> expectedUserDataFailureResult;

  setUpAll(() {
    mockExploreUseCase = MockExploreUseCase();
    mockGetLoggedUserUseCase = MockGetLoggedUserUseCase();

    // Setup success responses
    const musclesGroupList = [
      MusclesGroupEntity(
        id: "67c79f3526895f87ce0aa96b",
        name: "Abdominals",
      ),
      MusclesGroupEntity(
        id: "67c79f3526895f87ce0aa96c",
        name: "Chest",
      ),
    ];
    expectedMusclesGroupSuccessResult = SuccessResult(musclesGroupList);

    const randomMusclesList = [
      MuscleEntity(
        id: "67cfa4ffc1b27e47567070fc",
        name: "Knee Hover Bird Dog",
        image: "https://example.com/exercise1.jpg",
      ),
      MuscleEntity(
        id: "67cfa4ffc1b27e4756707102",
        name: "Seated Ab Circles",
        image: "https://example.com/exercise2.jpg",
      ),
    ];
    expectedRandomMusclesSuccessResult = SuccessResult(randomMusclesList);

    const musclesGroupByIdResponse = MusclesGroupIdResponseEntity(
      message: "success",
      musclesGroup: MusclesGroupEntity(
        id: "67c79f3526895f87ce0aa96b",
        name: "Abdominals",
      ),
      muscles: [
        MuscleEntity(
          id: "67cfa4ffc1b27e47567070fc",
          name: "Knee Hover Bird Dog",
          image: "https://example.com/exercise1.jpg",
        ),
      ],
    );
    expectedMusclesGroupByIdSuccessResult = SuccessResult(musclesGroupByIdResponse);

    const authEntity = AuthEntity(
      token: "token123",
      user: UserEntity(
        personalInfo: PersonalInfoEntity(
          id: "user123",
          firstName: "John",
          lastName: "Doe",
          email: "john@example.com",
          gender: "male",
          age: 25,
          photo: "photo.jpg",
        ),
        bodyInfo: BodyInfoEntity(
          height: 180,
          weight: 75,
        ),
        activityLevel: "Level 1",
        goal: "Gain Weight",
      ),
    );
    expectedUserDataSuccessResult = SuccessResult(authEntity);

    // Setup failure responses
    expectedMusclesGroupFailureResult = FailedResult("Failed to fetch muscle groups");
    expectedRandomMusclesFailureResult = FailedResult("Failed to fetch random muscles");
    expectedMusclesGroupByIdFailureResult = FailedResult("Failed to fetch muscle group by id");
    expectedUserDataFailureResult = FailedResult("Failed to fetch user data");

    provideDummy<Result<List<MusclesGroupEntity>>>(expectedMusclesGroupSuccessResult);
    provideDummy<Result<List<MuscleEntity>>>(expectedRandomMusclesSuccessResult);
    provideDummy<Result<MusclesGroupIdResponseEntity>>(expectedMusclesGroupByIdSuccessResult);
    provideDummy<Result<AuthEntity>>(expectedUserDataSuccessResult);
  });

  setUp(() {
    exploreCubit = ExploreCubit(mockExploreUseCase, mockGetLoggedUserUseCase);
  });

  group('ExploreCubit initialization', () {
    blocTest<ExploreCubit, ExploreState>(
      'emits initial state on creation',
      build: () => exploreCubit,
      verify: (cubit) {
        expect(cubit.state, isA<ExploreState>());
        expect(cubit.state.musclesGroupState.isInitial, isTrue);
        expect(cubit.state.randomMusclesState.isInitial, isTrue);
        expect(cubit.state.musclesGroupById.isInitial, isTrue);
        expect(cubit.state.userData.isInitial, isTrue);
      },
    );
  });

  group('GetHomeData Intent', () {
//    blocTest<ExploreCubit, ExploreState>(
//   'emits [loading, success] states when all API calls succeed',
//   build: () {
//     when(mockGetLoggedUserUseCase.call())
//         .thenAnswer((_) async => expectedUserDataSuccessResult);
//     when(mockExploreUseCase.getMusclesGroup())
//         .thenAnswer((_) async => expectedMusclesGroupSuccessResult);
//     when(mockExploreUseCase.getRandomMuscles())
//         .thenAnswer((_) async => expectedRandomMusclesSuccessResult);
//     when(mockExploreUseCase.getAllMusclesGroupById(any))
//         .thenAnswer((_) async => expectedMusclesGroupByIdSuccessResult);
//     return exploreCubit;
//   },
//   act: (cubit) => cubit.doIntent(intent:  GetHomeData()),
//   expect: () => [
  
//     isA<ExploreState>()
//         .having(
//           (state) => state.userData.isLoading,
//           'userData.isLoading',
//           isTrue,
//         )
//         .having(
//           (state) => state.musclesGroupState.isLoading,
//           'musclesGroupState.isLoading',
//           isTrue,
//         )
//         .having(
//           (state) => state.randomMusclesState.isLoading,
//           'randomMusclesState.isLoading',
//           isTrue,
//         ),
//     // 4. userData completes (others still loading)
//     isA<ExploreState>()
//         .having(
//           (state) => state.userData.isSuccess,
//           'userData.isSuccess',
//           isTrue,
//         )
//         .having(
//           (state) => state.musclesGroupState.isSuccess,
//           'musclesGroupState.isLoading',
//           isTrue,
//         )
//         .having(
//           (state) => state.randomMusclesState.isSuccess,
//           'randomMusclesState.isLoading',
//           isTrue,
//         ),
   
//   ],
//   verify: (cubit) {
//     verify(mockGetLoggedUserUseCase.call()).called(1);
//     verify(mockExploreUseCase.getMusclesGroup()).called(1);
//     verify(mockExploreUseCase.getRandomMuscles()).called(1);
//     verify(mockExploreUseCase.getAllMusclesGroupById(any)).called(greaterThan(0));
//   },
// );

    blocTest<ExploreCubit, ExploreState>(
      'emits failure when getMusclesGroup fails',
      build: () {
        when(mockGetLoggedUserUseCase.call())
            .thenAnswer((_) async => expectedUserDataSuccessResult);
        when(mockExploreUseCase.getMusclesGroup())
            .thenAnswer((_) async => expectedMusclesGroupFailureResult);
        when(mockExploreUseCase.getRandomMuscles())
            .thenAnswer((_) async => expectedRandomMusclesSuccessResult);
        return exploreCubit;
      },
      act: (cubit) => cubit.doIntent(intent:  GetHomeData()),
      skip: 2, // Skip userData loading and success
      expect: () => [
        isA<ExploreState>().having(
          (state) => state.musclesGroupState.isLoading,
          'musclesGroupState.isLoading',
          isTrue,
        ),
        isA<ExploreState>().having(
          (state) => state.randomMusclesState.isLoading,
          'randomMusclesState.isLoading',
          isTrue,
        ),
        isA<ExploreState>().having(
          (state) => state.musclesGroupState.isFailure,
          'musclesGroupState.isFailure',
          isTrue,
        ),
        isA<ExploreState>().having(
          (state) => state.randomMusclesState.isSuccess,
          'randomMusclesState.isSuccess',
          isTrue,
        ),
      ],
      verify: (cubit) {
        verify(mockExploreUseCase.getMusclesGroup()).called(1);
      },
    );

    // blocTest<ExploreCubit, ExploreState>(
    //   'emits failure when getRandomMuscles fails',
    //   build: () {
    //     when(mockGetLoggedUserUseCase.call())
    //         .thenAnswer((_) async => expectedUserDataSuccessResult);
    //     when(mockExploreUseCase.getMusclesGroup())
    //         .thenAnswer((_) async => expectedMusclesGroupSuccessResult);
    //     when(mockExploreUseCase.getRandomMuscles())
    //         .thenAnswer((_) async => expectedRandomMusclesFailureResult);
    //     when(mockExploreUseCase.getAllMusclesGroupById(any))
    //         .thenAnswer((_) async => expectedMusclesGroupByIdSuccessResult);
    //     return exploreCubit;
    //   },
    //   act: (cubit) => cubit.doIntent(intent:  GetHomeData()),
    //   skip: 2, 
    //   expect: () => [
    //     isA<ExploreState>().having(
    //       (state) => state.musclesGroupState.isLoading,
    //       'musclesGroupState.isLoading',
    //       isTrue,
    //     ),
    //     isA<ExploreState>().having(
    //       (state) => state.randomMusclesState.isLoading,
    //       'randomMusclesState.isLoading',
    //       isTrue,
    //     ),
    //     isA<ExploreState>().having(
    //       (state) => state.musclesGroupState.isSuccess,
    //       'musclesGroupState.isSuccess',
    //       isTrue,
    //     ),
    //     isA<ExploreState>().having(
    //       (state) => state.musclesGroupById.isLoading,
    //       'musclesGroupById.isLoading',
    //       isTrue,
    //     ),
    //     isA<ExploreState>().having(
    //       (state) => state.randomMusclesState.isFailure,
    //       'randomMusclesState.isFailure',
    //       isTrue,
    //     ),
    //     isA<ExploreState>().having(
    //       (state) => state.musclesGroupById.isSuccess,
    //       'musclesGroupById.isSuccess',
    //       isTrue,
    //     ),
    //   ],
    //   verify: (cubit) {
    //     verify(mockExploreUseCase.getRandomMuscles()).called(1);
    //   },
    // );
  });

  group('GetMusclesGroupByIdIntent', () {
    const testId = "67c79f3526895f87ce0aa96b";

    blocTest<ExploreCubit, ExploreState>(
      'emits [loading, success] when API call succeeds',
      build: () {
        when(mockExploreUseCase.getAllMusclesGroupById(testId))
            .thenAnswer((_) async => expectedMusclesGroupByIdSuccessResult);
        return exploreCubit;
      },
      act: (cubit) => cubit.doIntent(
        intent:  GetMusclesGroupByIdIntent(id: testId),
      ),
      expect: () => [
        isA<ExploreState>().having(
          (state) => state.musclesGroupById.isLoading,
          'musclesGroupById.isLoading',
          isTrue,
        ),
        isA<ExploreState>().having(
          (state) => state.musclesGroupById.isSuccess,
          'musclesGroupById.isSuccess',
          isTrue,
        ),
      ],
      verify: (cubit) {
        verify(mockExploreUseCase.getAllMusclesGroupById(testId)).called(1);
      },
    );

    blocTest<ExploreCubit, ExploreState>(
      'emits [loading, failure] when API call fails',
      build: () {
        when(mockExploreUseCase.getAllMusclesGroupById(testId))
            .thenAnswer((_) async => expectedMusclesGroupByIdFailureResult);
        return exploreCubit;
      },
      act: (cubit) => cubit.doIntent(
        intent:  GetMusclesGroupByIdIntent(id: testId),
      ),
      expect: () => [
        isA<ExploreState>().having(
          (state) => state.musclesGroupById.isLoading,
          'musclesGroupById.isLoading',
          isTrue,
        ),
        isA<ExploreState>()
            .having(
              (state) => state.musclesGroupById.isFailure,
              'musclesGroupById.isFailure',
              isTrue,
            )
            .having(
              (state) => state.musclesGroupById.error is ResponseException
                  ? (state.musclesGroupById.error as ResponseException).message
                  : state.musclesGroupById.error,
              'error message',
              equals('Failed to fetch muscle group by id'),
            ),
      ],
      verify: (cubit) {
        verify(mockExploreUseCase.getAllMusclesGroupById(testId)).called(1);
      },
    );

    blocTest<ExploreCubit, ExploreState>(
      'does not call API when id is null',
      build: () => exploreCubit,
      act: (cubit) => cubit.doIntent(
        intent:  GetMusclesGroupByIdIntent(id: null),
      ),
      expect: () => [],
      verify: (cubit) {
        verifyNever(mockExploreUseCase.getAllMusclesGroupById(any));
      },
    );

   
  });

  group('Caching mechanism', () {
    const testId1 = "67c79f3526895f87ce0aa96b";
    const testId2 = "67c79f3526895f87ce0aa96c";

    blocTest<ExploreCubit, ExploreState>(
      'caches different muscle groups separately',
      build: () {
        when(mockExploreUseCase.getAllMusclesGroupById(testId1))
            .thenAnswer((_) async => expectedMusclesGroupByIdSuccessResult);
        when(mockExploreUseCase.getAllMusclesGroupById(testId2))
            .thenAnswer((_) async => expectedMusclesGroupByIdSuccessResult);
        return exploreCubit;
      },
      act: (cubit) async {
        await cubit.doIntent(
          intent:  GetMusclesGroupByIdIntent(id: testId1),
        );
        await cubit.doIntent(
          intent:  GetMusclesGroupByIdIntent(id: testId2),
        );
      },
      verify: (cubit) {
        verify(mockExploreUseCase.getAllMusclesGroupById(testId1)).called(1);
        verify(mockExploreUseCase.getAllMusclesGroupById(testId2)).called(1);
        expect(cubit.cachedMuscleGroups.containsKey(testId1), isTrue);
        expect(cubit.cachedMuscleGroups.containsKey(testId2), isTrue);
      },
    );
  });

  // group('GetLoggedUser', () {
  //   // blocTest<ExploreCubit, ExploreState>(
  //   //   'emits [loading, success] when user data fetch succeeds',
  //   //   build: () {
  //   //     when(mockGetLoggedUserUseCase.call())
  //   //         .thenAnswer((_) async => expectedUserDataSuccessResult);
  //   //     when(mockExploreUseCase.getMusclesGroup())
  //   //         .thenAnswer((_) async => expectedMusclesGroupSuccessResult);
  //   //     when(mockExploreUseCase.getRandomMuscles())
  //   //         .thenAnswer((_) async => expectedRandomMusclesSuccessResult);
  //   //     when(mockExploreUseCase.getAllMusclesGroupById(any))
  //   //         .thenAnswer((_) async => expectedMusclesGroupByIdSuccessResult);
  //   //     return exploreCubit;
  //   //   },
  //   //   act: (cubit) => cubit.doIntent(intent:  GetHomeData()),
  //   //   expect: () => [
  //   //     isA<ExploreState>().having(
  //   //       (state) => state.userData.isLoading,
  //   //       'userData.isLoading',
  //   //       isTrue,
  //   //     ),
  //   //     isA<ExploreState>().having(
  //   //       (state) => state.userData.isSuccess,
  //   //       'userData.isSuccess',
  //   //       isTrue,
  //   //     ),
  //   //     // Other states follow...
  //   //     isA<ExploreState>(),
  //   //     isA<ExploreState>(),
  //   //     isA<ExploreState>(),
  //   //     isA<ExploreState>(),
  //   //     isA<ExploreState>(),
  //   //     isA<ExploreState>(),
  //   //   ],
  //   //   verify: (cubit) {
  //   //     verify(mockGetLoggedUserUseCase.call()).called(1);
  //   //   },
  //   // );

  // });
}
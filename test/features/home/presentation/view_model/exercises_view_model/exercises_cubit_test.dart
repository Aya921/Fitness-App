import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_video_entity.dart';
import 'package:fitness/features/home/domain/usecase/get_difficulty_levels_by_muscle_use_case.dart';
import 'package:fitness/features/home/domain/usecase/get_exercises_by_difficulty_and_muscle_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_intent.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercises_cubit_test.mocks.dart';

@GenerateMocks([
  GetDifficultyLevelsByMuscleUseCase,
  GetExercisesByDifficultyAndMuscleUseCase,
])
void main() {
  late MockGetDifficultyLevelsByMuscleUseCase mockDifficultyLevelsUseCase;
  late MockGetExercisesByDifficultyAndMuscleUseCase mockExercisesUseCase;
  late ExercisesCubit cubit;

  const fakeLevels = [
    LevelEntity(id: "1", name: "Beginner"),
    LevelEntity(id: "2", name: "Intermediate"),
  ];

  const fakeExercises = [
    ExerciseEntity(
      id: "1",
      name: "Push-up",
      difficultyLevel: "Beginner",
      video: ExerciseVideoEntity(
        inDepthLink: "https://youtube.com/watch?v=123",
      ),
    ),
  ];

  setUp(() {
    provideDummy<Result<List<LevelEntity>>>(FailedResult("Dummy"));
    provideDummy<Result<List<ExerciseEntity>>>(FailedResult("Dummy"));
    mockDifficultyLevelsUseCase = MockGetDifficultyLevelsByMuscleUseCase();
    mockExercisesUseCase = MockGetExercisesByDifficultyAndMuscleUseCase();
    cubit = ExercisesCubit(mockDifficultyLevelsUseCase, mockExercisesUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('cubit test', () {
    blocTest<ExercisesCubit, ExercisesStates>(
      "loads levels and auto-loads first level exercises on success",
      build: () {
        when(
          mockDifficultyLevelsUseCase.call("muscle1"),
        ).thenAnswer((_) async => SuccessResult(fakeLevels));
        when(
          mockExercisesUseCase.call("muscle1", "1"),
        ).thenAnswer((_) async => SuccessResult(fakeExercises));
        return cubit;
      },
      act: (bloc) =>
          cubit.doIntent(intent: LoadLevelsByMuscleIntent(muscleId: "muscle1")),
      expect: () => [
        isA<ExercisesStates>().having(
          (s) => s.levelsByMuscleStatus.isLoading,
          'loading levels',
          true,
        ),

        isA<ExercisesStates>()
            .having(
              (s) => s.levelsByMuscleStatus.isSuccess,
              'success levels',
              true,
            )
            .having((s) => s.selectedLevelId, 'selected', "1")
            .having(
              (s) => s.exercisesByLevelAndMuscleStatus.isLoading,
              'loading exercises',
              true,
            ),

        isA<ExercisesStates>().having(
          (s) => s.exercisesByLevelAndMuscleStatus.isSuccess,
          'success exercises',
          true,
        ),
      ],
      verify: (_) {
        verify(mockDifficultyLevelsUseCase("muscle1")).called(1);
        verify(
          mockExercisesUseCase("muscle1", "1", page: anyNamed('page')),
        ).called(1);
      },
    );

    blocTest<ExercisesCubit, ExercisesStates>(
      "emits [loading, failure] when load levels fails",
      build: () {
        when(
          mockDifficultyLevelsUseCase.call("muscle1"),
        ).thenAnswer((_) async => FailedResult("error"));
        return cubit;
      },
      act: (bloc) =>
          cubit.doIntent(intent: LoadLevelsByMuscleIntent(muscleId: "muscle1")),
      expect: () => [
        isA<ExercisesStates>().having(
          (s) => s.levelsByMuscleStatus.isLoading,
          'loading levels',
          true,
        ),

        isA<ExercisesStates>().having(
          (s) => s.levelsByMuscleStatus.isFailure,
          'error levels',
          true,
        ),
      ],
    );

    blocTest<ExercisesCubit, ExercisesStates>(
      'Load levels empty list',
      build: () {
        when(mockDifficultyLevelsUseCase("muscle1"))
            .thenAnswer((_) async => SuccessResult(<LevelEntity>[]));
        return cubit;
      },
      act: (c) => c.doIntent(intent: LoadLevelsByMuscleIntent(muscleId: "muscle1")),
      expect: () => [
        isA<ExercisesStates>()
            .having((s) => s.levelsByMuscleStatus.isLoading, 'loading', true),
        isA<ExercisesStates>()
            .having((s) => s.levelsByMuscleStatus.isSuccess, 'success', true)
            .having((s) => s.levelsByMuscleStatus.data, 'empty list', isEmpty),
      ],
      verify: (_) => verifyNever(mockExercisesUseCase(any, any)),
    );

    blocTest<ExercisesCubit, ExercisesStates>(
      'resets page and loads new level exercises',
      seed: () => cubit.state.copyWith(
        selectedLevelId: "1",
        exercisesByLevelAndMuscleStatus: const StateStatus.success(fakeExercises),
      ),
      build: () {
        when(mockExercisesUseCase("muscle1", "2", page: 1))
            .thenAnswer((_) async => SuccessResult(fakeExercises));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        intent: ChangeSelectedLevelIntent(muscleId: "muscle1", levelId: "2"),
      ),
      expect: () => [
        cubit.state.copyWith(
          selectedLevelId: "1",
          exercisesByLevelAndMuscleStatus: const StateStatus.loading(),
        ),
        cubit.state.copyWith(
          selectedLevelId: "2",
          exercisesByLevelAndMuscleStatus: const StateStatus.success(fakeExercises),
        ),
      ],
      verify: (_) {
        verify(mockExercisesUseCase("muscle1", "2", page: 1)).called(1);
      },
    );

    blocTest<ExercisesCubit, ExercisesStates>(
      'Get YouTube ID success',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        intent: GetYoutubeIdIntent(
          videoUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
        ),
      ),
      expect: () => [
        cubit.state.copyWith(youtubeIdStatus: const StateStatus.loading()),
        cubit.state.copyWith(youtubeIdStatus: const StateStatus.success("dQw4w9WgXcQ")),
      ],
    );

    blocTest<ExercisesCubit, ExercisesStates>(
      'invalid youtube id',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        intent: GetYoutubeIdIntent(videoUrl: "https://example.com"),
      ),
      expect: () => [
        cubit.state.copyWith(youtubeIdStatus: const StateStatus.loading()),
        cubit.state.copyWith(
          youtubeIdStatus: const StateStatus.failure(
            ResponseException(message: "error fetching video id , this video is not available."),
          ),
        ),
      ],
    );

  });


}

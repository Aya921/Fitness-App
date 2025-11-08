import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/api/data_source_impl/exercises/exercises_ds_impl.dart';
import 'package:fitness/features/home/data/repo_impl/exercises/exercises_repo_impl.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/equipment_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_video_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/motion_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/muscle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercises_repo_impl_test.mocks.dart';

@GenerateMocks([ExercisestDsImpl])
void main() {
  late MockExercisestDsImpl mockExercisestDsImpl;
  late ExercisesRepoImpl exercisesRepoImpl;

  setUp(() {
    provideDummy<Result<List<LevelEntity>>>(FailedResult("Dummy"));
    provideDummy<Result<List<ExerciseEntity>>>(FailedResult("Dummy"));
    mockExercisestDsImpl = MockExercisestDsImpl();
    exercisesRepoImpl = ExercisesRepoImpl(mockExercisestDsImpl);
  });

  tearDown(() {
    reset(mockExercisestDsImpl);
  });
  group("test get levels by mover muscle impl", () {
    const List<LevelEntity> fakeLevelsList = [
      LevelEntity(id: "1", name: "level1"),
      LevelEntity(id: "2", name: "level2"),
    ];

    test("Should return SuccessResult when data source success", () async {
      //Arrange
      when(
        mockExercisestDsImpl.getDifficultyLevelsByPrimeMoverMuscles("1"),
      ).thenAnswer((_) async => SuccessResult(fakeLevelsList));

      //Act
      final Result<List<LevelEntity>> result = await exercisesRepoImpl
          .getDifficultyLevelsByPrimeMoverMuscles("1");

      //Assert
      expect(result, isA<SuccessResult<List<LevelEntity>>>());
      final List<LevelEntity> success =
          (result as SuccessResult<List<LevelEntity>>).successResult;
      expect(success.length, 2);
      expect(success, isNotEmpty);
      expect(success.first.id, "1");
      expect(success.last, isNotNull);
    });

    test("Should return FailedResult when data source failed", () async {
      //Arrange
      when(
        mockExercisestDsImpl.getDifficultyLevelsByPrimeMoverMuscles("1"),
      ).thenAnswer((_) async => FailedResult<List<LevelEntity>>("error"));

      //Act
      final Result<List<LevelEntity>> result = await exercisesRepoImpl
          .getDifficultyLevelsByPrimeMoverMuscles("1");

      //Assert
      expect(result, isNotNull);
      expect(result, isA<FailedResult<List<LevelEntity>>>());
      final FailedResult<List<LevelEntity>> failure =
          (result as FailedResult<List<LevelEntity>>);
      expect(result.errorMessage, isNotNull);
      expect(failure.errorMessage, "error");
    });
  });

  group("test get exercises by level and muscle", () {
    final List<ExerciseEntity> fakeExercisesList = [
      const ExerciseEntity(
        id: "1",
        name: "Bodyweight Bird Dog",
        difficultyLevel: "Beginner",
        bodyRegion: "Midsection",
        muscle: MuscleEntity(
          primeMover: "Rectus Abdominis",
          secondary: null,
          tertiary: null,
        ),
        equipment: EquipmentEntity(
          primaryEquipment: "Bodyweight",
          primaryItems: 1,
        ),
        motion: MotionEntity(mechanics: "Compound", forceType: "Other"),
        video: ExerciseVideoEntity(inDepthLink: "https://youtu.be/-LRjkbEy-qU"),
      ),
    ];

    test("Should return SuccessResult when data source success", () async {
      //Arrange
      when(
        mockExercisestDsImpl.getExercisesByMuscleAndDifficulty("1", "22"),
      ).thenAnswer((_) async => SuccessResult(fakeExercisesList));


    //Act
    final result = await exercisesRepoImpl.getExercisesByMuscleAndDifficulty(
      "1",
      "22",
    );

    //Assert
    expect(result, isNotNull);
    expect(result, isA<SuccessResult<List<ExerciseEntity>>>());
    final success =
        (result as SuccessResult<List<ExerciseEntity>>).successResult;
    expect(success, isNotEmpty);
    expect(success.length, 1);
    expect(success.first, success.last);
    expect(success.first.video, isNotNull);
    expect(success.first.motion?.movementPattern, null);
    });
  });
}

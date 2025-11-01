import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/api/data_source_impl/exercises_ds_impl.dart';
import 'package:fitness/features/home/api/models/exercises/all_exercises_response.dart';
import 'package:fitness/features/home/api/models/exercises/difficulty_by_prime_mover_muscles_response.dart';
import 'package:fitness/features/home/api/models/exercises/exercise_response.dart';
import 'package:fitness/features/home/api/models/exercises/level_response.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercises_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late ExercisestDsImpl exercisestDsImpl;

  setUpAll(() {
    mockApiServices = MockApiServices();
    exercisestDsImpl = ExercisestDsImpl(mockApiServices);
  });

  group("test get difficulty level by prime mover muscle", () {
    final DifficultyByPrimeMoverMusclesResponse fakeResponse =
        DifficultyByPrimeMoverMusclesResponse(
          message: "message",
          totalLevels: 7,
          difficultyLevels: [
            LevelResponse(name: "leve1", id: "1"),
            LevelResponse(name: "level2", id: "2"),
          ],
        );

    test("should returns SuccessResult when api return success", () async {
      //Arrange
      when(
        mockApiServices.getDifficultyLevelsByPrimeMoverMuscles(
          primeMoverMuscleId: "1",
        ),
      ).thenAnswer((_) async => fakeResponse);

      //Act
      final Result<List<LevelEntity>> result = await exercisestDsImpl
          .getDifficultyLevelsByPrimeMoverMuscles("1");

      //Assert
      expect(result, isA<SuccessResult<List<LevelEntity>>>());
      expect(result, isNotNull);
      final success =
          (result as SuccessResult<List<LevelEntity>>).successResult;
      expect(success, isNotEmpty);
      expect(success.length, 2);
      expect(success.first.id, "1");
      expect(success.last.name, "level2");
      verify(
        mockApiServices.getDifficultyLevelsByPrimeMoverMuscles(
          primeMoverMuscleId: "1",
        ),
      ).called(1);
    });

    test("should returns FailureResult when api fail", () async {
      //Arrange
      when(
        mockApiServices.getDifficultyLevelsByPrimeMoverMuscles(
          primeMoverMuscleId: "1",
        ),
      ).thenThrow(Exception("error"));

      //Act
      final Result<List<LevelEntity>> result = await exercisestDsImpl
          .getDifficultyLevelsByPrimeMoverMuscles("1");

      //Assert
      expect(result, isA<FailedResult<List<LevelEntity>>>());
      expect(result, isNotNull);
      final failure = (result as FailedResult<List<LevelEntity>>).errorMessage;
      expect(failure, isNotEmpty);
      expect(failure, Exception("error").toString());
    });

    test("should return empty list when difficultyLevels is null", () async {
      final emptyResponse = DifficultyByPrimeMoverMusclesResponse(
        message: "ok",
        totalLevels: 0,
        difficultyLevels: null,
      );

      when(
        mockApiServices.getDifficultyLevelsByPrimeMoverMuscles(
          primeMoverMuscleId: "1",
        ),
      ).thenAnswer((_) async => emptyResponse);

      final result = await exercisestDsImpl
          .getDifficultyLevelsByPrimeMoverMuscles("1");

      expect(result, isA<SuccessResult<List<LevelEntity>>>());
      final data = (result as SuccessResult).successResult;
      expect(data, isEmpty);
    });

    test("should map null fields correctly in ExerciseEntity", () async {
      final responseWithNulls = DifficultyByPrimeMoverMusclesResponse(
        difficultyLevels: [LevelResponse(id: "1")],
      );
      when(
        mockApiServices.getDifficultyLevelsByPrimeMoverMuscles(
          primeMoverMuscleId: "1",
        ),
      ).thenAnswer((_) async => responseWithNulls);

      final result = await exercisestDsImpl
          .getDifficultyLevelsByPrimeMoverMuscles("1");

      final level = (result as SuccessResult).successResult.first;

      expect(level.name, isNull);
      expect(level.id, "1");
    });
  });

  group("test get exercises by muscle and level", () {
    final AllExercisesResponse fakeResponse = AllExercisesResponse(
      message: "message",
      currentPage: 1,
      totalExercises: 15,
      totalPages: 2,
      exercises: [
        ExerciseResponse(
          id: "1",
          bodyRegion: "Midsection",
          difficultyLevel: "Beginner",
          exercise: "Bodyweight Bird Dog",
          primeMoverMuscle: "Rectus Abdominis",
        ),
        ExerciseResponse(
          id: "2",
          exercise: "Stability Ball Russian Twist",
          primaryEquipment: "Stability Ball",
          mechanics: "Compound",
        ),
      ],
    );

    test("should returns SuccessResult when api return success", () async {
      //Arrange
      when(
        mockApiServices.getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: "1",
          difficultyLevelId: "22",
        ),
      ).thenAnswer((_) async => fakeResponse);

      //Act
      final result = await exercisestDsImpl.getExercisesByMuscleAndDifficulty(
        "1",
        "22",
      );

      //Assert
      expect(result, isA<SuccessResult<List<ExerciseEntity>>>());
      expect(result, isNotNull);
      final success =
          (result as SuccessResult<List<ExerciseEntity>>).successResult;
      expect(success.length, 2);
      //first
      expect(success.first.id, "1");
      expect(success.first.name, "Bodyweight Bird Dog");
      expect(success.first.muscle?.primeMover, "Rectus Abdominis");
      expect(success.first.muscle, isNotNull);
      expect(success.first.difficultyLevel, "Beginner");
      expect(success.first.bodyRegion, "Midsection");
      expect(success.first.video?.inDepthLink, null);
      expect(success.first.motion?.forceType, null);
      //last
      expect(success.last.id, "2");
      expect(success.last.name, "Stability Ball Russian Twist");
      expect(success.last.equipment?.primaryEquipment, "Stability Ball");
      expect(success.last.motion?.mechanics, "Compound");
      expect(success.last.bodyRegion, null);
      expect(success.last.motion?.forceType, null);
      expect(success.last.video?.inDepthLink, null);
      verify(
        mockApiServices.getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: "1",
          difficultyLevelId: "22",
        ),
      ).called(1);
    });

    test("should returns FailureResult when api fail", () async {
      //Arrange
      when(
        mockApiServices.getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: "1",
          difficultyLevelId: "22",
        ),
      ).thenThrow(Exception("error"));

      //Act
      final Result<List<ExerciseEntity>> result = await exercisestDsImpl
          .getExercisesByMuscleAndDifficulty("1", "22");

      //Assert
      expect(result, isA<FailedResult<List<ExerciseEntity>>>());
      expect(result, isNotNull);
      final failure =
          (result as FailedResult<List<ExerciseEntity>>).errorMessage;
      expect(failure, isNotEmpty);
      expect(failure, Exception("error").toString());
    });

    test("should return empty list when exercises is null", () async {
      final emptyResponse = AllExercisesResponse(
        message: "ok",
        currentPage: 1,
        totalExercises: 0,
        totalPages: 0,
        exercises: null,
      );

      when(
        mockApiServices.getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: "1",
          difficultyLevelId: "22",
        ),
      ).thenAnswer((_) async => emptyResponse);

      final result = await exercisestDsImpl.getExercisesByMuscleAndDifficulty(
        "1",
        "22",
      );

      expect(result, isA<SuccessResult<List<ExerciseEntity>>>());
      final data = (result as SuccessResult).successResult;
      expect(data, isEmpty);
    });

    test("should pass page parameter correctly to API", () async {
      when(
        mockApiServices.getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: "1",
          difficultyLevelId: "22",
          page: 3,
        ),
      ).thenAnswer((_) async => fakeResponse);

      await exercisestDsImpl.getExercisesByMuscleAndDifficulty(
        "1",
        "22",
        page: 3,
      );

      verify(
        mockApiServices.getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: "1",
          difficultyLevelId: "22",
          page: 3,
        ),
      ).called(1);
    });

    test("should map null fields correctly in ExerciseEntity", () async {
      final responseWithNulls = AllExercisesResponse(
        exercises: [ExerciseResponse(id: "3", exercise: "Test Exercise")],
      );

      when(
        mockApiServices.getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: "1",
          difficultyLevelId: "22",
        ),
      ).thenAnswer((_) async => responseWithNulls);

      final result = await exercisestDsImpl.getExercisesByMuscleAndDifficulty(
        "1",
        "22",
      );
      final exercise = (result as SuccessResult).successResult.first;

      expect(exercise.bodyRegion, isNull);
      expect(exercise.difficultyLevel, isNull);
      expect(exercise.muscle.secondary, isNull);
      expect(exercise.equipment.primaryItems, isNull);
      expect(exercise.motion.planeOfMotion, isNull);
      expect(exercise.video.shortDemo, isNull);
    });
  });
}

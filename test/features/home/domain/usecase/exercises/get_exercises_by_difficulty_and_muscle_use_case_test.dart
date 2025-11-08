import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/repo_impl/exercises/exercises_repo_impl.dart';
import 'package:fitness/features/home/domain/entity/exercises/equipment_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_video_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/motion_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/muscle_entity.dart';
import 'package:fitness/features/home/domain/usecase/exercises/get_exercises_by_difficulty_and_muscle_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_exercises_by_difficulty_and_muscle_use_case_test.mocks.dart';


@GenerateMocks([ExercisesRepoImpl])
void main() {
late MockExercisesRepoImpl mockExercisesRepoImpl;
late GetExercisesByDifficultyAndMuscleUseCase useCase;

setUp(() {
  provideDummy<Result<List<ExerciseEntity>>>(FailedResult("Dummy"));
  mockExercisesRepoImpl =MockExercisesRepoImpl();
  useCase=GetExercisesByDifficultyAndMuscleUseCase(mockExercisesRepoImpl);
},);

group("description", () {
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
      mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22"),
    ).thenAnswer((_) async => SuccessResult(fakeExercisesList));

    //Act
    final result = await useCase.call(
      "1",
      "22",
    );

    //Assert
    expect(result, isNotNull);
    expect(result, isA<SuccessResult<List<ExerciseEntity>>>());
    final List<ExerciseEntity> success =
        (result as SuccessResult<List<ExerciseEntity>>).successResult;
    expect(success, isNotEmpty);
    expect(success.length, 1);
    expect(success.first.video, isNotNull);
    expect(success.first.motion?.movementPattern, null);
    expect(success.first.bodyRegion, "Midsection");
    expect(success.first.equipment, isNotNull);
    expect(success.first.equipment?.primaryEquipment, "Bodyweight");
    expect(success.first.muscle?.secondary, null);
    verify(mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22")).called(1);
  });

  test("Should return FailedResult when data source failed", () async {
    //Arrange
    when(
      mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22"),
    ).thenAnswer((_) async => FailedResult("error"));


    //Act
    final Result<List<ExerciseEntity>> result=await useCase.call("1", "22");


    //Assert
    expect(result, isA<FailedResult<List<ExerciseEntity>>>());
    final FailedResult<List<ExerciseEntity>> failure=(result as FailedResult<List<ExerciseEntity>>);
    expect(failure.errorMessage, isNotNull);
    expect(failure.errorMessage, contains("error"));
    verify(mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22")).called(1);
  });

  test("Should pass page parameter to data source", () async {
    //Arrange
    when(mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22", page: 5))
        .thenAnswer((_) async => SuccessResult(fakeExercisesList));

    //Act
    await useCase.call("1", "22", page: 5);

    //Assert
    verify(mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22", page: 5)).called(1);
  });

  test("Should use default page=1 when not provided", () async {
    //Arrange
    when(mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22"))
        .thenAnswer((_) async => SuccessResult(fakeExercisesList));

    //Act
    await useCase.call("1", "22");

    //Assert
    verify(mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22", page: 1)).called(1);
  });

  test("Should return empty SuccessResult when data source returns empty list", () async {
    //Arrange
    when(mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1","22"))
        .thenAnswer((_) async => SuccessResult(<ExerciseEntity>[]));

    //Act
    final result = await useCase.call("1","22");

    //Assert
    expect(result, isA<SuccessResult<List<ExerciseEntity>>>());
    expect((result as SuccessResult).successResult, isEmpty);
  });

  test("Should map null fields correctly", () async {
    const nullExercise = ExerciseEntity(id: "3", name: "Test");
    when(mockExercisesRepoImpl.getExercisesByMuscleAndDifficulty("1", "22"))
        .thenAnswer((_) async => SuccessResult([nullExercise]));

    final result = await useCase("1", "22");
    final exercise = (result as SuccessResult).successResult.first;

    expect(exercise.bodyRegion, isNull);
    expect(exercise.difficultyLevel, isNull);
    expect(exercise.muscle, isNull);
    expect(exercise.equipment, isNull);
    expect(exercise.motion, isNull);
    expect(exercise.video, isNull);
  });
},);
}
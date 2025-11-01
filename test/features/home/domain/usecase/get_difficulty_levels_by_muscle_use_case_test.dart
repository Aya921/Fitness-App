import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/repo_impl/exercises_repo_impl.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/usecase/get_difficulty_levels_by_muscle_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_difficulty_levels_by_muscle_use_case_test.mocks.dart';

@GenerateMocks([ExercisesRepoImpl])
void main() {
  late MockExercisesRepoImpl mockExercisesRepoImpl;
  late GetDifficultyLevelsByMuscleUseCase useCase;

  setUp(() {
    provideDummy<Result<List<LevelEntity>>>(FailedResult("Dummy"));
    mockExercisesRepoImpl = MockExercisesRepoImpl();
    useCase = GetDifficultyLevelsByMuscleUseCase(mockExercisesRepoImpl);
  });

  group("test get difficulty level use case", () {
    const List<LevelEntity> fakeLevelsList = [
      LevelEntity(id: "1", name: "level1"),
      LevelEntity(id: "2", name: "level2"),
    ];

    test("Should return ApiSuccessResult when Repo success", () async{
      //Arrange
      when(
        mockExercisesRepoImpl.getDifficultyLevelsByPrimeMoverMuscles("1"),
      ).thenAnswer((_) async => SuccessResult(fakeLevelsList));

    //Act
    final Result<List<LevelEntity>> result =await useCase.call("1");

      //Assert
      expect(result, isA<SuccessResult<List<LevelEntity>>>());
      final List<LevelEntity> success =
          (result as SuccessResult<List<LevelEntity>>).successResult;
      expect(success.length, 2);
      expect(success, isNotEmpty);
      expect(success.first.id, "1");
      expect(success.last, isNotNull);
      verify(mockExercisesRepoImpl.getDifficultyLevelsByPrimeMoverMuscles("1")).called(1);
    });

    test("Should return FailedResult when data source failed", () async {
      //Arrange
      when(
        mockExercisesRepoImpl.getDifficultyLevelsByPrimeMoverMuscles("1"),
      ).thenAnswer((_) async => FailedResult<List<LevelEntity>>("error"));

      //Act
      final Result<List<LevelEntity>> result = await useCase.call("1");

      //Assert
      expect(result, isNotNull);
      expect(result, isA<FailedResult<List<LevelEntity>>>());
      final FailedResult<List<LevelEntity>> failure =
      (result as FailedResult<List<LevelEntity>>);
      expect(result.errorMessage, isNotNull);
      expect(failure.errorMessage, contains("error"));
      verify(mockExercisesRepoImpl.getDifficultyLevelsByPrimeMoverMuscles("1")).called(1);
    });

    test("Should return empty SuccessResult when data source returns empty list", () async {
      //Arrange
      when(mockExercisesRepoImpl.getDifficultyLevelsByPrimeMoverMuscles("1"))
          .thenAnswer((_) async => SuccessResult(<LevelEntity>[]));

      //Act
      final result = await useCase.call("1");

      //Assert
      expect(result, isA<SuccessResult<List<LevelEntity>>>());
      expect((result as SuccessResult).successResult, isEmpty);
      verify(mockExercisesRepoImpl.getDifficultyLevelsByPrimeMoverMuscles("1")).called(1);
    });
});
}

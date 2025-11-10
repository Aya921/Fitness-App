import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/domain/repositories/explore_repositories/explore_repositories.dart';
import 'package:fitness/features/home/domain/use_case/explore_use_case/explore_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'explore_use_case_test.mocks.dart';

@GenerateMocks([ExploreRepositories])
void main() {
  late MockExploreRepositories mockExploreRepositories;
  late ExploreUseCase exploreUseCase;

  setUp(() {
    mockExploreRepositories = MockExploreRepositories();
    exploreUseCase = ExploreUseCase(mockExploreRepositories);

    provideDummy<Result<List<MusclesGroupEntity>>>(FailedResult("Dummy Error"));
    provideDummy<Result<List<MuscleEntity>>>(FailedResult("Dummy Error"));
    provideDummy<Result<MusclesGroupIdResponseEntity>>(
        FailedResult("Dummy Error"));
  });

  //======================= getMusclesGroup =======================//
  group("getMusclesGroup test", () {
    const successResponse = [
      MusclesGroupEntity(
        id: "67c79f3526895f87ce0aa96b",
        name: "Abdominals",
      ),
      MusclesGroupEntity(
        id: "67c79f3526895f87ce0aa96c",
        name: "Chest",
      ),
      MusclesGroupEntity(
        id: "67c79f3526895f87ce0aa96d",
        name: "Back",
      ),
    ];

    test("return Success Result when repository success", () async {
      // Arrange
      when(mockExploreRepositories.getMusclesGroup())
          .thenAnswer((_) async => SuccessResult(successResponse));

      // Act
      final result = await exploreUseCase.getMusclesGroup();

      // Assert
      expect(result, isA<Result<List<MusclesGroupEntity>>>());
      expect((result as SuccessResult).successResult, successResponse);
      expect((result as SuccessResult).successResult.length, equals(3));
      expect((result as SuccessResult).successResult[0].id, equals("67c79f3526895f87ce0aa96b"));
      expect((result as SuccessResult).successResult[0].name, equals("Abdominals"));
      expect((result as SuccessResult).successResult[1].id, equals("67c79f3526895f87ce0aa96c"));
      expect((result as SuccessResult).successResult[1].name, equals("Chest"));
      verify(mockExploreRepositories.getMusclesGroup()).called(1);
    });

    test("return Failed Result when repository failed", () async {
      const error = "Failed to fetch muscle groups";

      // Arrange
      when(mockExploreRepositories.getMusclesGroup())
          .thenAnswer((_) async => FailedResult(error));

      // Act
      final result = await exploreUseCase.getMusclesGroup();

      // Assert
      expect(result, isA<Result<List<MusclesGroupEntity>>>());
      expect((result as FailedResult).errorMessage, error);
      verify(mockExploreRepositories.getMusclesGroup()).called(1);
    });

    test("return Success Result with empty list when repository returns empty",
        () async {
      const emptyResponse = <MusclesGroupEntity>[];

      // Arrange
      when(mockExploreRepositories.getMusclesGroup())
          .thenAnswer((_) async => SuccessResult(emptyResponse));

      // Act
      final result = await exploreUseCase.getMusclesGroup();

      // Assert
      expect(result, isA<Result<List<MusclesGroupEntity>>>());
      expect((result as SuccessResult).successResult, isEmpty);
      verify(mockExploreRepositories.getMusclesGroup()).called(1);
    });
  });

  //======================= getRandomMuscles =======================//
  group("getRandomMuscles test", () {
    const successResponse = [
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
      MuscleEntity(
        id: "67cfa4ffc1b27e4756707105",
        name: "Lateral Kick Through",
        image: "https://example.com/exercise3.jpg",
      ),
    ];

    test("return Success Result when repository success", () async {
      // Arrange
      when(mockExploreRepositories.getRandomMuscles())
          .thenAnswer((_) async => SuccessResult(successResponse));

      // Act
      final result = await exploreUseCase.getRandomMuscles();

      // Assert
      expect(result, isA<Result<List<MuscleEntity>>>());
      expect((result as SuccessResult).successResult, successResponse);
      expect((result as SuccessResult).successResult.length, equals(3));
      expect((result as SuccessResult).successResult[0].id, equals("67cfa4ffc1b27e47567070fc"));
      expect((result as SuccessResult).successResult[0].name, equals("Knee Hover Bird Dog"));
      expect((result as SuccessResult).successResult[0].image,
          equals("https://example.com/exercise1.jpg"));
      expect((result as SuccessResult).successResult[1].id, equals("67cfa4ffc1b27e4756707102"));
      expect((result as SuccessResult).successResult[1].name, equals("Seated Ab Circles"));
      verify(mockExploreRepositories.getRandomMuscles()).called(1);
    });

    test("return Failed Result when repository failed", () async {
      const error = "Failed to fetch random muscles";

      // Arrange
      when(mockExploreRepositories.getRandomMuscles())
          .thenAnswer((_) async => FailedResult(error));

      // Act
      final result = await exploreUseCase.getRandomMuscles();

      // Assert
      expect(result, isA<Result<List<MuscleEntity>>>());
      expect((result as FailedResult).errorMessage, error);
      verify(mockExploreRepositories.getRandomMuscles()).called(1);
    });

    test("return Success Result with empty list when repository returns empty",
        () async {
      const emptyResponse = <MuscleEntity>[];

      // Arrange
      when(mockExploreRepositories.getRandomMuscles())
          .thenAnswer((_) async => SuccessResult(emptyResponse));

      // Act
      final result = await exploreUseCase.getRandomMuscles();

      // Assert
      expect(result, isA<Result<List<MuscleEntity>>>());
      expect((result as SuccessResult).successResult, isEmpty);
      verify(mockExploreRepositories.getRandomMuscles()).called(1);
    });
  });

  //======================= getAllMusclesGroupById =======================//
  group("getAllMusclesGroupById test", () {
    const String testId = "67c79f3526895f87ce0aa96b";
    const successResponse = MusclesGroupIdResponseEntity(
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
        MuscleEntity(
          id: "67cfa4ffc1b27e4756707102",
          name: "Seated Ab Circles",
          image: "https://example.com/exercise2.jpg",
        ),
      ],
    );

    test("return Success Result when repository success", () async {
      // Arrange
      when(mockExploreRepositories.getAllMusclesGroupById(testId))
          .thenAnswer((_) async => SuccessResult(successResponse));

      // Act
      final result = await exploreUseCase.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      expect((result as SuccessResult).successResult, successResponse);
      expect((result as SuccessResult).successResult.message, equals("success"));
      expect((result as SuccessResult).successResult.musclesGroup, isNotNull);
      expect((result as SuccessResult).successResult.musclesGroup?.id,
          equals("67c79f3526895f87ce0aa96b"));
      expect((result as SuccessResult).successResult.musclesGroup?.name, equals("Abdominals"));
      expect((result as SuccessResult).successResult.muscles, isNotNull);
      expect((result as SuccessResult).successResult.muscles?.length, equals(2));
      expect((result as SuccessResult).successResult.muscles?[0].id,
          equals("67cfa4ffc1b27e47567070fc"));
      expect((result as SuccessResult).successResult.muscles?[0].name,
          equals("Knee Hover Bird Dog"));
      verify(mockExploreRepositories.getAllMusclesGroupById(testId)).called(1);
    });

    test("return Failed Result when repository failed", () async {
      const error = "Failed to fetch muscle group by id";

      // Arrange
      when(mockExploreRepositories.getAllMusclesGroupById(testId))
          .thenAnswer((_) async => FailedResult(error));

      // Act
      final result = await exploreUseCase.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      expect((result as FailedResult).errorMessage, error);
      verify(mockExploreRepositories.getAllMusclesGroupById(testId)).called(1);
    });

    test("return Success Result when id is null", () async {
      // Arrange
      when(mockExploreRepositories.getAllMusclesGroupById(null))
          .thenAnswer((_) async => SuccessResult(successResponse));

      // Act
      final result = await exploreUseCase.getAllMusclesGroupById(null);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      expect((result as SuccessResult).successResult, successResponse);
      verify(mockExploreRepositories.getAllMusclesGroupById(null)).called(1);
    });

    test("return Success Result with empty muscles list", () async {
      const emptyMusclesResponse = MusclesGroupIdResponseEntity(
        message: "success",
        musclesGroup: MusclesGroupEntity(
          id: "67c79f3526895f87ce0aa96b",
          name: "Abdominals",
        ),
        muscles: [],
      );

      // Arrange
      when(mockExploreRepositories.getAllMusclesGroupById(testId))
          .thenAnswer((_) async => SuccessResult(emptyMusclesResponse));

      // Act
      final result = await exploreUseCase.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      expect((result as SuccessResult).successResult.muscles, isNotNull);
      expect((result as SuccessResult).successResult.muscles, isEmpty);
      verify(mockExploreRepositories.getAllMusclesGroupById(testId)).called(1);
    });

    test("return Success Result with null values", () async {
      const nullResponse = MusclesGroupIdResponseEntity(
        message: null,
        musclesGroup: null,
        muscles: null,
      );

      // Arrange
      when(mockExploreRepositories.getAllMusclesGroupById(testId))
          .thenAnswer((_) async => SuccessResult(nullResponse));

      // Act
      final result = await exploreUseCase.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      expect((result as SuccessResult).successResult.message, isNull);
      expect((result as SuccessResult).successResult.musclesGroup, isNull);
      expect((result as SuccessResult).successResult.muscles, isNull);
      verify(mockExploreRepositories.getAllMusclesGroupById(testId)).called(1);
    });
  });
}
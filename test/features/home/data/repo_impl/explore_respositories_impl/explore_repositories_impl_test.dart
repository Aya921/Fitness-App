import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/explore_data_source/explore_data_source.dart';
import 'package:fitness/features/home/data/repositories/explore_repositories_impl/explore_repositories_impl.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'explore_repositories_impl_test.mocks.dart';

@GenerateMocks([ExploreDataSource])
void main() {
  late ExploreRepositoriesImpl exploreRepositoriesImpl;
  late MockExploreDataSource mockExploreDataSource;

  // Fake entities for testing
  late List<MusclesGroupEntity> fakeMusclesGroupList;
  late List<MuscleEntity> fakeRandomMusclesList;
  late MusclesGroupIdResponseEntity fakeMusclesGroupIdResponse;

  setUp(() {
    mockExploreDataSource = MockExploreDataSource();
    exploreRepositoriesImpl = ExploreRepositoriesImpl(mockExploreDataSource);

    provideDummy<Result<List<MusclesGroupEntity>>>(FailedResult("Dummy"));
    provideDummy<Result<List<MuscleEntity>>>(FailedResult("Dummy"));
    provideDummy<Result<MusclesGroupIdResponseEntity>>(FailedResult("Dummy"));

    fakeMusclesGroupList = const [
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

    fakeRandomMusclesList = const [
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

    fakeMusclesGroupIdResponse = const MusclesGroupIdResponseEntity(
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
  });

  //======================= getMusclesGroup =======================//
  group("getMusclesGroup test", () {
    test("Should return SuccessResult when data source success", () async {
      // Arrange
      when(mockExploreDataSource.getMusclesGroup())
          .thenAnswer((_) async => SuccessResult<List<MusclesGroupEntity>>(
              fakeMusclesGroupList));

      // Act
      final result = await exploreRepositoriesImpl.getMusclesGroup();

      // Assert
      expect(result, isA<SuccessResult<List<MusclesGroupEntity>>>());
      final success =
          (result as SuccessResult<List<MusclesGroupEntity>>).successResult;
      expect(success, fakeMusclesGroupList);
      expect(success.length, equals(3));
      expect(success[0].id, equals("67c79f3526895f87ce0aa96b"));
      expect(success[0].name, equals("Abdominals"));
      expect(success[1].id, equals("67c79f3526895f87ce0aa96c"));
      expect(success[1].name, equals("Chest"));
      expect(success[2].id, equals("67c79f3526895f87ce0aa96d"));
      expect(success[2].name, equals("Back"));
      verify(mockExploreDataSource.getMusclesGroup()).called(1);
    });

    test("Should return FailedResult when data source failed", () async {
      // Arrange
      when(mockExploreDataSource.getMusclesGroup()).thenAnswer(
          (_) async => FailedResult<List<MusclesGroupEntity>>(
              "Failed to fetch muscle groups"));

      // Act
      final result = await exploreRepositoriesImpl.getMusclesGroup();

      // Assert
      expect(result, isA<FailedResult<List<MusclesGroupEntity>>>());
      final failure =
          (result as FailedResult<List<MusclesGroupEntity>>).errorMessage;
      expect(failure, contains("Failed to fetch muscle groups"));
      verify(mockExploreDataSource.getMusclesGroup()).called(1);
    });

    test("Should return SuccessResult with empty list when data source returns empty",
        () async {
      // Arrange
      when(mockExploreDataSource.getMusclesGroup()).thenAnswer(
          (_) async => SuccessResult<List<MusclesGroupEntity>>(<MusclesGroupEntity>[]));

      // Act
      final result = await exploreRepositoriesImpl.getMusclesGroup();

      // Assert
      expect(result, isA<SuccessResult<List<MusclesGroupEntity>>>());
      final success =
          (result as SuccessResult<List<MusclesGroupEntity>>).successResult;
      expect(success, isEmpty);
      verify(mockExploreDataSource.getMusclesGroup()).called(1);
    });
  });

  //======================= getRandomMuscles =======================//
  group("getRandomMuscles test", () {
    test("Should return SuccessResult when data source success", () async {
      // Arrange
      when(mockExploreDataSource.getRandomMuscles())
          .thenAnswer((_) async =>
              SuccessResult<List<MuscleEntity>>(fakeRandomMusclesList));

      // Act
      final result = await exploreRepositoriesImpl.getRandomMuscles();

      // Assert
      expect(result, isA<SuccessResult<List<MuscleEntity>>>());
      final success = (result as SuccessResult<List<MuscleEntity>>).successResult;
      expect(success, fakeRandomMusclesList);
      expect(success.length, equals(3));
      expect(success[0].id, equals("67cfa4ffc1b27e47567070fc"));
      expect(success[0].name, equals("Knee Hover Bird Dog"));
      expect(success[0].image, equals("https://example.com/exercise1.jpg"));
      expect(success[1].id, equals("67cfa4ffc1b27e4756707102"));
      expect(success[1].name, equals("Seated Ab Circles"));
      expect(success[2].id, equals("67cfa4ffc1b27e4756707105"));
      expect(success[2].name, equals("Lateral Kick Through"));
      verify(mockExploreDataSource.getRandomMuscles()).called(1);
    });

    test("Should return FailedResult when data source failed", () async {
      // Arrange
      when(mockExploreDataSource.getRandomMuscles()).thenAnswer((_) async =>
          FailedResult<List<MuscleEntity>>("Failed to fetch random muscles"));

      // Act
      final result = await exploreRepositoriesImpl.getRandomMuscles();

      // Assert
      expect(result, isA<FailedResult<List<MuscleEntity>>>());
      final failure = (result as FailedResult<List<MuscleEntity>>).errorMessage;
      expect(failure, contains("Failed to fetch random muscles"));
      verify(mockExploreDataSource.getRandomMuscles()).called(1);
    });

    test("Should return SuccessResult with empty list when data source returns empty",
        () async {
      // Arrange
      when(mockExploreDataSource.getRandomMuscles()).thenAnswer(
          (_) async => SuccessResult<List<MuscleEntity>>(<MuscleEntity>[]));

      // Act
      final result = await exploreRepositoriesImpl.getRandomMuscles();

      // Assert
      expect(result, isA<SuccessResult<List<MuscleEntity>>>());
      final success = (result as SuccessResult<List<MuscleEntity>>).successResult;
      expect(success, isEmpty);
      verify(mockExploreDataSource.getRandomMuscles()).called(1);
    });
  });

  //======================= getAllMusclesGroupById =======================//
  group("getAllMusclesGroupById test", () {
    const String testId = "67c79f3526895f87ce0aa96b";

    test("Should return SuccessResult when data source success", () async {
      // Arrange
      when(mockExploreDataSource.getAllMusclesGroupById(testId)).thenAnswer(
          (_) async => SuccessResult<MusclesGroupIdResponseEntity>(
              fakeMusclesGroupIdResponse));

      // Act
      final result =
          await exploreRepositoriesImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<SuccessResult<MusclesGroupIdResponseEntity>>());
      final success =
          (result as SuccessResult<MusclesGroupIdResponseEntity>)
              .successResult;
      expect(success, fakeMusclesGroupIdResponse);
      expect(success.message, equals("success"));
      expect(success.musclesGroup, isNotNull);
      expect(success.musclesGroup?.id, equals("67c79f3526895f87ce0aa96b"));
      expect(success.musclesGroup?.name, equals("Abdominals"));
      expect(success.muscles, isNotNull);
      expect(success.muscles?.length, equals(2));
      expect(success.muscles?[0].id, equals("67cfa4ffc1b27e47567070fc"));
      expect(success.muscles?[0].name, equals("Knee Hover Bird Dog"));
      verify(mockExploreDataSource.getAllMusclesGroupById(testId)).called(1);
    });

    test("Should return FailedResult when data source failed", () async {
      // Arrange
      when(mockExploreDataSource.getAllMusclesGroupById(testId)).thenAnswer(
          (_) async => FailedResult<MusclesGroupIdResponseEntity>(
              "Failed to fetch muscle group by id"));

      // Act
      final result =
          await exploreRepositoriesImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<FailedResult<MusclesGroupIdResponseEntity>>());
      final failure =
          (result as FailedResult<MusclesGroupIdResponseEntity>).errorMessage;
      expect(failure, contains("Failed to fetch muscle group by id"));
      verify(mockExploreDataSource.getAllMusclesGroupById(testId)).called(1);
    });

    test("Should return SuccessResult when id is null", () async {
      // Arrange
      when(mockExploreDataSource.getAllMusclesGroupById(null)).thenAnswer(
          (_) async => SuccessResult<MusclesGroupIdResponseEntity>(
              fakeMusclesGroupIdResponse));

      // Act
      final result = await exploreRepositoriesImpl.getAllMusclesGroupById(null);

      // Assert
      expect(result, isA<SuccessResult<MusclesGroupIdResponseEntity>>());
      final success =
          (result as SuccessResult<MusclesGroupIdResponseEntity>)
              .successResult;
      expect(success, fakeMusclesGroupIdResponse);
      verify(mockExploreDataSource.getAllMusclesGroupById(null)).called(1);
    });

    test("Should return SuccessResult with empty muscles list", () async {
      // Arrange
      const emptyMusclesResponse = MusclesGroupIdResponseEntity(
        message: "success",
        musclesGroup: MusclesGroupEntity(
          id: "67c79f3526895f87ce0aa96b",
          name: "Abdominals",
        ),
        muscles: [],
      );
      when(mockExploreDataSource.getAllMusclesGroupById(testId)).thenAnswer(
          (_) async => SuccessResult<MusclesGroupIdResponseEntity>(
              emptyMusclesResponse));

      // Act
      final result =
          await exploreRepositoriesImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<SuccessResult<MusclesGroupIdResponseEntity>>());
      final success =
          (result as SuccessResult<MusclesGroupIdResponseEntity>)
              .successResult;
      expect(success.muscles, isNotNull);
      expect(success.muscles, isEmpty);
      verify(mockExploreDataSource.getAllMusclesGroupById(testId)).called(1);
    });

    test("Should return SuccessResult with null values", () async {
      // Arrange
      const nullResponse = MusclesGroupIdResponseEntity(
        message: null,
        musclesGroup: null,
        muscles: null,
      );
      when(mockExploreDataSource.getAllMusclesGroupById(testId)).thenAnswer(
          (_) async =>
              SuccessResult<MusclesGroupIdResponseEntity>(nullResponse));

      // Act
      final result =
          await exploreRepositoriesImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<SuccessResult<MusclesGroupIdResponseEntity>>());
      final success =
          (result as SuccessResult<MusclesGroupIdResponseEntity>)
              .successResult;
      expect(success.message, isNull);
      expect(success.musclesGroup, isNull);
      expect(success.muscles, isNull);
      verify(mockExploreDataSource.getAllMusclesGroupById(testId)).called(1);
    });
  });
}
import 'package:dio/dio.dart';
import 'package:fitness/core/constants/exception_constant.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/api/data_source_impl/explore_data_source_impl/explore_data_source_impl.dart';
import 'package:fitness/features/home/api/models/explore_models/muscle_group_model/muscle_group_model.dart';
import 'package:fitness/features/home/api/models/explore_models/muscle_model/muscle_model.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscle_group_by_id/muscle_group_id_response.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscles_group_response/muscles_group_response.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscles_random_response/muscles_random_response.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'explore_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late ExploreDataSourceImpl exploreDataSourceImpl;
  late MockApiServices mockApiServices;

  // Fake responses
  late MusclesGroupResponse fakeMusclesGroupResponse;
  late MusclesRandomResponse fakeMusclesRandomResponse;
  late MuscleGroupIdResponse fakeMuscleGroupIdResponse;

  setUpAll(() {
    mockApiServices = MockApiServices();
    exploreDataSourceImpl = ExploreDataSourceImpl(mockApiServices);

    fakeMusclesGroupResponse = const MusclesGroupResponse(
      message: "success",
      musclesGroup: [
        MuscleGroupModel(
          id: "67c79f3526895f87ce0aa96b",
          name: "Abdominals",
        ),
        MuscleGroupModel(
          id: "67c79f3526895f87ce0aa96c",
          name: "Chest",
        ),
        MuscleGroupModel(
          id: "67c79f3526895f87ce0aa96d",
          name: "Back",
        ),
      ],
    );

    fakeMusclesRandomResponse = const MusclesRandomResponse(
      message: "success",
      totalMuscles: 3,
      muscles: [
        MuscleModel(
          id: "67cfa4ffc1b27e47567070fc",
          name: "Knee Hover Bird Dog",
          image: "https://example.com/exercise1.jpg",
        ),
        MuscleModel(
          id: "67cfa4ffc1b27e4756707102",
          name: "Seated Ab Circles",
          image: "https://example.com/exercise2.jpg",
        ),
        MuscleModel(
          id: "67cfa4ffc1b27e4756707105",
          name: "Lateral Kick Through",
          image: "https://example.com/exercise3.jpg",
        ),
      ],
    );

    fakeMuscleGroupIdResponse = const MuscleGroupIdResponse(
      message: "success",
      musclesGroup: MuscleGroupModel(
        id: "67c79f3526895f87ce0aa96b",
        name: "Abdominals",
      ),
      muscles: [
        MuscleModel(
          id: "67cfa4ffc1b27e47567070fc",
          name: "Knee Hover Bird Dog",
          image: "https://example.com/exercise1.jpg",
        ),
        MuscleModel(
          id: "67cfa4ffc1b27e4756707102",
          name: "Seated Ab Circles",
          image: "https://example.com/exercise2.jpg",
        ),
      ],
    );
  });

  group("getMusclesGroup Tests", () {
    test("return SuccessResult when api call success", () async {
      // Arrange
      when(mockApiServices.getAllMusclesGroup())
          .thenAnswer((_) async => fakeMusclesGroupResponse);

      // Act
      final result = await exploreDataSourceImpl.getMusclesGroup();

      // Assert
      expect(result, isA<Result<List<MusclesGroupEntity>>>());
      expect((result as SuccessResult).successResult, isA<List<MusclesGroupEntity>>());
      expect((result as SuccessResult).successResult.length, equals(3));
      expect((result as SuccessResult).successResult[0].id, equals("67c79f3526895f87ce0aa96b"));
      expect((result as SuccessResult).successResult[0].name, equals("Abdominals"));
      expect((result as SuccessResult).successResult[1].id, equals("67c79f3526895f87ce0aa96c"));
      expect((result as SuccessResult).successResult[1].name, equals("Chest"));
      expect((result as SuccessResult).successResult[2].id, equals("67c79f3526895f87ce0aa96d"));
      expect((result as SuccessResult).successResult[2].name, equals("Back"));
      verify(mockApiServices.getAllMusclesGroup()).called(1);
    });

    test("return FailedResult when api failed on dio exception", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: "/"),
        type: DioExceptionType.sendTimeout,
      );

      when(mockApiServices.getAllMusclesGroup()).thenThrow(dioException);

      // Act
      final result = await exploreDataSourceImpl.getMusclesGroup();

      // Assert
      expect(result, isA<Result<List<MusclesGroupEntity>>>());
      expect((result as FailedResult).errorMessage,
          ExceptionConstants.sendTimeout);
      verify(mockApiServices.getAllMusclesGroup()).called(1);
    });

    test("return FailedResult when api failed on exception", () async {
      // Arrange
      final exception = Exception("throw Exception");
      when(mockApiServices.getAllMusclesGroup()).thenThrow(exception);

      // Act
      final result = await exploreDataSourceImpl.getMusclesGroup();

      // Assert
      expect(result, isA<Result<List<MusclesGroupEntity>>>());
      expect((result as FailedResult).errorMessage, exception.toString());
      verify(mockApiServices.getAllMusclesGroup()).called(1);
    });

    test("return empty list when musclesGroup is null", () async {
      // Arrange
      const emptyResponse = MusclesGroupResponse(
        message: "success",
        musclesGroup: null,
      );
      when(mockApiServices.getAllMusclesGroup())
          .thenAnswer((_) async => emptyResponse);

      // Act
      final result = await exploreDataSourceImpl.getMusclesGroup();

      // Assert
      expect(result, isA<Result<List<MusclesGroupEntity>>>());
      expect((result as SuccessResult).successResult, isEmpty);
      verify(mockApiServices.getAllMusclesGroup()).called(1);
    });
  });

  group("getRandomMuscles Tests", () {
    test("return SuccessResult when api call success", () async {
      // Arrange
      when(mockApiServices.getAllRandomMuscles())
          .thenAnswer((_) async => fakeMusclesRandomResponse);

      // Act
      final result = await exploreDataSourceImpl.getRandomMuscles();

      // Assert
      expect(result, isA<Result<List<MuscleEntity>>>());
      expect((result as SuccessResult).successResult, isA<List<MuscleEntity>>());
      expect((result as SuccessResult).successResult.length, equals(3));
      expect((result as SuccessResult).successResult[0].id, equals("67cfa4ffc1b27e47567070fc"));
      expect((result as SuccessResult).successResult[0].name, equals("Knee Hover Bird Dog"));
      expect((result as SuccessResult).successResult[0].image,
          equals("https://example.com/exercise1.jpg"));
      expect((result as SuccessResult).successResult[1].id, equals("67cfa4ffc1b27e4756707102"));
      expect((result as SuccessResult).successResult[1].name, equals("Seated Ab Circles"));
      expect((result as SuccessResult).successResult[2].id, equals("67cfa4ffc1b27e4756707105"));
      expect((result as SuccessResult).successResult[2].name, equals("Lateral Kick Through"));
      verify(mockApiServices.getAllRandomMuscles()).called(1);
    });

    test("return FailedResult when api failed on dio exception", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: "/"),
        type: DioExceptionType.connectionTimeout,
      );

      when(mockApiServices.getAllRandomMuscles()).thenThrow(dioException);

      // Act
      final result = await exploreDataSourceImpl.getRandomMuscles();

      // Assert
      expect(result, isA<Result<List<MuscleEntity>>>());
      expect((result as FailedResult).errorMessage,
          ExceptionConstants.connectionTimeout);
      verify(mockApiServices.getAllRandomMuscles()).called(1);
    });

    test("return FailedResult when api failed on exception", () async {
      // Arrange
      final exception = Exception("Network error");
      when(mockApiServices.getAllRandomMuscles()).thenThrow(exception);

      // Act
      final result = await exploreDataSourceImpl.getRandomMuscles();

      // Assert
      expect(result, isA<Result<List<MuscleEntity>>>());
      expect((result as FailedResult).errorMessage, exception.toString());
      verify(mockApiServices.getAllRandomMuscles()).called(1);
    });

    test("return empty list when muscles is null", () async {
      // Arrange
      const emptyResponse = MusclesRandomResponse(
        message: "success",
        totalMuscles: 0,
        muscles: null,
      );
      when(mockApiServices.getAllRandomMuscles())
          .thenAnswer((_) async => emptyResponse);

      // Act
      final result = await exploreDataSourceImpl.getRandomMuscles();

      // Assert
      expect(result, isA<Result<List<MuscleEntity>>>());
      expect((result as SuccessResult).successResult, isEmpty);
      verify(mockApiServices.getAllRandomMuscles()).called(1);
    });
  });

  group("getAllMusclesGroupById Tests", () {
    const String testId = "67c79f3526895f87ce0aa96b";

    test("return SuccessResult when api call success", () async {
      // Arrange
      when(mockApiServices.getAllMusclesGroupById(testId))
          .thenAnswer((_) async => fakeMuscleGroupIdResponse);

      // Act
      final result = await exploreDataSourceImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      final successResult =
          (result as SuccessResult<MusclesGroupIdResponseEntity>)
              .successResult;
      expect(successResult.message, equals("success"));
      expect(successResult.musclesGroup, isNotNull);
      expect(successResult.musclesGroup?.id, equals("67c79f3526895f87ce0aa96b"));
      expect(successResult.musclesGroup?.name, equals("Abdominals"));
      expect(successResult.muscles, isNotNull);
      expect(successResult.muscles?.length, equals(2));
      expect(successResult.muscles?[0].id, equals("67cfa4ffc1b27e47567070fc"));
      expect(
          successResult.muscles?[0].name, equals("Knee Hover Bird Dog"));
      verify(mockApiServices.getAllMusclesGroupById(testId)).called(1);
    });

    test("return FailedResult when api failed on dio exception", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: "/"),
        type: DioExceptionType.receiveTimeout,
      );

      when(mockApiServices.getAllMusclesGroupById(testId))
          .thenThrow(dioException);

      // Act
      final result = await exploreDataSourceImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      expect((result as FailedResult).errorMessage,
          ExceptionConstants.receiveTimeout);
      verify(mockApiServices.getAllMusclesGroupById(testId)).called(1);
    });

    test("return FailedResult when api failed on exception", () async {
      // Arrange
      final exception = Exception("Server error");
      when(mockApiServices.getAllMusclesGroupById(testId))
          .thenThrow(exception);

      // Act
      final result = await exploreDataSourceImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      expect((result as FailedResult).errorMessage, exception.toString());
      verify(mockApiServices.getAllMusclesGroupById(testId)).called(1);
    });

    test("return SuccessResult with null id parameter", () async {
      // Arrange
      when(mockApiServices.getAllMusclesGroupById(null))
          .thenAnswer((_) async => fakeMuscleGroupIdResponse);

      // Act
      final result = await exploreDataSourceImpl.getAllMusclesGroupById(null);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      expect((result as SuccessResult).successResult,
          isA<MusclesGroupIdResponseEntity>());
      verify(mockApiServices.getAllMusclesGroupById(null)).called(1);
    });

    test("return SuccessResult when muscles list is empty", () async {
      // Arrange
      const emptyMusclesResponse = MuscleGroupIdResponse(
        message: "success",
        musclesGroup: MuscleGroupModel(
          id: "67c79f3526895f87ce0aa96b",
          name: "Abdominals",
        ),
        muscles: [],
      );
      when(mockApiServices.getAllMusclesGroupById(testId))
          .thenAnswer((_) async => emptyMusclesResponse);

      // Act
      final result = await exploreDataSourceImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      final successResult =
          (result as SuccessResult<MusclesGroupIdResponseEntity>)
              .successResult;
      expect(successResult.muscles, isNotNull);
      expect(successResult.muscles, isEmpty);
      verify(mockApiServices.getAllMusclesGroupById(testId)).called(1);
    });

    test("return SuccessResult when response has null values", () async {
      // Arrange
      const nullResponse = MuscleGroupIdResponse(
        message: null,
        musclesGroup: null,
        muscles: null,
      );
      when(mockApiServices.getAllMusclesGroupById(testId))
          .thenAnswer((_) async => nullResponse);

      // Act
      final result = await exploreDataSourceImpl.getAllMusclesGroupById(testId);

      // Assert
      expect(result, isA<Result<MusclesGroupIdResponseEntity>>());
      final successResult =
          (result as SuccessResult<MusclesGroupIdResponseEntity>)
              .successResult;
      expect(successResult.message, isNull);
      expect(successResult.musclesGroup, isNull);
      expect(successResult.muscles, isNull);
      verify(mockApiServices.getAllMusclesGroupById(testId)).called(1);
    });
  });
}
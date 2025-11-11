import 'package:fitness/features/home/api/models/explore_models/muscle_group_model/muscle_group_model.dart';
import 'package:fitness/features/home/api/models/explore_models/muscle_model/muscle_model.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscle_group_by_id/muscle_group_id_response.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toEntity", () {
    test(
      "when call toEntity with null values it should return MusclesGroupIdResponseEntity with null values",
      () {
        // Arrange
        const MuscleGroupIdResponse muscleGroupIdResponse =
            MuscleGroupIdResponse(
              message: null,
              musclesGroup: null,
              muscles: null,
            );

        // Act
        final MusclesGroupIdResponseEntity actualResult = muscleGroupIdResponse
            .toEntity();

        // Assert
        expect(actualResult.message, equals(muscleGroupIdResponse.message));
        expect(
          actualResult.musclesGroup,
          equals(muscleGroupIdResponse.musclesGroup),
        );
        expect(actualResult.muscles, equals(muscleGroupIdResponse.muscles));
      },
    );

    test(
      "when call toEntity with non-nullable values it should return MusclesGroupIdResponseEntity with correct values",
      () {
        // Arrange
        const MuscleGroupIdResponse muscleGroupIdResponse =
            MuscleGroupIdResponse(
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

        // Act
        final MusclesGroupIdResponseEntity actualResult = muscleGroupIdResponse
            .toEntity();

        // Assert
        expect(actualResult.message, equals(muscleGroupIdResponse.message));
        expect(actualResult.message, equals("success"));

        expect(actualResult.musclesGroup, isNotNull);
        expect(
          actualResult.musclesGroup?.id,
          equals(muscleGroupIdResponse.musclesGroup?.id),
        );
        expect(
          actualResult.musclesGroup?.name,
          equals(muscleGroupIdResponse.musclesGroup?.name),
        );
        expect(
          actualResult.musclesGroup?.id,
          equals("67c79f3526895f87ce0aa96b"),
        );
        expect(actualResult.musclesGroup?.name, equals("Abdominals"));

        expect(actualResult.muscles, isNotNull);
        expect(actualResult.muscles?.length, equals(2));
        expect(actualResult.muscles?[0].id, equals("67cfa4ffc1b27e47567070fc"));
        expect(actualResult.muscles?[0].name, equals("Knee Hover Bird Dog"));
        expect(
          actualResult.muscles?[0].image,
          equals("https://example.com/exercise1.jpg"),
        );
        expect(actualResult.muscles?[1].id, equals("67cfa4ffc1b27e4756707102"));
        expect(actualResult.muscles?[1].name, equals("Seated Ab Circles"));
        expect(
          actualResult.muscles?[1].image,
          equals("https://example.com/exercise2.jpg"),
        );
      },
    );

    test(
      "when call toEntity with empty muscles list it should return MusclesGroupIdResponseEntity with empty list",
      () {
        // Arrange
        const MuscleGroupIdResponse muscleGroupIdResponse =
            MuscleGroupIdResponse(
              message: "success",
              musclesGroup: MuscleGroupModel(
                id: "67c79f3526895f87ce0aa96b",
                name: "Abdominals",
              ),
              muscles: [],
            );

        // Act
        final MusclesGroupIdResponseEntity actualResult = muscleGroupIdResponse
            .toEntity();

        // Assert
        expect(actualResult.muscles, isNotNull);
        expect(actualResult.muscles?.length, equals(0));
        expect(actualResult.muscles, isEmpty);
      },
    );
  });

  group("test JSON serialization", () {
    // test("toJson and fromJson should work correctly with all fields", () {
    //   // Arrange
    //   const MuscleGroupIdResponse muscleGroupIdResponse =
    //       MuscleGroupIdResponse(
    //     message: "success",
    //     musclesGroup: MuscleGroupModel(
    //       id: "67c79f3526895f87ce0aa96b",
    //       name: "Abdominals",
    //     ),
    //     muscles: [
    //       MuscleModel(
    //         id: "67cfa4ffc1b27e47567070fc",
    //         name: "Knee Hover Bird Dog",
    //         image: "https://example.com/exercise1.jpg",
    //       ),
    //       MuscleModel(
    //         id: "67cfa4ffc1b27e4756707102",
    //         name: "Seated Ab Circles",
    //         image: "https://example.com/exercise2.jpg",
    //       ),
    //     ],
    //   );

    //   // Act
    //   final json = muscleGroupIdResponse.toJson();
    //   final fromJson = MuscleGroupIdResponse.fromJson(json);

    //   // Assert
    //   expect(fromJson.message, equals(muscleGroupIdResponse.message));
    //   expect(fromJson.musclesGroup, equals(muscleGroupIdResponse.musclesGroup));
    //   expect(fromJson.muscles, equals(muscleGroupIdResponse.muscles));

    //   expect(json['message'], equals("success"));
    //   expect(json['muscleGroup'], isNotNull);
    //   expect(json['muscleGroup']['_id'], equals("67c79f3526895f87ce0aa96b"));
    //   expect(json['muscleGroup']['name'], equals("Abdominals"));
    //   expect(json['muscles'], isNotNull);
    //   expect(json['muscles'], isA<List>());
    //   expect((json['muscles'] as List).length, equals(2));
    // });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      const MuscleGroupIdResponse muscleGroupIdResponse = MuscleGroupIdResponse(
        message: null,
        musclesGroup: null,
        muscles: null,
      );

      // Act
      final json = muscleGroupIdResponse.toJson();
      final fromJson = MuscleGroupIdResponse.fromJson(json);

      // Assert
      expect(fromJson.message, isNull);
      expect(fromJson.musclesGroup, isNull);
      expect(fromJson.muscles, isNull);
    });

    test("fromJson should correctly map muscleGroup field from JSON", () {
      // Arrange
      final json = {
        'message': 'success',
        'muscleGroup': {'_id': '67c79f3526895f87ce0aa96b', 'name': 'Chest'},
        'muscles': [
          {
            '_id': '67cfa4ffc1b27e47567070fc',
            'name': 'Bench Press',
            'image': 'https://example.com/bench.jpg',
          },
        ],
      };

      // Act
      final fromJson = MuscleGroupIdResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.musclesGroup, isNotNull);
      expect(fromJson.musclesGroup?.id, equals('67c79f3526895f87ce0aa96b'));
      expect(fromJson.musclesGroup?.name, equals('Chest'));
      expect(fromJson.muscles, isNotNull);
      expect(fromJson.muscles?.length, equals(1));
      expect(fromJson.muscles?[0].id, equals('67cfa4ffc1b27e47567070fc'));
      expect(fromJson.muscles?[0].name, equals('Bench Press'));
    });

    test("fromJson should handle empty muscles list correctly", () {
      // Arrange
      final json = {
        'message': 'success',
        'muscleGroup': {
          '_id': '67c79f3526895f87ce0aa96b',
          'name': 'Abdominals',
        },
        'muscles': [],
      };

      // Act
      final fromJson = MuscleGroupIdResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.musclesGroup, isNotNull);
      expect(fromJson.muscles, isNotNull);
      expect(fromJson.muscles?.length, equals(0));
      expect(fromJson.muscles, isEmpty);
    });

    test("fromJson should handle partial data correctly", () {
      // Arrange
      final json = {
        'message': 'success',
        'muscleGroup': {
          '_id': '67c79f3526895f87ce0aa96b',
          'name': 'Abdominals',
        },
      };

      // Act
      final fromJson = MuscleGroupIdResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.musclesGroup, isNotNull);
      expect(fromJson.muscles, isNull);
    });
  });

  group("test Equatable", () {
    test(
      "two MuscleGroupIdResponse instances with same values should be equal",
      () {
        // Arrange
        const response1 = MuscleGroupIdResponse(
          message: "success",
          musclesGroup: MuscleGroupModel(
            id: "67c79f3526895f87ce0aa96b",
            name: "Abdominals",
          ),
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Knee Hover Bird Dog",
              image: "https://example.com/exercise.jpg",
            ),
          ],
        );
        const response2 = MuscleGroupIdResponse(
          message: "success",
          musclesGroup: MuscleGroupModel(
            id: "67c79f3526895f87ce0aa96b",
            name: "Abdominals",
          ),
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Knee Hover Bird Dog",
              image: "https://example.com/exercise.jpg",
            ),
          ],
        );

        // Assert
        expect(response1, equals(response2));
      },
    );

    test(
      "two MuscleGroupIdResponse instances with different values should not be equal",
      () {
        // Arrange
        const response1 = MuscleGroupIdResponse(
          message: "success",
          musclesGroup: MuscleGroupModel(
            id: "67c79f3526895f87ce0aa96b",
            name: "Abdominals",
          ),
          muscles: [],
        );
        const response2 = MuscleGroupIdResponse(
          message: "failed",
          musclesGroup: MuscleGroupModel(
            id: "67c79f3526895f87ce0aa96c",
            name: "Chest",
          ),
          muscles: [],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );

    test(
      "two MuscleGroupIdResponse instances with different muscles list should not be equal",
      () {
        // Arrange
        const response1 = MuscleGroupIdResponse(
          message: "success",
          musclesGroup: MuscleGroupModel(
            id: "67c79f3526895f87ce0aa96b",
            name: "Abdominals",
          ),
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Exercise 1",
              image: "https://example.com/ex1.jpg",
            ),
          ],
        );
        const response2 = MuscleGroupIdResponse(
          message: "success",
          musclesGroup: MuscleGroupModel(
            id: "67c79f3526895f87ce0aa96b",
            name: "Abdominals",
          ),
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e4756707102",
              name: "Exercise 2",
              image: "https://example.com/ex2.jpg",
            ),
          ],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );

    test(
      "two MuscleGroupIdResponse instances with null values should be equal",
      () {
        // Arrange
        const response1 = MuscleGroupIdResponse(
          message: null,
          musclesGroup: null,
          muscles: null,
        );
        const response2 = MuscleGroupIdResponse(
          message: null,
          musclesGroup: null,
          muscles: null,
        );

        // Assert
        expect(response1, equals(response2));
      },
    );

    test(
      "two MuscleGroupIdResponse instances with different number of muscles should not be equal",
      () {
        // Arrange
        const response1 = MuscleGroupIdResponse(
          message: "success",
          musclesGroup: MuscleGroupModel(
            id: "67c79f3526895f87ce0aa96b",
            name: "Abdominals",
          ),
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Exercise 1",
              image: "https://example.com/ex1.jpg",
            ),
          ],
        );
        const response2 = MuscleGroupIdResponse(
          message: "success",
          musclesGroup: MuscleGroupModel(
            id: "67c79f3526895f87ce0aa96b",
            name: "Abdominals",
          ),
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Exercise 1",
              image: "https://example.com/ex1.jpg",
            ),
            MuscleModel(
              id: "67cfa4ffc1b27e4756707102",
              name: "Exercise 2",
              image: "https://example.com/ex2.jpg",
            ),
          ],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );
  });
}

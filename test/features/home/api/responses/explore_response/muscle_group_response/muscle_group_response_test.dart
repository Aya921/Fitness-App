import 'package:fitness/features/home/api/models/explore_models/muscle_group_model/muscle_group_model.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscles_group_response/muscles_group_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test JSON serialization", () {
    //   test("toJson and fromJson should work correctly with all fields", () {
    //     // Arrange
    //     const MusclesGroupResponse musclesGroupResponse = MusclesGroupResponse(
    //       message: "success",
    //       musclesGroup: [
    //         MuscleGroupModel(
    //           id: "67c79f3526895f87ce0aa96b",
    //           name: "Abdominals",
    //         ),
    //         MuscleGroupModel(
    //           id: "67c79f3526895f87ce0aa96c",
    //           name: "Chest",
    //         ),
    //         MuscleGroupModel(
    //           id: "67c79f3526895f87ce0aa96d",
    //           name: "Back",
    //         ),
    //       ],
    //     );

    //     // Act
    //     final json = musclesGroupResponse.toJson();
    //     final fromJson = MusclesGroupResponse.fromJson(json);

    //     // Assert
    //     expect(fromJson.message, equals(musclesGroupResponse.message));
    //     expect(fromJson.musclesGroup, equals(musclesGroupResponse.musclesGroup));

    //     expect(json['message'], equals("success"));
    //     expect(json['musclesGroup'], isNotNull);
    //     expect(json['musclesGroup'], isA<List>());
    //     expect((json['musclesGroup'] as List).length, equals(3));
    //     expect((json['musclesGroup'] as List)[0]['_id'],
    //         equals("67c79f3526895f87ce0aa96b"));
    //     expect((json['musclesGroup'] as List)[0]['name'], equals("Abdominals"));
    //     expect((json['musclesGroup'] as List)[1]['_id'],
    //         equals("67c79f3526895f87ce0aa96c"));
    //     expect((json['musclesGroup'] as List)[1]['name'], equals("Chest"));
    //   });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      const MusclesGroupResponse musclesGroupResponse = MusclesGroupResponse(
        message: null,
        musclesGroup: null,
      );

      // Act
      final json = musclesGroupResponse.toJson();
      final fromJson = MusclesGroupResponse.fromJson(json);

      // Assert
      expect(fromJson.message, isNull);
      expect(fromJson.musclesGroup, isNull);
    });

    test("fromJson should correctly map musclesGroup field from JSON", () {
      // Arrange
      final json = {
        'message': 'success',
        'musclesGroup': [
          {'_id': '67c79f3526895f87ce0aa96b', 'name': 'Abdominals'},
          {'_id': '67c79f3526895f87ce0aa96c', 'name': 'Chest'},
        ],
      };

      // Act
      final fromJson = MusclesGroupResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.musclesGroup, isNotNull);
      expect(fromJson.musclesGroup?.length, equals(2));
      expect(fromJson.musclesGroup?[0].id, equals('67c79f3526895f87ce0aa96b'));
      expect(fromJson.musclesGroup?[0].name, equals('Abdominals'));
      expect(fromJson.musclesGroup?[1].id, equals('67c79f3526895f87ce0aa96c'));
      expect(fromJson.musclesGroup?[1].name, equals('Chest'));
    });

    test("fromJson should handle empty musclesGroup list correctly", () {
      // Arrange
      final json = {'message': 'success', 'musclesGroup': []};

      // Act
      final fromJson = MusclesGroupResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.musclesGroup, isNotNull);
      expect(fromJson.musclesGroup?.length, equals(0));
      expect(fromJson.musclesGroup, isEmpty);
    });

    test("fromJson should handle partial data correctly", () {
      // Arrange
      final json = {'message': 'success'};

      // Act
      final fromJson = MusclesGroupResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.musclesGroup, isNull);
    });

    // test("toJson should correctly serialize single muscle group", () {
    //   // Arrange
    //   const MusclesGroupResponse musclesGroupResponse = MusclesGroupResponse(
    //     message: "success",
    //     musclesGroup: [
    //       MuscleGroupModel(id: "67c79f3526895f87ce0aa96b", name: "Shoulders"),
    //     ],
    //   );

    //   // Act
    //   final json = musclesGroupResponse.toJson();

    //   // Assert
    //   expect(json['message'], equals("success"));
    //   expect(json['musclesGroup'], isNotNull);
    //   expect((json['musclesGroup'] as List).length, equals(1));
    //   expect(
    //     (json['musclesGroup'] as List)[0]['_id'],
    //     equals("67c79f3526895f87ce0aa96b"),
    //   );
    //   expect((json['musclesGroup'] as List)[0]['name'], equals("Shoulders"));
    // });

    test("fromJson should handle musclesGroup with null fields in items", () {
      // Arrange
      final json = {
        'message': 'success',
        'musclesGroup': [
          {'_id': '67c79f3526895f87ce0aa96b', 'name': 'Abdominals'},
          {'_id': null, 'name': null},
        ],
      };

      // Act
      final fromJson = MusclesGroupResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.musclesGroup, isNotNull);
      expect(fromJson.musclesGroup?.length, equals(2));
      expect(fromJson.musclesGroup?[0].id, equals('67c79f3526895f87ce0aa96b'));
      expect(fromJson.musclesGroup?[0].name, equals('Abdominals'));
      expect(fromJson.musclesGroup?[1].id, isNull);
      expect(fromJson.musclesGroup?[1].name, isNull);
    });
  });

  group("test Equatable", () {
    test(
      "two MusclesGroupResponse instances with same values should be equal",
      () {
        // Arrange
        const response1 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(
              id: "67c79f3526895f87ce0aa96b",
              name: "Abdominals",
            ),
            MuscleGroupModel(id: "67c79f3526895f87ce0aa96c", name: "Chest"),
          ],
        );
        const response2 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(
              id: "67c79f3526895f87ce0aa96b",
              name: "Abdominals",
            ),
            MuscleGroupModel(id: "67c79f3526895f87ce0aa96c", name: "Chest"),
          ],
        );

        // Assert
        expect(response1, equals(response2));
      },
    );

    test(
      "two MusclesGroupResponse instances with different values should not be equal",
      () {
        // Arrange
        const response1 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(
              id: "67c79f3526895f87ce0aa96b",
              name: "Abdominals",
            ),
          ],
        );
        const response2 = MusclesGroupResponse(
          message: "failed",
          musclesGroup: [
            MuscleGroupModel(id: "67c79f3526895f87ce0aa96c", name: "Chest"),
          ],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );

    test(
      "two MusclesGroupResponse instances with different musclesGroup list should not be equal",
      () {
        // Arrange
        const response1 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(
              id: "67c79f3526895f87ce0aa96b",
              name: "Abdominals",
            ),
          ],
        );
        const response2 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(id: "67c79f3526895f87ce0aa96c", name: "Chest"),
          ],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );

    test(
      "two MusclesGroupResponse instances with null values should be equal",
      () {
        // Arrange
        const response1 = MusclesGroupResponse(
          message: null,
          musclesGroup: null,
        );
        const response2 = MusclesGroupResponse(
          message: null,
          musclesGroup: null,
        );

        // Assert
        expect(response1, equals(response2));
      },
    );

    test(
      "two MusclesGroupResponse instances with different number of muscle groups should not be equal",
      () {
        // Arrange
        const response1 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(
              id: "67c79f3526895f87ce0aa96b",
              name: "Abdominals",
            ),
          ],
        );
        const response2 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(
              id: "67c79f3526895f87ce0aa96b",
              name: "Abdominals",
            ),
            MuscleGroupModel(id: "67c79f3526895f87ce0aa96c", name: "Chest"),
          ],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );

    test(
      "two MusclesGroupResponse instances with empty list should be equal",
      () {
        // Arrange
        const response1 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [],
        );
        const response2 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [],
        );

        // Assert
        expect(response1, equals(response2));
      },
    );

    test(
      "MusclesGroupResponse with empty list and null should not be equal",
      () {
        // Arrange
        const response1 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [],
        );
        const response2 = MusclesGroupResponse(
          message: "success",
          musclesGroup: null,
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );

    test(
      "two MusclesGroupResponse instances with different order should not be equal",
      () {
        // Arrange
        const response1 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(
              id: "67c79f3526895f87ce0aa96b",
              name: "Abdominals",
            ),
            MuscleGroupModel(id: "67c79f3526895f87ce0aa96c", name: "Chest"),
          ],
        );
        const response2 = MusclesGroupResponse(
          message: "success",
          musclesGroup: [
            MuscleGroupModel(id: "67c79f3526895f87ce0aa96c", name: "Chest"),
            MuscleGroupModel(
              id: "67c79f3526895f87ce0aa96b",
              name: "Abdominals",
            ),
          ],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );
  });
}

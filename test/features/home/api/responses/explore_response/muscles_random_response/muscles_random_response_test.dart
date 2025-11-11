import 'package:fitness/features/home/api/models/explore_models/muscle_model/muscle_model.dart';
import 'package:fitness/features/home/api/responses/explore_response/muscles_random_response/muscles_random_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test JSON serialization", () {
    // test("toJson and fromJson should work correctly with all fields", () {
    //   // Arrange
    //   const MusclesRandomResponse musclesRandomResponse =
    //       MusclesRandomResponse(
    //     message: "success",
    //     totalMuscles: 3,
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
    //       MuscleModel(
    //         id: "67cfa4ffc1b27e4756707105",
    //         name: "Lateral Kick Through",
    //         image: "https://example.com/exercise3.jpg",
    //       ),
    //     ],
    //   );

    //   // Act
    //   final json = musclesRandomResponse.toJson();
    //   final fromJson = MusclesRandomResponse.fromJson(json);

    //   // Assert
    //   expect(fromJson.message, equals(musclesRandomResponse.message));
    //   expect(fromJson.totalMuscles, equals(musclesRandomResponse.totalMuscles));
    //   expect(fromJson.muscles, equals(musclesRandomResponse.muscles));

    //   expect(json['message'], equals("success"));
    //   expect(json['totalMuscles'], equals(3));
    //   expect(json['muscles'], isNotNull);
    //   expect(json['muscles'], isA<List>());
    //   expect((json['muscles'] as List).length, equals(3));
    //   expect((json['muscles'] as List)[0]['_id'],
    //       equals("67cfa4ffc1b27e47567070fc"));
    //   expect((json['muscles'] as List)[0]['name'],
    //       equals("Knee Hover Bird Dog"));
    //   expect((json['muscles'] as List)[1]['_id'],
    //       equals("67cfa4ffc1b27e4756707102"));
    //   expect(
    //       (json['muscles'] as List)[1]['name'], equals("Seated Ab Circles"));
    // });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      const MusclesRandomResponse musclesRandomResponse = MusclesRandomResponse(
        message: null,
        totalMuscles: null,
        muscles: null,
      );

      // Act
      final json = musclesRandomResponse.toJson();
      final fromJson = MusclesRandomResponse.fromJson(json);

      // Assert
      expect(fromJson.message, isNull);
      expect(fromJson.totalMuscles, isNull);
      expect(fromJson.muscles, isNull);
    });

    test("fromJson should correctly map all fields from JSON", () {
      // Arrange
      final json = {
        'message': 'success',
        'totalMuscles': 2,
        'muscles': [
          {
            '_id': '67cfa4ffc1b27e47567070fc',
            'name': 'Bench Press',
            'image': 'https://example.com/bench.jpg',
          },
          {
            '_id': '67cfa4ffc1b27e4756707102',
            'name': 'Push Up',
            'image': 'https://example.com/pushup.jpg',
          },
        ],
      };

      // Act
      final fromJson = MusclesRandomResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.totalMuscles, equals(2));
      expect(fromJson.muscles, isNotNull);
      expect(fromJson.muscles?.length, equals(2));
      expect(fromJson.muscles?[0].id, equals('67cfa4ffc1b27e47567070fc'));
      expect(fromJson.muscles?[0].name, equals('Bench Press'));
      expect(
        fromJson.muscles?[0].image,
        equals('https://example.com/bench.jpg'),
      );
      expect(fromJson.muscles?[1].id, equals('67cfa4ffc1b27e4756707102'));
      expect(fromJson.muscles?[1].name, equals('Push Up'));
    });

    test("fromJson should handle empty muscles list correctly", () {
      // Arrange
      final json = {'message': 'success', 'totalMuscles': 0, 'muscles': []};

      // Act
      final fromJson = MusclesRandomResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.totalMuscles, equals(0));
      expect(fromJson.muscles, isNotNull);
      expect(fromJson.muscles?.length, equals(0));
      expect(fromJson.muscles, isEmpty);
    });

    test("fromJson should handle partial data correctly", () {
      // Arrange
      final json = {'message': 'success', 'totalMuscles': 5};

      // Act
      final fromJson = MusclesRandomResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.totalMuscles, equals(5));
      expect(fromJson.muscles, isNull);
    });

    // test("toJson should correctly serialize single muscle", () {
    //   // Arrange
    //   const MusclesRandomResponse musclesRandomResponse =
    //       MusclesRandomResponse(
    //     message: "success",
    //     totalMuscles: 1,
    //     muscles: [
    //       MuscleModel(
    //         id: "67cfa4ffc1b27e47567070fc",
    //         name: "Squat",
    //         image: "https://example.com/squat.jpg",
    //       ),
    //     ],
    //   );

    //   // Act
    //   final json = musclesRandomResponse.toJson();

    //   // Assert
    //   expect(json['message'], equals("success"));
    //   expect(json['totalMuscles'], equals(1));
    //   expect(json['muscles'], isNotNull);
    //   expect((json['muscles'] as List).length, equals(1));
    //   expect((json['muscles'] as List)[0]['_id'],
    //       equals("67cfa4ffc1b27e47567070fc"));
    //   expect((json['muscles'] as List)[0]['name'], equals("Squat"));
    // });

    test("fromJson should handle muscles with null fields in items", () {
      // Arrange
      final json = {
        'message': 'success',
        'totalMuscles': 2,
        'muscles': [
          {
            '_id': '67cfa4ffc1b27e47567070fc',
            'name': 'Bench Press',
            'image': 'https://example.com/bench.jpg',
          },
          {'_id': null, 'name': null, 'image': null},
        ],
      };

      // Act
      final fromJson = MusclesRandomResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.totalMuscles, equals(2));
      expect(fromJson.muscles, isNotNull);
      expect(fromJson.muscles?.length, equals(2));
      expect(fromJson.muscles?[0].id, equals('67cfa4ffc1b27e47567070fc'));
      expect(fromJson.muscles?[0].name, equals('Bench Press'));
      expect(fromJson.muscles?[1].id, isNull);
      expect(fromJson.muscles?[1].name, isNull);
      expect(fromJson.muscles?[1].image, isNull);
    });

    test("fromJson should handle totalMuscles as 0", () {
      // Arrange
      final json = {'message': 'success', 'totalMuscles': 0, 'muscles': []};

      // Act
      final fromJson = MusclesRandomResponse.fromJson(json);

      // Assert
      expect(fromJson.message, equals('success'));
      expect(fromJson.totalMuscles, equals(0));
      expect(fromJson.muscles, isEmpty);
    });
  });

  group("test Equatable", () {
    test(
      "two MusclesRandomResponse instances with same values should be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 2,
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Knee Hover Bird Dog",
              image: "https://example.com/exercise.jpg",
            ),
            MuscleModel(
              id: "67cfa4ffc1b27e4756707102",
              name: "Seated Ab Circles",
              image: "https://example.com/exercise2.jpg",
            ),
          ],
        );
        const response2 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 2,
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Knee Hover Bird Dog",
              image: "https://example.com/exercise.jpg",
            ),
            MuscleModel(
              id: "67cfa4ffc1b27e4756707102",
              name: "Seated Ab Circles",
              image: "https://example.com/exercise2.jpg",
            ),
          ],
        );

        // Assert
        expect(response1, equals(response2));
      },
    );

    test(
      "two MusclesRandomResponse instances with different values should not be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 1,
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Exercise 1",
              image: "https://example.com/ex1.jpg",
            ),
          ],
        );
        const response2 = MusclesRandomResponse(
          message: "failed",
          totalMuscles: 2,
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
      "two MusclesRandomResponse instances with different muscles list should not be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 1,
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Exercise 1",
              image: "https://example.com/ex1.jpg",
            ),
          ],
        );
        const response2 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 1,
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
      "two MusclesRandomResponse instances with null values should be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: null,
          totalMuscles: null,
          muscles: null,
        );
        const response2 = MusclesRandomResponse(
          message: null,
          totalMuscles: null,
          muscles: null,
        );

        // Assert
        expect(response1, equals(response2));
      },
    );

    test(
      "two MusclesRandomResponse instances with different totalMuscles should not be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 5,
          muscles: [],
        );
        const response2 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 10,
          muscles: [],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );

    test(
      "two MusclesRandomResponse instances with different number of muscles should not be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 1,
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Exercise 1",
              image: "https://example.com/ex1.jpg",
            ),
          ],
        );
        const response2 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 2,
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

    test(
      "two MusclesRandomResponse instances with empty list should be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 0,
          muscles: [],
        );
        const response2 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 0,
          muscles: [],
        );

        // Assert
        expect(response1, equals(response2));
      },
    );

    test(
      "MusclesRandomResponse with empty list and null should not be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 0,
          muscles: [],
        );
        const response2 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 0,
          muscles: null,
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );

    test(
      "two MusclesRandomResponse instances with different order should not be equal",
      () {
        // Arrange
        const response1 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 2,
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Exercise A",
              image: "https://example.com/a.jpg",
            ),
            MuscleModel(
              id: "67cfa4ffc1b27e4756707102",
              name: "Exercise B",
              image: "https://example.com/b.jpg",
            ),
          ],
        );
        const response2 = MusclesRandomResponse(
          message: "success",
          totalMuscles: 2,
          muscles: [
            MuscleModel(
              id: "67cfa4ffc1b27e4756707102",
              name: "Exercise B",
              image: "https://example.com/b.jpg",
            ),
            MuscleModel(
              id: "67cfa4ffc1b27e47567070fc",
              name: "Exercise A",
              image: "https://example.com/a.jpg",
            ),
          ],
        );

        // Assert
        expect(response1, isNot(equals(response2)));
      },
    );
  });
}

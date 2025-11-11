import 'package:fitness/features/home/api/models/explore_models/muscle_model/muscle_model.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toEntity", () {
    test(
      "when call toEntity with null values it should return MuscleEntity with null values",
      () {
        // Arrange
        const MuscleModel muscleModel = MuscleModel(
          id: null,
          name: null,
          image: null,
        );

        // Act
        final MuscleEntity actualResult = muscleModel.toEntity();

        // Assert
        expect(actualResult.id, equals(muscleModel.id));
        expect(actualResult.name, equals(muscleModel.name));
        expect(actualResult.image, equals(muscleModel.image));
      },
    );

    test(
      "when call toEntity with non-nullable values it should return MuscleEntity with correct values",
      () {
        // Arrange
        const MuscleModel muscleModel = MuscleModel(
          id: "67cfa4ffc1b27e47567070fc",
          name: "Knee Hover Bird Dog",
          image: "https://example.com/exercise.jpg",
        );

        // Act
        final MuscleEntity actualResult = muscleModel.toEntity();

        // Assert
        expect(actualResult.id, equals(muscleModel.id));
        expect(actualResult.name, equals(muscleModel.name));
        expect(actualResult.image, equals(muscleModel.image));
        expect(actualResult.id, equals("67cfa4ffc1b27e47567070fc"));
        expect(actualResult.name, equals("Knee Hover Bird Dog"));
        expect(actualResult.image, equals("https://example.com/exercise.jpg"));
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly with all fields", () {
      // Arrange
      const MuscleModel muscleModel = MuscleModel(
        id: "67cfa4ffc1b27e47567070fc",
        name: "Knee Hover Bird Dog",
        image: "https://example.com/exercise.jpg",
      );

      // Act
      final json = muscleModel.toJson();
      final fromJson = MuscleModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals(muscleModel.id));
      expect(fromJson.name, equals(muscleModel.name));
      expect(fromJson.image, equals(muscleModel.image));
      expect(json['_id'], equals("67cfa4ffc1b27e47567070fc"));
      expect(json['name'], equals("Knee Hover Bird Dog"));
      expect(json['image'], equals("https://example.com/exercise.jpg"));
    });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      const MuscleModel muscleModel = MuscleModel(
        id: null,
        name: null,
        image: null,
      );

      // Act
      final json = muscleModel.toJson();
      final fromJson = MuscleModel.fromJson(json);

      // Assert
      expect(fromJson.id, isNull);
      expect(fromJson.name, isNull);
      expect(fromJson.image, isNull);
    });

    test("fromJson should correctly map _id field from JSON", () {
      // Arrange
      final json = {
        '_id': '67cfa4ffc1b27e47567070fc',
        'name': 'Bench Press',
        'image': 'https://example.com/bench-press.jpg',
      };

      // Act
      final fromJson = MuscleModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals('67cfa4ffc1b27e47567070fc'));
      expect(fromJson.name, equals('Bench Press'));
      expect(fromJson.image, equals('https://example.com/bench-press.jpg'));
    });

    test("fromJson should handle partial data correctly", () {
      // Arrange
      final json = {
        '_id': '67cfa4ffc1b27e47567070fc',
        'name': 'Push Up',
      };

      // Act
      final fromJson = MuscleModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals('67cfa4ffc1b27e47567070fc'));
      expect(fromJson.name, equals('Push Up'));
      expect(fromJson.image, isNull);
    });
  });

  group("test Equatable", () {
    test("two MuscleModel instances with same values should be equal", () {
      // Arrange
      const model1 = MuscleModel(
        id: "67cfa4ffc1b27e47567070fc",
        name: "Knee Hover Bird Dog",
        image: "https://example.com/exercise.jpg",
      );
      const model2 = MuscleModel(
        id: "67cfa4ffc1b27e47567070fc",
        name: "Knee Hover Bird Dog",
        image: "https://example.com/exercise.jpg",
      );

      // Assert
      expect(model1, equals(model2));
    });

    test("two MuscleModel instances with different values should not be equal", () {
      // Arrange
      const model1 = MuscleModel(
        id: "67cfa4ffc1b27e47567070fc",
        name: "Knee Hover Bird Dog",
        image: "https://example.com/exercise.jpg",
      );
      const model2 = MuscleModel(
        id: "67cfa4ffc1b27e47567070fd",
        name: "Push Up",
        image: "https://example.com/pushup.jpg",
      );

      // Assert
      expect(model1, isNot(equals(model2)));
    });

    test("two MuscleModel instances with different image should not be equal", () {
      // Arrange
      const model1 = MuscleModel(
        id: "67cfa4ffc1b27e47567070fc",
        name: "Bench Press",
        image: "https://example.com/image1.jpg",
      );
      const model2 = MuscleModel(
        id: "67cfa4ffc1b27e47567070fc",
        name: "Bench Press",
        image: "https://example.com/image2.jpg",
      );

      // Assert
      expect(model1, isNot(equals(model2)));
    });

    test("two MuscleModel instances with null values should be equal", () {
      // Arrange
      const model1 = MuscleModel(
        id: null,
        name: null,
        image: null,
      );
      const model2 = MuscleModel(
        id: null,
        name: null,
        image: null,
      );

      // Assert
      expect(model1, equals(model2));
    });
  });
}
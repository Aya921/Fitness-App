import 'package:fitness/features/home/api/models/explore_models/muscle_group_model/muscle_group_model.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toEntity", () {
    test(
      "when call toEntity with null values it should return MusclesGroupEntity with null values",
      () {
        // Arrange
        const MuscleGroupModel muscleGroupModel = MuscleGroupModel(
          id: null,
          name: null,
        );

        // Act
        final MusclesGroupEntity actualResult = muscleGroupModel.toEntity();

        // Assert
        expect(actualResult.id, equals(muscleGroupModel.id));
        expect(actualResult.name, equals(muscleGroupModel.name));
      },
    );

    test(
      "when call toEntity with non-nullable values it should return MusclesGroupEntity with correct values",
      () {
        // Arrange
        const MuscleGroupModel muscleGroupModel = MuscleGroupModel(
          id: "67c79f3526895f87ce0aa96b",
          name: "Abdominals",
        );

        // Act
        final MusclesGroupEntity actualResult = muscleGroupModel.toEntity();

        // Assert
        expect(actualResult.id, equals(muscleGroupModel.id));
        expect(actualResult.name, equals(muscleGroupModel.name));
        expect(actualResult.id, equals("67c79f3526895f87ce0aa96b"));
        expect(actualResult.name, equals("Abdominals"));
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly with all fields", () {
      // Arrange
      const MuscleGroupModel muscleGroupModel = MuscleGroupModel(
        id: "67c79f3526895f87ce0aa96b",
        name: "Abdominals",
      );

      // Act
      final json = muscleGroupModel.toJson();
      final fromJson = MuscleGroupModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals(muscleGroupModel.id));
      expect(fromJson.name, equals(muscleGroupModel.name));
      expect(json['_id'], equals("67c79f3526895f87ce0aa96b"));
      expect(json['name'], equals("Abdominals"));
    });

    test("toJson and fromJson should handle null values correctly", () {
      // Arrange
      const MuscleGroupModel muscleGroupModel = MuscleGroupModel(
        id: null,
        name: null,
      );

      // Act
      final json = muscleGroupModel.toJson();
      final fromJson = MuscleGroupModel.fromJson(json);

      // Assert
      expect(fromJson.id, isNull);
      expect(fromJson.name, isNull);
    });

    test("fromJson should correctly map _id field from JSON", () {
      // Arrange
      final json = {
        '_id': '67c79f3526895f87ce0aa96b',
        'name': 'Chest',
      };

      // Act
      final fromJson = MuscleGroupModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals('67c79f3526895f87ce0aa96b'));
      expect(fromJson.name, equals('Chest'));
    });
  });

  group("test Equatable", () {
    test("two MuscleGroupModel instances with same values should be equal", () {
      // Arrange
      const model1 = MuscleGroupModel(
        id: "67c79f3526895f87ce0aa96b",
        name: "Abdominals",
      );
      const model2 = MuscleGroupModel(
        id: "67c79f3526895f87ce0aa96b",
        name: "Abdominals",
      );

      // Assert
      expect(model1, equals(model2));
    });

    test("two MuscleGroupModel instances with different values should not be equal", () {
      // Arrange
      const model1 = MuscleGroupModel(
        id: "67c79f3526895f87ce0aa96b",
        name: "Abdominals",
      );
      const model2 = MuscleGroupModel(
        id: "67c79f3526895f87ce0aa96c",
        name: "Chest",
      );

      // Assert
      expect(model1, isNot(equals(model2)));
    });
  });
}
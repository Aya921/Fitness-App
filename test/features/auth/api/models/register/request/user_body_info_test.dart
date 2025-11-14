import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserBodyInfo', () {
    const tHeight = 180;
    const tWeight = 75;
    const tAge = 25;
    const tGoal = 'lose_weight';
    const tActivityLevel = 'moderate';

    test('should create instance with all fields', () {
      // Arrange & Act
      final bodyInfo = UserBodyInfo(
        height: tHeight,
        weight: tWeight,
        age: tAge,
        goal: tGoal,
        activityLevel: tActivityLevel,
      );

      // Assert
      expect(bodyInfo.height, tHeight);
      expect(bodyInfo.weight, tWeight);
      expect(bodyInfo.age, tAge);
      expect(bodyInfo.goal, tGoal);
      expect(bodyInfo.activityLevel, tActivityLevel);
    });

    test('should create instance with null fields', () {
      // Arrange & Act
      final bodyInfo = UserBodyInfo();

      // Assert
      expect(bodyInfo.height, isNull);
      expect(bodyInfo.weight, isNull);
      expect(bodyInfo.age, isNull);
      expect(bodyInfo.goal, isNull);
      expect(bodyInfo.activityLevel, isNull);
    });

    test('should create instance with partial fields', () {
      // Arrange & Act
      final bodyInfo = UserBodyInfo(
        height: tHeight,
        weight: tWeight,
        age: tAge,
      );

      // Assert
      expect(bodyInfo.height, tHeight);
      expect(bodyInfo.weight, tWeight);
      expect(bodyInfo.age, tAge);
      expect(bodyInfo.goal, isNull);
      expect(bodyInfo.activityLevel, isNull);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final bodyInfo = UserBodyInfo(
        height: tHeight,
        weight: tWeight,
        age: tAge,
        goal: tGoal,
        activityLevel: tActivityLevel,
      );

      // Act
      final json = bodyInfo.toJson();

      // Assert
      expect(json['height'], tHeight);
      expect(json['weight'], tWeight);
      expect(json['age'], tAge);
      expect(json['goal'], tGoal);
      expect(json['activityLevel'], tActivityLevel);
    });

    test('should serialize to JSON with null values', () {
      // Arrange
      final bodyInfo = UserBodyInfo(
        height: tHeight,
        weight: tWeight,
      );

      // Act
      final json = bodyInfo.toJson();

      // Assert
      expect(json['height'], tHeight);
      expect(json['weight'], tWeight);
      expect(json.containsKey('age'), isTrue);
      expect(json.containsKey('goal'), isTrue);
      expect(json.containsKey('activityLevel'), isTrue);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'height': tHeight,
        'weight': tWeight,
        'age': tAge,
        'goal': tGoal,
        'activityLevel': tActivityLevel,
      };

      // Act
      final bodyInfo = UserBodyInfo.fromJson(json);

      // Assert
      expect(bodyInfo.height, tHeight);
      expect(bodyInfo.weight, tWeight);
      expect(bodyInfo.age, tAge);
      expect(bodyInfo.goal, tGoal);
      expect(bodyInfo.activityLevel, tActivityLevel);
    });

    test('should deserialize from JSON with null values', () {
      // Arrange
      final json = {
        'height': tHeight,
        'weight': null,
        'age': null,
        'goal': null,
        'activityLevel': null,
      };

      // Act
      final bodyInfo = UserBodyInfo.fromJson(json);

      // Assert
      expect(bodyInfo.height, tHeight);
      expect(bodyInfo.weight, isNull);
      expect(bodyInfo.age, isNull);
      expect(bodyInfo.goal, isNull);
      expect(bodyInfo.activityLevel, isNull);
    });

    test('should handle JSON serialization round-trip', () {
      // Arrange
      final original = UserBodyInfo(
        height: tHeight,
        weight: tWeight,
        age: tAge,
        goal: tGoal,
        activityLevel: tActivityLevel,
      );

      // Act
      final json = original.toJson();
      final deserialized = UserBodyInfo.fromJson(json);

      // Assert
      expect(deserialized.height, original.height);
      expect(deserialized.weight, original.weight);
      expect(deserialized.age, original.age);
      expect(deserialized.goal, original.goal);
      expect(deserialized.activityLevel, original.activityLevel);
    });

    test('should handle minimum valid values', () {
      // Arrange
      final bodyInfo = UserBodyInfo(
        height: 100,
        weight: 30,
        age: 18,
        goal: 'maintain',
        activityLevel: 'low',
      );

      // Act
      final json = bodyInfo.toJson();
      final deserialized = UserBodyInfo.fromJson(json);

      // Assert
      expect(deserialized.height, 100);
      expect(deserialized.weight, 30);
      expect(deserialized.age, 18);
      expect(deserialized.goal, 'maintain');
      expect(deserialized.activityLevel, 'low');
    });

    test('should handle maximum typical values', () {
      // Arrange
      final bodyInfo = UserBodyInfo(
        height: 220,
        weight: 150,
        age: 80,
        goal: 'gain_weight',
        activityLevel: 'very_high',
      );

      // Act
      final json = bodyInfo.toJson();
      final deserialized = UserBodyInfo.fromJson(json);

      // Assert
      expect(deserialized.height, 220);
      expect(deserialized.weight, 150);
      expect(deserialized.age, 80);
      expect(deserialized.goal, 'gain_weight');
      expect(deserialized.activityLevel, 'very_high');
    });

    test('should handle different goal values', () {
      // Arrange
      const goals = ['lose_weight', 'gain_weight', 'maintain', 'build_muscle'];

      for (final goal in goals) {
        // Act
        final bodyInfo = UserBodyInfo(
          height: tHeight,
          weight: tWeight,
          age: tAge,
          goal: goal,
          activityLevel: tActivityLevel,
        );
        final json = bodyInfo.toJson();
        final deserialized = UserBodyInfo.fromJson(json);

        // Assert
        expect(deserialized.goal, goal);
      }
    });

    test('should handle different activity level values', () {
      // Arrange
      const activityLevels = ['sedentary', 'low', 'moderate', 'high', 'very_high'];

      for (final level in activityLevels) {
        // Act
        final bodyInfo = UserBodyInfo(
          height: tHeight,
          weight: tWeight,
          age: tAge,
          goal: tGoal,
          activityLevel: level,
        );
        final json = bodyInfo.toJson();
        final deserialized = UserBodyInfo.fromJson(json);

        // Assert
        expect(deserialized.activityLevel, level);
      }
    });

    test('should handle only physical measurements without goals', () {
      // Arrange
      final bodyInfo = UserBodyInfo(
        height: tHeight,
        weight: tWeight,
        age: tAge,
      );

      // Act
      final json = bodyInfo.toJson();

      // Assert
      expect(json['height'], tHeight);
      expect(json['weight'], tWeight);
      expect(json['age'], tAge);
      expect(json['goal'], isNull);
      expect(json['activityLevel'], isNull);
    });

    test('should handle only goals without physical measurements', () {
      // Arrange
      final bodyInfo = UserBodyInfo(
        goal: tGoal,
        activityLevel: tActivityLevel,
      );

      // Act
      final json = bodyInfo.toJson();

      // Assert
      expect(json['goal'], tGoal);
      expect(json['activityLevel'], tActivityLevel);
      expect(json['height'], isNull);
      expect(json['weight'], isNull);
      expect(json['age'], isNull);
    });

    test('should handle zero values', () {
      // Arrange
      final bodyInfo = UserBodyInfo(
        height: 0,
        weight: 0,
        age: 0,
      );

      // Act
      final json = bodyInfo.toJson();
      final deserialized = UserBodyInfo.fromJson(json);

      // Assert
      expect(deserialized.height, 0);
      expect(deserialized.weight, 0);
      expect(deserialized.age, 0);
    });

    test('should handle empty strings for goal and activity level', () {
      // Arrange
      final bodyInfo = UserBodyInfo(
        height: tHeight,
        weight: tWeight,
        age: tAge,
        goal: '',
        activityLevel: '',
      );

      // Act
      final json = bodyInfo.toJson();
      final deserialized = UserBodyInfo.fromJson(json);

      // Assert
      expect(deserialized.goal, '');
      expect(deserialized.activityLevel, '');
    });

    test('should handle partial JSON with missing fields', () {
      // Arrange
      final json = {
        'height': tHeight,
      };

      // Act
      final bodyInfo = UserBodyInfo.fromJson(json);

      // Assert
      expect(bodyInfo.height, tHeight);
      expect(bodyInfo.weight, isNull);
      expect(bodyInfo.age, isNull);
      expect(bodyInfo.goal, isNull);
      expect(bodyInfo.activityLevel, isNull);
    });
  });
}
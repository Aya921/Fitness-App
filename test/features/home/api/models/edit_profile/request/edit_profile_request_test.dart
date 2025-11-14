import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EditProfileRequest', () {
    test('should create instance with all fields', () {
      // Arrange & Act
      final request = EditProfileRequest(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        weight: 75.5,
        height: 180,
        activityLevel: 'moderate',
        goal: 'lose_weight',
      );

      // Assert
      expect(request.firstName, 'John');
      expect(request.lastName, 'Doe');
      expect(request.email, 'john.doe@example.com');
      expect(request.weight, 75.5);
      expect(request.height, 180);
      expect(request.activityLevel, 'moderate');
      expect(request.goal, 'lose_weight');
    });

    test('should create instance with null fields', () {
      // Arrange & Act
      final request = EditProfileRequest();

      // Assert
      expect(request.firstName, isNull);
      expect(request.lastName, isNull);
      expect(request.email, isNull);
      expect(request.weight, isNull);
      expect(request.height, isNull);
      expect(request.activityLevel, isNull);
      expect(request.goal, isNull);
    });

    test('should create instance with partial fields', () {
      // Arrange & Act
      final request = EditProfileRequest(
        firstName: 'Jane',
        email: 'jane@example.com',
        weight: 65,
      );

      // Assert
      expect(request.firstName, 'Jane');
      expect(request.email, 'jane@example.com');
      expect(request.weight, 65);
      expect(request.lastName, isNull);
      expect(request.height, isNull);
      expect(request.activityLevel, isNull);
      expect(request.goal, isNull);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final request = EditProfileRequest(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        weight: 75.5,
        height: 180,
        activityLevel: 'moderate',
        goal: 'lose_weight',
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json['firstName'], 'John');
      expect(json['lastName'], 'Doe');
      expect(json['email'], 'john.doe@example.com');
      expect(json['weight'], 75.5);
      expect(json['height'], 180);
      expect(json['activityLevel'], 'moderate');
      expect(json['goal'], 'lose_weight');
    });

    test('should serialize to JSON with null values', () {
      // Arrange
      final request = EditProfileRequest(
        firstName: 'John',
        weight: 75,
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json['firstName'], 'John');
      expect(json['weight'], 75);
      expect(json.containsKey('lastName'), isTrue);
      expect(json.containsKey('email'), isTrue);
      expect(json.containsKey('height'), isTrue);
      expect(json.containsKey('activityLevel'), isTrue);
      expect(json.containsKey('goal'), isTrue);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'john.doe@example.com',
        'weight': 75.5,
        'height': 180,
        'activityLevel': 'moderate',
        'goal': 'lose_weight',
      };

      // Act
      final request = EditProfileRequest.fromJson(json);

      // Assert
      expect(request.firstName, 'John');
      expect(request.lastName, 'Doe');
      expect(request.email, 'john.doe@example.com');
      expect(request.weight, 75.5);
      expect(request.height, 180);
      expect(request.activityLevel, 'moderate');
      expect(request.goal, 'lose_weight');
    });

    test('should deserialize from JSON with null values', () {
      // Arrange
      final json = {
        'firstName': 'John',
        'lastName': null,
        'email': null,
        'weight': 75,
        'height': null,
        'activityLevel': null,
        'goal': null,
      };

      // Act
      final request = EditProfileRequest.fromJson(json);

      // Assert
      expect(request.firstName, 'John');
      expect(request.weight, 75);
      expect(request.lastName, isNull);
      expect(request.email, isNull);
      expect(request.height, isNull);
      expect(request.activityLevel, isNull);
      expect(request.goal, isNull);
    });

    test('should handle JSON serialization round-trip', () {
      // Arrange
      final original = EditProfileRequest(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        weight: 75.5,
        height: 180,
        activityLevel: 'moderate',
        goal: 'lose_weight',
      );

      // Act
      final json = original.toJson();
      final deserialized = EditProfileRequest.fromJson(json);

      // Assert
      expect(deserialized.firstName, original.firstName);
      expect(deserialized.lastName, original.lastName);
      expect(deserialized.email, original.email);
      expect(deserialized.weight, original.weight);
      expect(deserialized.height, original.height);
      expect(deserialized.activityLevel, original.activityLevel);
      expect(deserialized.goal, original.goal);
    });
  });
}
import 'package:fitness/features/auth/api/models/register/request/register_request.dart';
import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterRequest', () {
    final tUserInfo = UserInfo(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      password: 'Password123!',
      rePassword: 'Password123!',
      gender: 'male',
    );

    final tUserBodyInfo = UserBodyInfo(
      height: 180,
      weight: 75,
      age: 25,
      goal: 'lose_weight',
      activityLevel: 'moderate',
    );

    test('should create instance with all fields', () {
      // Arrange & Act
      final request = RegisterRequest(
        userInfo: tUserInfo,
        userBodyInfo: tUserBodyInfo,
      );

      // Assert
      expect(request.userInfo, tUserInfo);
      expect(request.userBodyInfo, tUserBodyInfo);
    });

    test('should create instance with null fields', () {
      // Arrange & Act
      final request = RegisterRequest();

      // Assert
      expect(request.userInfo, isNull);
      expect(request.userBodyInfo, isNull);
    });

    test('should create instance with only userInfo', () {
      // Arrange & Act
      final request = RegisterRequest(userInfo: tUserInfo);

      // Assert
      expect(request.userInfo, tUserInfo);
      expect(request.userBodyInfo, isNull);
    });

    test('should create instance with only userBodyInfo', () {
      // Arrange & Act
      final request = RegisterRequest(userBodyInfo: tUserBodyInfo);

      // Assert
      expect(request.userInfo, isNull);
      expect(request.userBodyInfo, tUserBodyInfo);
    });

    test('should serialize only userInfo when userBodyInfo is null', () {
      // Arrange
      final request = RegisterRequest(userInfo: tUserInfo);

      // Act
      final json = request.toJson();

      // Assert - UserInfo fields exist
      expect(json['firstName'], 'John');
      expect(json['lastName'], 'Doe');
      expect(json['email'], 'john.doe@example.com');
      expect(json['password'], 'Password123!');
      expect(json['rePassword'], 'Password123!');
      expect(json['gender'], 'male');

      // Assert - UserBodyInfo fields don't exist
      expect(json.containsKey('height'), isFalse);
      expect(json.containsKey('weight'), isFalse);
      expect(json.containsKey('age'), isFalse);
      expect(json.containsKey('goal'), isFalse);
      expect(json.containsKey('activityLevel'), isFalse);
    });

    test('should return empty map when both fields are null', () {
      // Arrange
      final request = RegisterRequest();

      // Act
      final json = request.toJson();

      // Assert
      expect(json, isEmpty);
    });

    test('should flatten correctly with all required fields for API', () {
      // Arrange
      final request = RegisterRequest(
        userInfo: tUserInfo,
        userBodyInfo: tUserBodyInfo,
      );

      // Act
      final json = request.toJson();

      // Assert - Verify all keys exist at root level (not nested)
      expect(json.keys.length, 11);
      expect(json.containsKey('userInfo'), isFalse);
      expect(json.containsKey('userBodyInfo'), isFalse);

      // All fields should be at root level
      expect(json.keys.toList(), containsAll([
        'firstName', 'lastName', 'email', 'password', 'rePassword', 'gender',
        'height', 'weight', 'age', 'goal', 'activityLevel'
      ]));
    });

  });
}
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserInfo', () {
    const tFirstName = 'John';
    const tLastName = 'Doe';
    const tEmail = 'john.doe@example.com';
    const tPassword = 'Password123!';
    const tRePassword = 'Password123!';
    const tGender = 'male';

    test('should create instance with all fields', () {
      // Arrange & Act
      final userInfo = UserInfo(
        firstName: tFirstName,
        lastName: tLastName,
        email: tEmail,
        password: tPassword,
        rePassword: tRePassword,
        gender: tGender,
      );

      // Assert
      expect(userInfo.firstName, tFirstName);
      expect(userInfo.lastName, tLastName);
      expect(userInfo.email, tEmail);
      expect(userInfo.password, tPassword);
      expect(userInfo.rePassword, tRePassword);
      expect(userInfo.gender, tGender);
    });

    test('should create instance with null fields', () {
      // Arrange & Act
      final userInfo = UserInfo();

      // Assert
      expect(userInfo.firstName, isNull);
      expect(userInfo.lastName, isNull);
      expect(userInfo.email, isNull);
      expect(userInfo.password, isNull);
      expect(userInfo.rePassword, isNull);
      expect(userInfo.gender, isNull);
    });

    test('should create instance with partial fields', () {
      // Arrange & Act
      final userInfo = UserInfo(
        firstName: tFirstName,
        lastName: tLastName,
        email: tEmail,
      );

      // Assert
      expect(userInfo.firstName, tFirstName);
      expect(userInfo.lastName, tLastName);
      expect(userInfo.email, tEmail);
      expect(userInfo.password, isNull);
      expect(userInfo.rePassword, isNull);
      expect(userInfo.gender, isNull);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final userInfo = UserInfo(
        firstName: tFirstName,
        lastName: tLastName,
        email: tEmail,
        password: tPassword,
        rePassword: tRePassword,
        gender: tGender,
      );

      // Act
      final json = userInfo.toJson();

      // Assert
      expect(json['firstName'], tFirstName);
      expect(json['lastName'], tLastName);
      expect(json['email'], tEmail);
      expect(json['password'], tPassword);
      expect(json['rePassword'], tRePassword);
      expect(json['gender'], tGender);
    });

    test('should serialize to JSON with null values', () {
      // Arrange
      final userInfo = UserInfo(
        firstName: tFirstName,
        email: tEmail,
      );

      // Act
      final json = userInfo.toJson();

      // Assert
      expect(json['firstName'], tFirstName);
      expect(json['email'], tEmail);
      expect(json.containsKey('lastName'), isTrue);
      expect(json.containsKey('password'), isTrue);
      expect(json.containsKey('rePassword'), isTrue);
      expect(json.containsKey('gender'), isTrue);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'firstName': tFirstName,
        'lastName': tLastName,
        'email': tEmail,
        'password': tPassword,
        'rePassword': tRePassword,
        'gender': tGender,
      };

      // Act
      final userInfo = UserInfo.fromJson(json);

      // Assert
      expect(userInfo.firstName, tFirstName);
      expect(userInfo.lastName, tLastName);
      expect(userInfo.email, tEmail);
      expect(userInfo.password, tPassword);
      expect(userInfo.rePassword, tRePassword);
      expect(userInfo.gender, tGender);
    });

    test('should deserialize from JSON with null values', () {
      // Arrange
      final json = {
        'firstName': tFirstName,
        'lastName': null,
        'email': null,
        'password': null,
        'rePassword': null,
        'gender': null,
      };

      // Act
      final userInfo = UserInfo.fromJson(json);

      // Assert
      expect(userInfo.firstName, tFirstName);
      expect(userInfo.lastName, isNull);
      expect(userInfo.email, isNull);
      expect(userInfo.password, isNull);
      expect(userInfo.rePassword, isNull);
      expect(userInfo.gender, isNull);
    });

    test('should handle JSON serialization round-trip', () {
      // Arrange
      final original = UserInfo(
        firstName: tFirstName,
        lastName: tLastName,
        email: tEmail,
        password: tPassword,
        rePassword: tRePassword,
        gender: tGender,
      );

      // Act
      final json = original.toJson();
      final deserialized = UserInfo.fromJson(json);

      // Assert
      expect(deserialized.firstName, original.firstName);
      expect(deserialized.lastName, original.lastName);
      expect(deserialized.email, original.email);
      expect(deserialized.password, original.password);
      expect(deserialized.rePassword, original.rePassword);
      expect(deserialized.gender, original.gender);
    });

    test('should handle partial JSON with missing fields', () {
      // Arrange
      final json = {
        'firstName': tFirstName,
        'email': tEmail,
      };

      // Act
      final userInfo = UserInfo.fromJson(json);

      // Assert
      expect(userInfo.firstName, tFirstName);
      expect(userInfo.email, tEmail);
      expect(userInfo.lastName, isNull);
      expect(userInfo.password, isNull);
      expect(userInfo.rePassword, isNull);
      expect(userInfo.gender, isNull);
    });

    test('should handle typical registration scenario', () {
      // Arrange
      final userInfo = UserInfo(
        firstName: 'Sarah',
        lastName: 'Johnson',
        email: 'sarah.johnson@example.com',
        password: 'SecurePass123!',
        rePassword: 'SecurePass123!',
        gender: 'female',
      );

      // Act
      final json = userInfo.toJson();
      final deserialized = UserInfo.fromJson(json);

      // Assert
      expect(deserialized.firstName, 'Sarah');
      expect(deserialized.lastName, 'Johnson');
      expect(deserialized.email, 'sarah.johnson@example.com');
      expect(deserialized.password, 'SecurePass123!');
      expect(deserialized.rePassword, 'SecurePass123!');
      expect(deserialized.gender, 'female');
    });

  });
}
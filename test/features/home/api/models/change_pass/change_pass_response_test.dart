import 'package:fitness/features/home/api/models/change_pass/change_pass_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChangePassResponse', () {
    const tMessage = 'Password changed successfully';
    const tToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9';

    test('should create instance with all fields', () {
      // Arrange & Act
      final response = ChangePassResponse(
        message: tMessage,
        token: tToken,
      );

      // Assert
      expect(response.message, tMessage);
      expect(response.token, tToken);
    });

    test('should create instance with null fields', () {
      // Arrange & Act
      final response = ChangePassResponse();

      // Assert
      expect(response.message, isNull);
      expect(response.token, isNull);
    });

    test('should create instance with partial fields - only message', () {
      // Arrange & Act
      final response = ChangePassResponse(message: tMessage);

      // Assert
      expect(response.message, tMessage);
      expect(response.token, isNull);
    });

    test('should create instance with partial fields - only token', () {
      // Arrange & Act
      final response = ChangePassResponse(token: tToken);

      // Assert
      expect(response.message, isNull);
      expect(response.token, tToken);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final response = ChangePassResponse(
        message: tMessage,
        token: tToken,
      );

      // Act
      final json = response.toJson();

      // Assert
      expect(json['message'], tMessage);
      expect(json['token'], tToken);
    });

    test('should serialize to JSON with null values', () {
      // Arrange
      final response = ChangePassResponse(message: tMessage);

      // Act
      final json = response.toJson();

      // Assert
      expect(json['message'], tMessage);
      expect(json.containsKey('token'), isTrue);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {
        'message': tMessage,
        'token': tToken,
      };

      // Act
      final response = ChangePassResponse.fromJson(json);

      // Assert
      expect(response.message, tMessage);
      expect(response.token, tToken);
    });

    test('should deserialize from JSON with null values', () {
      // Arrange
      final json = {
        'message': tMessage,
        'token': null,
      };

      // Act
      final response = ChangePassResponse.fromJson(json);

      // Assert
      expect(response.message, tMessage);
      expect(response.token, isNull);
    });

    test('should deserialize from JSON with missing keys', () {
      // Arrange
      final json = {
        'message': tMessage,
      };

      // Act
      final response = ChangePassResponse.fromJson(json);

      // Assert
      expect(response.message, tMessage);
      expect(response.token, isNull);
    });

    test('should handle JSON serialization round-trip', () {
      // Arrange
      final original = ChangePassResponse(
        message: tMessage,
        token: tToken,
      );

      // Act
      final json = original.toJson();
      final deserialized = ChangePassResponse.fromJson(json);

      // Assert
      expect(deserialized.message, original.message);
      expect(deserialized.token, original.token);
    });

    test('should handle empty strings', () {
      // Arrange
      final response = ChangePassResponse(
        message: '',
        token: '',
      );

      // Act
      final json = response.toJson();
      final deserialized = ChangePassResponse.fromJson(json);

      // Assert
      expect(deserialized.message, '');
      expect(deserialized.token, '');
    });

    test('should handle special characters in message', () {
      // Arrange
      const specialMessage = 'Password changed! @#\$%^&*()';
      final response = ChangePassResponse(
        message: specialMessage,
        token: tToken,
      );

      // Act
      final json = response.toJson();
      final deserialized = ChangePassResponse.fromJson(json);

      // Assert
      expect(deserialized.message, specialMessage);
      expect(deserialized.token, tToken);
    });
  });
}
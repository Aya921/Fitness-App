import 'package:fitness/features/home/api/models/change_pass/change_pass_request_model.dart';
import 'package:fitness/features/home/domain/entities/chage_pass/change_pass_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChangePassRequestModel', () {
    const tPassword = 'oldPassword123';
    const tNewPassword = 'newPassword456';

    test('should create instance with all fields', () {
      // Arrange & Act
      final model = ChangePassRequestModel(
        password: tPassword,
        newPassword: tNewPassword,
      );

      // Assert
      expect(model.password, tPassword);
      expect(model.newPassword, tNewPassword);
    });

    test('should create instance with null fields', () {
      // Arrange & Act
      final model = ChangePassRequestModel();

      // Assert
      expect(model.password, isNull);
      expect(model.newPassword, isNull);
    });

    test('should create instance with partial fields - only password', () {
      // Arrange & Act
      final model = ChangePassRequestModel(password: tPassword);

      // Assert
      expect(model.password, tPassword);
      expect(model.newPassword, isNull);
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final model = ChangePassRequestModel(
        password: tPassword,
        newPassword: tNewPassword,
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['password'], tPassword);
      expect(json['newPassword'], tNewPassword);
    });

    test('should serialize to JSON with null values', () {
      // Arrange
      final model = ChangePassRequestModel(password: tPassword);

      // Act
      final json = model.toJson();

      // Assert
      expect(json['password'], tPassword);
      expect(json.containsKey('newPassword'), isTrue);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final json = {'password': tPassword, 'newPassword': tNewPassword};

      // Act
      final model = ChangePassRequestModel.fromJson(json);

      // Assert
      expect(model.password, tPassword);
      expect(model.newPassword, tNewPassword);
    });

    test('should deserialize from JSON with null values', () {
      // Arrange
      final json = {'password': tPassword, 'newPassword': null};

      // Act
      final model = ChangePassRequestModel.fromJson(json);

      // Assert
      expect(model.password, tPassword);
      expect(model.newPassword, isNull);
    });

    test('should handle JSON serialization round-trip', () {
      // Arrange
      final original = ChangePassRequestModel(
        password: tPassword,
        newPassword: tNewPassword,
      );

      // Act
      final json = original.toJson();
      final deserialized = ChangePassRequestModel.fromJson(json);

      // Assert
      expect(deserialized.password, original.password);
      expect(deserialized.newPassword, original.newPassword);
    });

    test('should convert entity to model with all fields', () {
      // Arrange
      final entity = ChangePassRequest(
        password: tPassword,
        newPassword: tNewPassword,
      );

      // Act
      final model = ChangePassRequestModel.toModel(entity);

      // Assert
      expect(model.password, tPassword);
      expect(model.newPassword, tNewPassword);
    });

    test('should convert entity to model with null fields', () {
      // Arrange
      final entity = ChangePassRequest();

      // Act
      final model = ChangePassRequestModel.toModel(entity);

      // Assert
      expect(model.password, isNull);
      expect(model.newPassword, isNull);
    });

    test('should convert entity to model with partial fields', () {
      // Arrange
      final entity = ChangePassRequest(password: tPassword);

      // Act
      final model = ChangePassRequestModel.toModel(entity);

      // Assert
      expect(model.password, tPassword);
      expect(model.newPassword, isNull);
    });

    test('should handle empty strings', () {
      // Arrange
      final model = ChangePassRequestModel(password: '', newPassword: '');

      // Act
      final json = model.toJson();
      final deserialized = ChangePassRequestModel.fromJson(json);

      // Assert
      expect(deserialized.password, '');
      expect(deserialized.newPassword, '');
    });
  });
}

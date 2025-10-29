import 'package:fitness/features/auth/api/models/forget_pass_models/reset_pass_request_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';


void main() {
  group('ResetPassRequestModel.toModel()', () {
    test('should correctly convert entity with valid data', () {
      // Arrange
      final entity = ResetPassRequest(
        email: 'aya.saber@example.com',
        newPass: 'NewStrongPass123',
      );

      // Act
      final model = ResetPassRequestModel.toModel(entity);

      // Assert
      expect(model.email, equals('aya.saber@example.com'));
      expect(model.newPassword, equals('NewStrongPass123'));
    });

    test(' should handle empty email and newPassword strings', () {
      // Arrange
      final entity = ResetPassRequest(
        email: '',
        newPass: '',
      );

      // Act
      final model = ResetPassRequestModel.toModel(entity);

      // Assert
      expect(model.email, isEmpty);
      expect(model.newPassword, isEmpty);
    });

   
  });
}

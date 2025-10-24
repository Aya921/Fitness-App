import 'package:fitness/features/auth/api/models/forget_pass_models/forget_pass_request_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';


void main() {
  group('ForgetPassRequestModel.toModel()', () {
    test('should convert entity with valid email correctly', () {
      // Arrange
      final entity = ForgetPassRequest(email: 'aya.saber@example.com');

      // Act
      final model = ForgetPassRequestModel.toModel(entity);

      // Assert
      expect(model.email, equals('aya.saber@example.com'));
    });

    test('should handle empty email string', () {
      // Arrange
      final entity = ForgetPassRequest(email: '');

      // Act
      final model = ForgetPassRequestModel.toModel(entity);

      // Assert
      expect(model.email, isEmpty);
    });

   
  });
}

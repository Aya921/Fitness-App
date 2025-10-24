import 'package:fitness/features/auth/api/models/forget_pass_models/forget_pass_response_model.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('ForgetPassResponseModel.toEntity()', () {
    test('should convert model with valid info correctly', () {
      // Arrange
      final model = ForgetPassResponseModel(
        message: 'Password reset link sent',
        info: 'Check your email for reset instructions',
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.info, equals('Check your email for reset instructions'));
    });

    test('should handle empty info string', () {
      // Arrange
      final model = ForgetPassResponseModel(
        message: 'Empty info test',
        info: '',
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.info, isEmpty);
    });

   
  });
}

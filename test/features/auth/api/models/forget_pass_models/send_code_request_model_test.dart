import 'package:fitness/features/auth/api/models/forget_pass_models/send_code_request_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';


void main() {
  group('SendCodeRequestModel.toModel()', () {
    test('should correctly convert entity with valid resetCode', () {
      // Arrange
      final entity = SendCodeRequest(otpCode: '123456');

      // Act
      final model = SendCodeRequestModel.toModel(entity);

      // Assert
      expect(model.resetCode, equals('123456'));
    });

    test('should handle empty resetCode string', () {
      // Arrange
      final entity = SendCodeRequest(otpCode: '');

      // Act
      final model = SendCodeRequestModel.toModel(entity);

      // Assert
      expect(model.resetCode, isEmpty);
    });

   
  });
}

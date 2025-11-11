import 'package:fitness/features/home/api/models/logout/logout_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogoutResponse', () {
    test('should create LogoutResponse with required message', () {
      // arrange
      const message = 'Logged out successfully';

      // act
      final response = LogoutResponse(message: message);

      // assert
      expect(response.message, message);
    });

    test('should create LogoutResponse from JSON', () {
      // arrange
      final json = {'message': 'Logout successful'};

      // act
      final response = LogoutResponse.fromJson(json);

      // assert
      expect(response, isA<LogoutResponse>());
      expect(response.message, 'Logout successful');
    });

    test('should handle empty string message from JSON', () {
      // arrange
      final json = {'message': ''};

      // act
      final response = LogoutResponse.fromJson(json);

      // assert
      expect(response.message, '');
    });

    test('should throw error when message key is missing from JSON', () {
      // arrange
      final json = <String, dynamic>{};

      // act & assert
      expect(() => LogoutResponse.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('should throw error when message value is null in JSON', () {
      // arrange
      final json = {'message': null};


      // act & assert
      expect(() => LogoutResponse.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}

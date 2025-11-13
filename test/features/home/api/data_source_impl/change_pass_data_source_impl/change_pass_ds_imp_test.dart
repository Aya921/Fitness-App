import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/storage/secure_storage_service.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/api/data_source_impl/change_pass_data_source_impl/change_pass_ds_imp.dart';
import 'package:fitness/features/home/api/models/change_pass/change_pass_response.dart';
import 'package:fitness/features/home/domain/entities/chage_pass/change_pass_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_pass_ds_imp_test.mocks.dart';

@GenerateMocks([ApiServices, SecureStorageService])
void main() {
  late MockApiServices mockApiServices;
  late MockSecureStorageService mockSecureStorage;
  late ChangePassDsImp changePassDsImp;

  setUp(() {
    mockApiServices = MockApiServices();
    mockSecureStorage = MockSecureStorageService();
    changePassDsImp = ChangePassDsImp(mockApiServices, mockSecureStorage);
  });

  group('changePassword', () {
    final tChangePassRequest = ChangePassRequest(
      password: 'oldPassword123',
      newPassword: 'newPassword456',
    );

    final tChangePassResponse = ChangePassResponse(
      message: 'Password changed successfully',
      token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
    );

    test('should return SuccessResult when password change succeeds', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenAnswer((_) async => tChangePassResponse);

      when(mockSecureStorage.saveToken(any)).thenAnswer((_) async => {});

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<SuccessResult<void>>());
      expect(result, isNotNull);
      verify(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).called(1);
      verify(
        mockSecureStorage.saveToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'),
      ).called(1);
    });

    test(
      'should save token to secure storage when token is provided',
      () async {
        // Arrange
        const expectedToken = 'newTokenAfterPasswordChange';
        final response = ChangePassResponse(
          message: 'Password changed',
          token: expectedToken,
        );

        when(
          mockApiServices.changePassword(
            changePasswordRequest: anyNamed('changePasswordRequest'),
          ),
        ).thenAnswer((_) async => response);

        when(mockSecureStorage.saveToken(any)).thenAnswer((_) async => {});

        // Act
        await changePassDsImp.changePassword(
          changePassRequest: tChangePassRequest,
        );

        // Assert
        verify(mockSecureStorage.saveToken(expectedToken)).called(1);
        verifyNoMoreInteractions(mockSecureStorage);
      },
    );

    test('should not save token when token is null', () async {
      // Arrange
      final responseWithoutToken = ChangePassResponse(
        message: 'Password changed',
        token: null,
      );

      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenAnswer((_) async => responseWithoutToken);

      // Act
      await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      verifyNever(mockSecureStorage.saveToken(any));
    });

    test('should return FailedResult when API call fails', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(Exception('Network error'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      expect(result, isNotNull);
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, isNotEmpty);
      expect(failure, Exception('Network error').toString());
      verify(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).called(1);
      verifyNever(mockSecureStorage.saveToken(any));
    });

    test('should return FailedResult when token save fails', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenAnswer((_) async => tChangePassResponse);

      when(
        mockSecureStorage.saveToken(any),
      ).thenThrow(Exception('Storage error'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, contains('Storage error'));
      verify(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).called(1);
      verify(mockSecureStorage.saveToken(any)).called(1);
    });

    test('should handle wrong current password error', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(Exception('Current password is incorrect'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, contains('Current password is incorrect'));
    });

    test('should handle weak password error', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(Exception('New password is too weak'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, contains('New password is too weak'));
    });

    test('should handle unauthorized error', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(Exception('401 Unauthorized'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, contains('401 Unauthorized'));
    });

    test('should handle server error', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(Exception('500 Internal Server Error'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, contains('500 Internal Server Error'));
    });

    test('should handle timeout error', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(Exception('Request timeout'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, contains('Request timeout'));
    });

    test('should handle empty passwords in request', () async {
      // Arrange
      final emptyRequest = ChangePassRequest(password: '', newPassword: '');

      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(Exception('Password cannot be empty'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: emptyRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, contains('Password cannot be empty'));
    });

    test('should handle same old and new password error', () async {
      // Arrange
      final samePasswordRequest = ChangePassRequest(
        password: 'password123',
        newPassword: 'password123',
      );

      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(
        Exception('New password must be different from current password'),
      );

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: samePasswordRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(
        failure,
        contains('New password must be different from current password'),
      );
    });

    test('should handle response with empty token string', () async {
      // Arrange
      final responseWithEmptyToken = ChangePassResponse(
        message: 'Password changed',
        token: '',
      );

      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenAnswer((_) async => responseWithEmptyToken);

      when(mockSecureStorage.saveToken(any)).thenAnswer((_) async => {});

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<SuccessResult<void>>());
      verify(mockSecureStorage.saveToken('')).called(1);
    });

    test(
      'should convert ChangePassRequest to ChangePassRequestModel correctly',
      () async {
        // Arrange
        final request = ChangePassRequest(
          password: 'oldPass',
          newPassword: 'newPass',
        );

        when(
          mockApiServices.changePassword(
            changePasswordRequest: anyNamed('changePasswordRequest'),
          ),
        ).thenAnswer((_) async => tChangePassResponse);

        when(mockSecureStorage.saveToken(any)).thenAnswer((_) async => {});

        // Act
        await changePassDsImp.changePassword(changePassRequest: request);

        // Assert
        verify(
          mockApiServices.changePassword(
            changePasswordRequest: anyNamed('changePasswordRequest'),
          ),
        ).called(1);
      },
    );

    test('should handle network connection error', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenThrow(Exception('No internet connection'));

      // Act
      final result = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, contains('No internet connection'));
    });

    test('should handle multiple consecutive password changes', () async {
      // Arrange
      when(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).thenAnswer((_) async => tChangePassResponse);

      when(mockSecureStorage.saveToken(any)).thenAnswer((_) async => {});

      // Act
      final firstResult = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );
      final secondResult = await changePassDsImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(firstResult, isA<SuccessResult<void>>());
      expect(secondResult, isA<SuccessResult<void>>());
      verify(
        mockApiServices.changePassword(
          changePasswordRequest: anyNamed('changePasswordRequest'),
        ),
      ).called(2);
      verify(mockSecureStorage.saveToken(any)).called(2);
    });
  });
}

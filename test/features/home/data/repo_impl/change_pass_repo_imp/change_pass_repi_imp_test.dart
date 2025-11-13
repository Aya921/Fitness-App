import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/change_pass_ds/change_pass_ds.dart';
import 'package:fitness/features/home/data/repo_impl/change_pass_repo_imp/change_pass_repi_imp.dart';
import 'package:fitness/features/home/domain/entities/chage_pass/change_pass_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_pass_repi_imp_test.mocks.dart';

@GenerateMocks([ChangePassDs])
void main() {
  late MockChangePassDs mockChangePassDs;
  late ChangePassRepiImp changePassRepoImp;

  setUp(() {
    provideDummy<Result<void>>( SuccessResult<void>(null));
    mockChangePassDs = MockChangePassDs();
    changePassRepoImp = ChangePassRepiImp(mockChangePassDs);
  });

  group('changePassword', () {
    final tChangePassRequest = ChangePassRequest(
      password: 'oldPassword123',
      newPassword: 'newPassword456',
    );

    test('should return SuccessResult when data source succeeds', () async {
      // Arrange
      when(mockChangePassDs.changePassword(
        changePassRequest: tChangePassRequest,
      )).thenAnswer((_) async =>  SuccessResult<void>(null));

      // Act
      final result = await changePassRepoImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<SuccessResult<void>>());
      expect(result, isNotNull);
      verify(mockChangePassDs.changePassword(
        changePassRequest: tChangePassRequest,
      )).called(1);
      verifyNoMoreInteractions(mockChangePassDs);
    });

    test('should return FailedResult when data source fails', () async {
      // Arrange
      const errorMessage = 'Network error';
      when(mockChangePassDs.changePassword(
        changePassRequest: tChangePassRequest,
      )).thenAnswer((_) async =>  FailedResult<void>(errorMessage));

      // Act
      final result = await changePassRepoImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      expect(result, isNotNull);
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, errorMessage);
      verify(mockChangePassDs.changePassword(
        changePassRequest: tChangePassRequest,
      )).called(1);
      verifyNoMoreInteractions(mockChangePassDs);
    });

    test('should pass correct request to data source', () async {
      // Arrange
      final specificRequest = ChangePassRequest(
        password: 'specificOldPassword',
        newPassword: 'specificNewPassword',
      );

      when(mockChangePassDs.changePassword(
        changePassRequest: specificRequest,
      )).thenAnswer((_) async =>  SuccessResult<void>(null));

      // Act
      await changePassRepoImp.changePassword(
        changePassRequest: specificRequest,
      );

      // Assert
      verify(mockChangePassDs.changePassword(
        changePassRequest: specificRequest,
      )).called(1);
    });

    test('should handle wrong current password error', () async {
      // Arrange
      const errorMessage = 'Current password is incorrect';
      when(mockChangePassDs.changePassword(
        changePassRequest: tChangePassRequest,
      )).thenAnswer((_) async =>  FailedResult<void>(errorMessage));

      // Act
      final result = await changePassRepoImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, errorMessage);
    });

    test('should handle timeout error', () async {
      // Arrange
      const errorMessage = 'Request timeout';
      when(mockChangePassDs.changePassword(
        changePassRequest: tChangePassRequest,
      )).thenAnswer((_) async =>  FailedResult<void>(errorMessage));

      // Act
      final result = await changePassRepoImp.changePassword(
        changePassRequest: tChangePassRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, errorMessage);
    });

    test('should handle request with empty passwords', () async {
      // Arrange
      final emptyRequest = ChangePassRequest(
        password: '',
        newPassword: '',
      );

      const errorMessage = 'Password cannot be empty';
      when(mockChangePassDs.changePassword(
        changePassRequest: emptyRequest,
      )).thenAnswer((_) async => FailedResult<void>(errorMessage));

      // Act
      final result = await changePassRepoImp.changePassword(
        changePassRequest: emptyRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, errorMessage);
    });

    test('should handle same old and new password', () async {
      // Arrange
      final samePasswordRequest = ChangePassRequest(
        password: 'password123',
        newPassword: 'password123',
      );

      const errorMessage = 'New password must be different from current password';
      when(mockChangePassDs.changePassword(
        changePassRequest: samePasswordRequest,
      )).thenAnswer((_) async => FailedResult<void>(errorMessage));

      // Act
      final result = await changePassRepoImp.changePassword(
        changePassRequest: samePasswordRequest,
      );

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, errorMessage);
    });
  });
}
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/chage_pass/change_pass_request.dart';
import 'package:fitness/features/home/domain/repo/change_pass_repo/change_pass_repo.dart';
import 'package:fitness/features/home/domain/usecase/change_pass_usecase/change_pass_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_pass_usecase_test.mocks.dart';

@GenerateMocks([ChangePassRepo])
void main() {
  late MockChangePassRepo mockChangePassRepo;
  late ChangePassUsecase usecase;

  setUp(() {
    provideDummy<Result<void>>(SuccessResult<void>(null));

    mockChangePassRepo = MockChangePassRepo();
    usecase = ChangePassUsecase(mockChangePassRepo);
  });

  group('ChangePassUsecase', () {
    final tChangePassRequest = ChangePassRequest(
      password: 'oldPassword123',
      newPassword: 'newPassword456',
    );

    test('should call repo.changePassword and return SuccessResult when successful', () async {
      // Arrange
      when(mockChangePassRepo.changePassword(
        changePassRequest: tChangePassRequest,
      )).thenAnswer((_) async => SuccessResult<void>(null));

      // Act
      final result = await usecase.changePass(req: tChangePassRequest);

      // Assert
      expect(result, isA<SuccessResult<void>>());
      verify(mockChangePassRepo.changePassword(
        changePassRequest: tChangePassRequest,
      )).called(1);
      verifyNoMoreInteractions(mockChangePassRepo);
    });

    test('should return FailedResult when repo returns failure', () async {
      // Arrange
      const errorMessage = 'Invalid old password';
      when(mockChangePassRepo.changePassword(
        changePassRequest: tChangePassRequest,
      )).thenAnswer((_) async => FailedResult<void>(errorMessage));

      // Act
      final result = await usecase.changePass(req: tChangePassRequest);

      // Assert
      expect(result, isA<FailedResult<void>>());
      final failure = (result as FailedResult<void>).errorMessage;
      expect(failure, errorMessage);
      verify(mockChangePassRepo.changePassword(
        changePassRequest: tChangePassRequest,
      )).called(1);
    });

  });
}

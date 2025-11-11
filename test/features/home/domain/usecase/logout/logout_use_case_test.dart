import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/repo/logout/logout_repo.dart';
import 'package:fitness/features/home/domain/usecase/logout/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([LogoutRepo])
void main() {
  late MockLogoutRepo mockLogoutRepo;
  late LogoutUseCase logoutUseCase;

  setUp(() {
    provideDummy<Result<void>>(FailedResult("Dummy"));
    mockLogoutRepo = MockLogoutRepo();
    logoutUseCase = LogoutUseCase(mockLogoutRepo);
  });

  group('LogoutUseCase', () {
    test(
      'should return SuccessResult when repository logout succeeds',
      () async {
        //  arrange
        final successResult = SuccessResult<void>(null);
        when(mockLogoutRepo.logout()).thenAnswer((_) async => successResult);


        // act
        final result = await logoutUseCase.call();

        // assert
        expect(result, isA<SuccessResult<void>>());
        verify(mockLogoutRepo.logout()).called(1);
      },
    );

    test('should return FailedResult when repository logout fails', () async {
      // arrange
      final failedResult = FailedResult<void>('Logout failed');
      when(mockLogoutRepo.logout()).thenAnswer((_) async => failedResult);

      // act
      final result = await logoutUseCase.call();

      // assert
      expect(result, isA<FailedResult<void>>());
      verify(mockLogoutRepo.logout()).called(1);
    });

    test('should call repository logout exactly once', () async {
      // arrange
      final successResult = SuccessResult<void>(null);
      when(mockLogoutRepo.logout()).thenAnswer((_) async => successResult);

      // act
      await logoutUseCase.call();

      // assert
      verify(mockLogoutRepo.logout()).called(1);
      verifyNoMoreInteractions(mockLogoutRepo);
    });

    test('should handle delayed response from repository', () async {
      // arrange
      final successResult = SuccessResult<void>(null);
      when(mockLogoutRepo.logout()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return successResult;
      });

      // act
      final result = await logoutUseCase.call();

      // assert
      expect(result, isA<SuccessResult<void>>());
      verify(mockLogoutRepo.logout()).called(1);
    });
  });
}

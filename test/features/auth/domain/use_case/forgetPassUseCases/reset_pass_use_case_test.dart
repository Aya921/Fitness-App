import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/data/repository_impl/auth_repo_impl.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:fitness/features/auth/domain/use_case/forgetPassUseCases/reset_pass_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_pass_use_case_test.mocks.dart';


@GenerateMocks([AuthRepoImpl])
void main() {
  late MockAuthRepoImpl mockAuthRepo;
  late ResetPassUseCase resetPassUseCase;
  late ResetPassRequest resetPassRequest;

  setUp(() {
    mockAuthRepo = MockAuthRepoImpl();
    resetPassUseCase = ResetPassUseCase(mockAuthRepo);
    resetPassRequest = ResetPassRequest(
      email: 'test@example.com',
      newPass: 'newPassword123',
    );
  });

  group('ResetPassUseCase', () {
    test('should return SuccessResult when repo call succeeds', () async {
      // arrange
      final mockResult = SuccessResult<void>(null);
      provideDummy<Result<void>>(mockResult);

      when(mockAuthRepo.resetPass(resetReq: resetPassRequest))
          .thenAnswer((_) async => mockResult);

      // act
      final result = await resetPassUseCase.resetPass(req: resetPassRequest);

      // assert
      expect(result, isA<SuccessResult<void>>());
      verify(mockAuthRepo.resetPass(resetReq: resetPassRequest)).called(1);
    });

    test('should return FailedResult when repo call fails', () async {
      // arrange
      final mockResult = FailedResult<void>('error');
      provideDummy<Result<void>>(mockResult);

      when(mockAuthRepo.resetPass(resetReq: resetPassRequest))
          .thenAnswer((_) async => mockResult);

      // act
      final result = await resetPassUseCase.resetPass(req: resetPassRequest);

      // assert
      expect(result, isA<FailedResult<void>>());
      verify(mockAuthRepo.resetPass(resetReq: resetPassRequest)).called(1);
    });
  });
}

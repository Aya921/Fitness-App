import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/data/repository_impl/auth_repo_impl.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:fitness/features/auth/domain/use_case/forgetPassUseCases/send_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_pass_use_case_test.mocks.dart';


@GenerateMocks([AuthRepoImpl])
void main() {
  late MockAuthRepoImpl mockAuthRepo;
  late SendCodeUseCase sendCodeUseCase;
  late SendCodeRequest sendCodeRequest;

  setUp(() {
    mockAuthRepo = MockAuthRepoImpl();
    sendCodeUseCase = SendCodeUseCase(mockAuthRepo);
    sendCodeRequest = SendCodeRequest(otpCode: '123456');
  });

  group('SendCodeUseCase', () {
    test(' should return SuccessResult when repo call succeeds', () async {
      // arrange
      final mockResult = SuccessResult<void>(null);
      provideDummy<Result<void>>(mockResult);

      when(mockAuthRepo.sendCode(code: sendCodeRequest))
          .thenAnswer((_) async => mockResult);

      // act
      final result = await sendCodeUseCase.sendCode(code: sendCodeRequest);

      // assert
      expect(result, isA<SuccessResult<void>>());
      verify(mockAuthRepo.sendCode(code: sendCodeRequest)).called(1);
    });

    test('should return FailedResult when repo call fails', () async {
      // arrange
      final mockResult = FailedResult<void>('error');
      provideDummy<Result<void>>(mockResult);

      when(mockAuthRepo.sendCode(code: sendCodeRequest))
          .thenAnswer((_) async => mockResult);

      // act
      final result = await sendCodeUseCase.sendCode(code: sendCodeRequest);

      // assert
      expect(result, isA<FailedResult<void>>());
      verify(mockAuthRepo.sendCode(code: sendCodeRequest)).called(1);
    });
  });
}

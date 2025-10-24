import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/data/repository_impl/auth_repo_impl.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:fitness/features/auth/domain/use_case/forgetPassUseCases/forget_pass_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_pass_use_case_test.mocks.dart';
@GenerateMocks([AuthRepoImpl])

void main() {
  late MockAuthRepoImpl mockAuthRepo;
  late ForgetPassUseCase forgetPassUseCase;
  late ForgetPassRequest forgetPassRequest;

  setUp(() {
    mockAuthRepo = MockAuthRepoImpl();
    forgetPassUseCase = ForgetPassUseCase(mockAuthRepo);
    forgetPassRequest = ForgetPassRequest(email: 'test@example.com');
  });

  group('ForgetPassUseCase', () {
    const forgetPassResponse = ForgetPassResponse(info: 'Success');

    test('should return SuccessResult when repo call succeeds', () async {
      final mockResult = SuccessResult<ForgetPassResponse>(forgetPassResponse);
      provideDummy<Result<ForgetPassResponse>>(mockResult);

      when(mockAuthRepo.forgetPass(forgetPassReq: forgetPassRequest))
          .thenAnswer((_) async => mockResult);

      final result = await forgetPassUseCase.forgetPass(forgetPassReq: forgetPassRequest);

      expect(result, isA<SuccessResult<ForgetPassResponse>>());
      verify(mockAuthRepo.forgetPass(forgetPassReq: forgetPassRequest)).called(1);
    });

    test('should return FailedResult when repo call fails', () async {
      final mockResult = FailedResult<ForgetPassResponse>('error');
      provideDummy<Result<ForgetPassResponse>>(mockResult);

      when(mockAuthRepo.forgetPass(forgetPassReq: forgetPassRequest))
          .thenAnswer((_) async => mockResult);

      final result = await forgetPassUseCase.forgetPass(forgetPassReq: forgetPassRequest);

      expect(result, isA<FailedResult<ForgetPassResponse>>());
      verify(mockAuthRepo.forgetPass(forgetPassReq: forgetPassRequest)).called(1);
    });
  });
}

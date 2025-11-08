import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/domain/repo/edit_profile/edit_profile_repo.dart';
import 'package:fitness/features/home/domain/usecase/edit_profile/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';



@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockEditProfileRepo;
  late EditProfileUseCase editProfileUseCase;

  setUp(() {
    mockEditProfileRepo = MockEditProfileRepo();
    editProfileUseCase = EditProfileUseCase(mockEditProfileRepo);
  });

  group('EditProfileUseCase', () {
    final request = EditProfileRequest(
      firstName: 'Test',
      lastName: 'User',
      email: 'test@example.com',
      height: 170,
      weight: 70,
      activityLevel: 'level1',
      goal: 'maintain',
    );

    test('returns SuccessResult when repo call succeeds', () async {
      final mockResult = SuccessResult<AuthEntity>(
        const AuthEntity(token: 'dummy_token', user: null),
      );
      provideDummy<Result<AuthEntity>>(mockResult);

      when(mockEditProfileRepo.editProfile(request))
          .thenAnswer((_) async => mockResult);

      final result = await editProfileUseCase.call(request);

      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = result as SuccessResult<AuthEntity>;
      expect(success.successResult.token, 'dummy_token');
      verify(mockEditProfileRepo.editProfile(request)).called(1);
    });

    test('returns FailedResult when repo call fails', () async {
      final mockResult = FailedResult<AuthEntity>('Failed to edit profile');
      provideDummy<Result<AuthEntity>>(mockResult);

      when(mockEditProfileRepo.editProfile(request))
          .thenAnswer((_) async => mockResult);

      final result = await editProfileUseCase.call(request);

      expect(result, isA<FailedResult<AuthEntity>>());
      final fail = result as FailedResult<AuthEntity>;
      expect(fail.errorMessage, 'Failed to edit profile');
      verify(mockEditProfileRepo.editProfile(request)).called(1);
    });
  });
}

import 'dart:io';

import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:fitness/features/home/data/data_source/edit_profile/edit_profile_ds.dart';
import 'package:fitness/features/home/data/repo_impl/edit_profile/edit_profile_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_repo_impl_test.mocks.dart';

@GenerateMocks([EditProfileDs])
void main() {
  late MockEditProfileDs mockEditProfileDs;
  late EditProfileRepoImpl editProfileRepoImpl;

  setUp(() {
    mockEditProfileDs = MockEditProfileDs();
    editProfileRepoImpl = EditProfileRepoImpl(mockEditProfileDs);
  });

  group('editProfile', () {
    final request = EditProfileRequest(
      firstName: 'Dummy',
      lastName: 'User',
      email: 'dummy@example.com',
      height: 170,
      weight: 70,
      activityLevel: 'level1',
      goal: 'maintain',
    );

    test('returns SuccessResult with dummy AuthEntity', () async {
      final mockResult = SuccessResult<AuthEntity>(
        const AuthEntity(token: 'dummy_token', user: null),
      );

      // provide dummy like your other tests
      provideDummy<Result<AuthEntity>>(mockResult);

      when(mockEditProfileDs.editProfile(request))
          .thenAnswer((_) async => mockResult);

      final result = await editProfileRepoImpl.editProfile(request);

      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = result as SuccessResult<AuthEntity>;
      expect(success.successResult.token, 'dummy_token');
      verify(mockEditProfileDs.editProfile(request)).called(1);
    });

    test('returns FailedResult with dummy error', () async {
      final mockResult = FailedResult<AuthEntity>('dummy error');

      // provide dummy like your other tests
      provideDummy<Result<AuthEntity>>(mockResult);

      when(mockEditProfileDs.editProfile(request))
          .thenAnswer((_) async => mockResult);

      final result = await editProfileRepoImpl.editProfile(request);

      expect(result, isA<FailedResult<AuthEntity>>());
      final fail = result as FailedResult<AuthEntity>;
      expect(fail.errorMessage, 'dummy error');
      verify(mockEditProfileDs.editProfile(request)).called(1);
    });
  });

  group('uploadUserPhoto', () {
    final dummyFile = File('dummy_path/photo.png');

    test('returns SuccessResult with dummy URL', () async {
      final mockResult = SuccessResult<String>('https://dummy.com/photo.png');

      provideDummy<Result<String>>(mockResult);

      when(mockEditProfileDs.uploadUserPhoto(dummyFile))
          .thenAnswer((_) async => mockResult);

      final result = await editProfileRepoImpl.uploadUserPhoto(dummyFile);

      expect(result, isA<SuccessResult<String>>());
      final success = result as SuccessResult<String>;
      expect(success.successResult, 'https://dummy.com/photo.png');
      verify(mockEditProfileDs.uploadUserPhoto(dummyFile)).called(1);
    });

    test('returns FailedResult with dummy error', () async {
      final mockResult = FailedResult<String>('upload failed');

      provideDummy<Result<String>>(mockResult);

      when(mockEditProfileDs.uploadUserPhoto(dummyFile))
          .thenAnswer((_) async => mockResult);

      final result = await editProfileRepoImpl.uploadUserPhoto(dummyFile);

      expect(result, isA<FailedResult<String>>());
      final fail = result as FailedResult<String>;
      expect(fail.errorMessage, 'upload failed');
      verify(mockEditProfileDs.uploadUserPhoto(dummyFile)).called(1);
    });
  });
}

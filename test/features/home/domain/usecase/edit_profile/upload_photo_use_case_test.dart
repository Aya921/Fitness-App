import 'dart:io';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/repo/edit_profile/edit_profile_repo.dart';
import 'package:fitness/features/home/domain/usecase/edit_profile/upload_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockEditProfileRepo;
  late UploadPhotoUseCase uploadPhotoUseCase;

  setUp(() {
    mockEditProfileRepo = MockEditProfileRepo();
    uploadPhotoUseCase = UploadPhotoUseCase(mockEditProfileRepo);
  });

  group('UploadPhotoUseCase', () {
    final photo = File('test_photo.jpg');

    test('returns SuccessResult when repo call succeeds', () async {
      final mockResult = SuccessResult<String>('https://dummyurl.com/photo.jpg');
      provideDummy<Result<String>>(mockResult);

      when(mockEditProfileRepo.uploadUserPhoto(photo))
          .thenAnswer((_) async => mockResult);

      final result = await uploadPhotoUseCase.call(photo);

      expect(result, isA<SuccessResult<String>>());
      final success = result as SuccessResult<String>;
      expect(success.successResult, 'https://dummyurl.com/photo.jpg');
      verify(mockEditProfileRepo.uploadUserPhoto(photo)).called(1);
    });

    test('returns FailedResult when repo call fails', () async {
      final mockResult = FailedResult<String>('Failed to upload photo');
      provideDummy<Result<String>>(mockResult);

      when(mockEditProfileRepo.uploadUserPhoto(photo))
          .thenAnswer((_) async => mockResult);

      final result = await uploadPhotoUseCase.call(photo);

      expect(result, isA<FailedResult<String>>());
      final fail = result as FailedResult<String>;
      expect(fail.errorMessage, 'Failed to upload photo');
      verify(mockEditProfileRepo.uploadUserPhoto(photo)).called(1);
    });
  });
}

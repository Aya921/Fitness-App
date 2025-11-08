import 'dart:io';

import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/auth/api/models/auth_response/user_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/api/data_source_impl/edit_profile/edit_profile_ds_impl.dart';
import 'package:fitness/features/home/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late EditProfileDsImpl editProfileDsImpl;

  setUp(() {
    mockApiServices = MockApiServices();
    editProfileDsImpl = EditProfileDsImpl(mockApiServices);
  });

  group('editProfile', () {
    final request = EditProfileRequest(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      height: 180,
      weight: 75,
      activityLevel: 'level1',
      goal: 'loseWeight',
    );

    test('returns SuccessResult when apiServices returns valid AuthResponse', () async {
      final authResponse = AuthResponse(
        message: 'success',
        token: 'abcd1234',
        user: UserResponse(
          id: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
        ),
      );

      when(mockApiServices.editProfile(request))
          .thenAnswer((_) async => authResponse);

      final result = await editProfileDsImpl.editProfile(request);

      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = result as SuccessResult<AuthEntity>;
      expect(success.successResult.token, 'abcd1234');
      expect(success.successResult.user!.personalInfo!.firstName, 'John');
      verify(mockApiServices.editProfile(request)).called(1);
    });

    test('returns FailedResult when apiServices throws exception', () async {
      when(mockApiServices.editProfile(request)).thenThrow(Exception('API error'));

      final result = await editProfileDsImpl.editProfile(request);

      expect(result, isA<FailedResult<AuthEntity>>());
      final fail = result as FailedResult<AuthEntity>;
      expect(fail.errorMessage, contains('API error'));
      verify(mockApiServices.editProfile(request)).called(1);
    });
  });

  group('uploadUserPhoto', () {
    final file = File('dummy_path/photo.png');

    test('returns SuccessResult when apiServices.uploadUserPhoto succeeds', () async {
      const url = 'https://example.com/photo.png';
      when(mockApiServices.uploadUserPhoto(file)).thenAnswer((_) async => url);

      final result = await editProfileDsImpl.uploadUserPhoto(file);

      expect(result, isA<SuccessResult<String>>());
      final success = result as SuccessResult<String>;
      expect(success.successResult, url);
      verify(mockApiServices.uploadUserPhoto(file)).called(1);
    });

    test('returns FailedResult when apiServices.uploadUserPhoto throws exception', () async {
      when(mockApiServices.uploadUserPhoto(file)).thenThrow(Exception('upload error'));

      final result = await editProfileDsImpl.uploadUserPhoto(file);

      expect(result, isA<FailedResult<String>>());
      final fail = result as FailedResult<String>;
      expect(fail.errorMessage, contains('upload error'));
      verify(mockApiServices.uploadUserPhoto(file)).called(1);
    });
  });
}

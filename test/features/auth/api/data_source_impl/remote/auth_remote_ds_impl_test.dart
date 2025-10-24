import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/storage/secure_storage_service.dart';
import 'package:fitness/features/auth/api/client/auth_api_services.dart';
import 'package:fitness/features/auth/api/data_source_impl/remote/auth_remote_ds_impl.dart';
import 'package:fitness/features/auth/api/models/auth_response/auth_response.dart';
import 'package:fitness/features/auth/api/models/auth_response/body_info.dart';
import 'package:fitness/features/auth/api/models/auth_response/personal_info.dart';
import 'package:fitness/features/auth/api/models/auth_response/user_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_ds_impl_test.mocks.dart';

@GenerateMocks([AuthApiServices, SecureStorageService])
void main() {
  late AuthRemoteDsImpl authRemoteDsImpl;
  late MockAuthApiServices mockAuthApiServices;
  late MockSecureStorageService mockSecureStorageService;

  setUp(() {
    mockAuthApiServices = MockAuthApiServices();
    mockSecureStorageService = MockSecureStorageService();
    authRemoteDsImpl = AuthRemoteDsImpl(
      mockAuthApiServices,
      mockSecureStorageService,
    );
  });

  const String email = "test@gmail.com";
  const String password = "password";

  final fakeResponse = AuthResponse(
    message: "message",
    token: "token",
    user: UserResponse(
      personalInfo: const PersonalInfo(
        id: "123",
        firstName: "Rana",
        lastName: "Gebril",
        photo: "",
        age: 21,
        gender: "female",
        email: email,
      ),
      bodyInfo: const BodyInfo(weight: 70, height: 165),
      activityLevel: "Level 1",
      goal: "Gain weight",
      createdAt: "",
    ),
  );

  group('logIn', () {
    test("Should return SuccessResult when API call success", () async {
      // Arrange
      when(
        mockAuthApiServices.logIn(any),
      ).thenAnswer((_) async => fakeResponse);
      when(
        mockSecureStorageService.saveToken(any),
      ).thenAnswer((_) async => Future.value());

      // Act
      final result = await authRemoteDsImpl.logIn(email, password);

      // Assert
      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = (result as SuccessResult<AuthEntity>).successResult;
      expect(success.token, "token");
      expect(success.user?.personalInfo?.firstName, "Rana");
      expect(success.user?.bodyInfo?.height, 165);
      verify(mockSecureStorageService.saveToken("token")).called(1);
    });

    test("Should return FailedResult when API throws Exception", () async {
      // Arrange
      when(mockAuthApiServices.logIn(any)).thenThrow(Exception("error"));

      // Act
      final result = await authRemoteDsImpl.logIn(email, password);

      // Assert
      expect(result, isA<FailedResult<AuthEntity>>());
      final error = (result as FailedResult<AuthEntity>).errorMessage;
      expect(error, contains("error"));
    });
  });

  group("getLoggedUser test", () {
    test("Should return SuccessResult when API returns valid user", () async {
      // Arrange
      when(
        mockAuthApiServices.getLoggedUser(),
      ).thenAnswer((_) async => fakeResponse);

      // Act
      final result = await authRemoteDsImpl.getLoggedUser();

      // Assert
      expect(result, isA<SuccessResult<AuthEntity>>());
      final success = (result as SuccessResult<AuthEntity>).successResult;
      expect(success.user?.personalInfo?.firstName, "Rana");
      expect(success.user?.bodyInfo?.height, 165);
      verify(mockAuthApiServices.getLoggedUser()).called(1);
    });

    test("Should return FailedResult when API throws exception", () async {
      // Arrange
      when(
        mockAuthApiServices.getLoggedUser(),
      ).thenThrow(Exception("Server error"));

      // Act
      final result = await authRemoteDsImpl.getLoggedUser();

      // Assert
      expect(result, isA<FailedResult<AuthEntity>>());
      final error = (result as FailedResult<AuthEntity>).errorMessage;
      expect(error, contains("Server error"));
    });
  });
}

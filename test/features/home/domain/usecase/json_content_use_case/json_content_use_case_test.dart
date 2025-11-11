import 'package:fitness/features/home/domain/usecase/json_content_use_case/json_content_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:fitness/features/home/domain/repo/json_content_repository/json_content_repository.dart';

import 'json_content_use_case_test.mocks.dart';

@GenerateMocks([JsonContentRepository])
void main() {
  late JsonContentUseCase useCase;
  late MockJsonContentRepository mockRepository;

  const fakeHelpEntity = HelpContentEntity(sections: []);
  const fakePrivacyEntity = PrivacyPolicyEntity(sections: []);
  const fakeSecurityEntity = SecurityRolesEntity(sections: []);

  setUp(() {
    mockRepository = MockJsonContentRepository();
    useCase = JsonContentUseCase(jsonContentRepository: mockRepository);

    provideDummy<Result<HelpContentEntity>>(FailedResult("Dummy"));
    provideDummy<Result<PrivacyPolicyEntity>>(FailedResult("Dummy"));
    provideDummy<Result<SecurityRolesEntity>>(FailedResult("Dummy"));
  });

  //================ callHelp =================//
  group("callHelp test", () {
    test("Should return SuccessResult when repository success", () async {
      // Arrange
      when(mockRepository.getHelpContent())
          .thenAnswer((_) async => SuccessResult(fakeHelpEntity));

      // Act
      final result = await useCase.callHelp();

      // Assert
      expect(result, isA<SuccessResult<HelpContentEntity>>());
      final success = (result as SuccessResult<HelpContentEntity>).successResult;
      expect(success, fakeHelpEntity);
      verify(mockRepository.getHelpContent()).called(1);
    });

    test("Should return FailedResult when repository failed", () async {
      // Arrange
      when(mockRepository.getHelpContent())
          .thenAnswer((_) async => FailedResult("Failed to fetch help"));

      // Act
      final result = await useCase.callHelp();

      // Assert
      expect(result, isA<FailedResult<HelpContentEntity>>());
      final failure = (result as FailedResult<HelpContentEntity>).errorMessage;
      expect(failure, contains("Failed to fetch help"));
      verify(mockRepository.getHelpContent()).called(1);
    });
  });

  //================ callPrivacy =================//
  group("callPrivacy test", () {
    test("Should return SuccessResult when repository success", () async {
      // Arrange
      when(mockRepository.getPrivacyPolicy())
          .thenAnswer((_) async => SuccessResult(fakePrivacyEntity));

      // Act
      final result = await useCase.callPrivacy();

      // Assert
      expect(result, isA<SuccessResult<PrivacyPolicyEntity>>());
      final success =
          (result as SuccessResult<PrivacyPolicyEntity>).successResult;
      expect(success, fakePrivacyEntity);
      verify(mockRepository.getPrivacyPolicy()).called(1);
    });

    test("Should return FailedResult when repository failed", () async {
      // Arrange
      when(mockRepository.getPrivacyPolicy())
          .thenAnswer((_) async => FailedResult("Failed to fetch privacy"));

      // Act
      final result = await useCase.callPrivacy();

      // Assert
      expect(result, isA<FailedResult<PrivacyPolicyEntity>>());
      final failure = (result as FailedResult<PrivacyPolicyEntity>).errorMessage;
      expect(failure, contains("Failed to fetch privacy"));
      verify(mockRepository.getPrivacyPolicy()).called(1);
    });
  });

  //================ callSecurity =================//
  group("callSecurity test", () {
    test("Should return SuccessResult when repository success", () async {
      // Arrange
      when(mockRepository.getSecurityRoles())
          .thenAnswer((_) async => SuccessResult(fakeSecurityEntity));

      // Act
      final result = await useCase.callSecurity();

      // Assert
      expect(result, isA<SuccessResult<SecurityRolesEntity>>());
      final success =
          (result as SuccessResult<SecurityRolesEntity>).successResult;
      expect(success, fakeSecurityEntity);
      verify(mockRepository.getSecurityRoles()).called(1);
    });

    test("Should return FailedResult when repository failed", () async {
      // Arrange
      when(mockRepository.getSecurityRoles())
          .thenAnswer((_) async => FailedResult("Failed to fetch security"));

      // Act
      final result = await useCase.callSecurity();

      // Assert
      expect(result, isA<FailedResult<SecurityRolesEntity>>());
      final failure = (result as FailedResult<SecurityRolesEntity>).errorMessage;
      expect(failure, contains("Failed to fetch security"));
      verify(mockRepository.getSecurityRoles()).called(1);
    });
  });
}

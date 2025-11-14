import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/json_content_data_source/json_content_data_source.dart';
import 'package:fitness/features/home/data/repo_impl/json_content_repository_impl/json_content_repository_impl.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';

import 'json_content_repository_impl_test.mocks.dart';

@GenerateMocks([JsonContentDataSource])
void main() {
  late JsonContentRepositoryImpl repositoryImpl;
  late MockJsonContentDataSource mockDataSource;

  const fakeHelpEntity = HelpContentEntity(sections: []);
  const fakePrivacyEntity = PrivacyPolicyEntity(sections: []);
  const fakeSecurityEntity = SecurityRolesEntity(sections: []);

  setUp(() {
    mockDataSource = MockJsonContentDataSource();
    repositoryImpl = JsonContentRepositoryImpl(mockDataSource);

    provideDummy<Result<HelpContentEntity>>(FailedResult("Dummy"));
    provideDummy<Result<PrivacyPolicyEntity>>(FailedResult("Dummy"));
    provideDummy<Result<SecurityRolesEntity>>(FailedResult("Dummy"));
  });

  //================ getHelpContent =================//
  group("getHelpContent test", () {
    test("Should return SuccessResult when data source success", () async {
      // Arrange
      when(mockDataSource.fetchHelpData())
          .thenAnswer((_) async => SuccessResult(fakeHelpEntity));

      // Act
      final result = await repositoryImpl.getHelpContent();

      // Assert
      expect(result, isA<SuccessResult<HelpContentEntity>>());
      final success = (result as SuccessResult<HelpContentEntity>).successResult;
      expect(success, fakeHelpEntity);
      verify(mockDataSource.fetchHelpData()).called(1);
    });

    test("Should return FailedResult when data source failed", () async {
      // Arrange
      when(mockDataSource.fetchHelpData())
          .thenAnswer((_) async => FailedResult("Failed to fetch help"));

      // Act
      final result = await repositoryImpl.getHelpContent();

      // Assert
      expect(result, isA<FailedResult<HelpContentEntity>>());
      final failure = (result as FailedResult<HelpContentEntity>).errorMessage;
      expect(failure, contains("Failed to fetch help"));
      verify(mockDataSource.fetchHelpData()).called(1);
    });
  });

  //================ getPrivacyPolicy =================//
  group("getPrivacyPolicy test", () {
    test("Should return SuccessResult when data source success", () async {
      // Arrange
      when(mockDataSource.fetchPrivacyPolicyData())
          .thenAnswer((_) async => SuccessResult(fakePrivacyEntity));

      // Act
      final result = await repositoryImpl.getPrivacyPolicy();

      // Assert
      expect(result, isA<SuccessResult<PrivacyPolicyEntity>>());
      final success = (result as SuccessResult<PrivacyPolicyEntity>).successResult;
      expect(success, fakePrivacyEntity);
      verify(mockDataSource.fetchPrivacyPolicyData()).called(1);
    });

    test("Should return FailedResult when data source failed", () async {
      // Arrange
      when(mockDataSource.fetchPrivacyPolicyData())
          .thenAnswer((_) async => FailedResult("Failed to fetch privacy"));

      // Act
      final result = await repositoryImpl.getPrivacyPolicy();

      // Assert
      expect(result, isA<FailedResult<PrivacyPolicyEntity>>());
      final failure = (result as FailedResult<PrivacyPolicyEntity>).errorMessage;
      expect(failure, contains("Failed to fetch privacy"));
      verify(mockDataSource.fetchPrivacyPolicyData()).called(1);
    });
  });

  //================ getSecurityRoles =================//
  group("getSecurityRoles test", () {
    test("Should return SuccessResult when data source success", () async {
      // Arrange
      when(mockDataSource.fetchSecurityRolesData())
          .thenAnswer((_) async => SuccessResult(fakeSecurityEntity));

      // Act
      final result = await repositoryImpl.getSecurityRoles();

      // Assert
      expect(result, isA<SuccessResult<SecurityRolesEntity>>());
      final success = (result as SuccessResult<SecurityRolesEntity>).successResult;
      expect(success, fakeSecurityEntity);
      verify(mockDataSource.fetchSecurityRolesData()).called(1);
    });

    test("Should return FailedResult when data source failed", () async {
      // Arrange
      when(mockDataSource.fetchSecurityRolesData())
          .thenAnswer((_) async => FailedResult("Failed to fetch security"));

      // Act
      final result = await repositoryImpl.getSecurityRoles();

      // Assert
      expect(result, isA<FailedResult<SecurityRolesEntity>>());
      final failure = (result as FailedResult<SecurityRolesEntity>).errorMessage;
      expect(failure, contains("Failed to fetch security"));
      verify(mockDataSource.fetchSecurityRolesData()).called(1);
    });
  });
}

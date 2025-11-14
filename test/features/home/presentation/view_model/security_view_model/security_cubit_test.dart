
import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:fitness/features/home/domain/usecase/json_content_use_case/json_content_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_intent.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'security_cubit_test.mocks.dart';

@GenerateMocks([JsonContentUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late SecurityCubit securityCubit;
  late MockJsonContentUseCase mockJsonContentUseCase;
  late Result<SecurityRolesEntity> expectedSuccessResult;
  late FailedResult<SecurityRolesEntity> expectedFailureResult;

  setUpAll(() {
    mockJsonContentUseCase = MockJsonContentUseCase();

    const securityRolesEntity = SecurityRolesEntity(
      sections: [
        SecuritySectionEntity(
          section: 'page_title',
          content: LocalizedTextEntity(
            en: 'User Roles & Permissions',
            ar: 'أدوار وصلاحيات المستخدمين',
          ),
        ),
        SecuritySectionEntity(
          section: 'page_description',
          content: LocalizedTextEntity(
            en: 'Manage user access',
            ar: 'إدارة وصول المستخدمين',
          ),
        ),
        SecuritySectionEntity(
          section: 'role_definition',
          roleDefinition: RoleDefinitionEntity(
            roleId: 'super_admin',
            name: LocalizedTextEntity(
              en: 'Super Admin',
              ar: 'المدير العام',
            ),
            description: LocalizedTextEntity(
              en: 'Full system access',
              ar: 'وصول كامل للنظام',
            ),
            permissions: [
              PermissionEntity(
                key: 'system.config.write',
                name: LocalizedTextEntity(
                  en: 'Modify System Config',
                  ar: 'تعديل إعدادات النظام',
                ),
                description: LocalizedTextEntity(
                  en: 'Can change core settings',
                  ar: 'يمكنه تغيير الإعدادات',
                ),
              ),
              PermissionEntity(
                key: 'user.all.full',
                name: LocalizedTextEntity(
                  en: 'Full User Management',
                  ar: 'إدارة كاملة للمستخدمين',
                ),
                description: LocalizedTextEntity(
                  en: 'Can manage all users',
                  ar: 'يمكنه إدارة جميع المستخدمين',
                ),
              ),
            ],
          ),
        ),
      ],
    );

    expectedSuccessResult = SuccessResult<SecurityRolesEntity>(securityRolesEntity);
    expectedFailureResult = FailedResult<SecurityRolesEntity>('Failed to load security roles');

    provideDummy<Result<SecurityRolesEntity>>(expectedSuccessResult);
    provideDummy<Result<SecurityRolesEntity>>(expectedFailureResult);
  });

  setUp(() {
    securityCubit = SecurityCubit(mockJsonContentUseCase);
  });

  group('SecurityCubit initialization', () {
    test('initial state should have initial status', () {
      expect(securityCubit.state.securityRolesState.isInitial, true);
    });
  });

  group('LoadSecurityPolicyIntent', () {
    blocTest<SecurityCubit, SecurityState>(
      'emits [loading, success] when loading security roles is successful',
      build: () {
        when(mockJsonContentUseCase.callSecurity())
            .thenAnswer((_) async => expectedSuccessResult);
        return securityCubit;
      },
      act: (cubit) => cubit.doIntent( LoadSecurityPolicyIntent()),
      expect: () => [
        isA<SecurityState>().having(
          (state) => state.securityRolesState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<SecurityState>()
            .having(
              (state) => state.securityRolesState.isSuccess,
              'isSuccess',
              equals(true),
            )
            .having(
              (state) => state.securityRolesState.data?.sections.length,
              'sections length',
              equals(3),
            )
            .having(
              (state) => state.securityRolesState.data?.sections[0].section,
              'first section',
              equals('page_title'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callSecurity()).called(1);
      },
    );

    blocTest<SecurityCubit, SecurityState>(
      'emits [loading, failure] when loading security roles fails',
      build: () {
        when(mockJsonContentUseCase.callSecurity())
            .thenAnswer((_) async => expectedFailureResult);
        return securityCubit;
      },
      act: (cubit) => cubit.doIntent( LoadSecurityPolicyIntent()),
      expect: () => [
        isA<SecurityState>().having(
          (state) => state.securityRolesState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<SecurityState>()
            .having(
              (state) => state.securityRolesState.isFailure,
              'isFailure',
              equals(true),
            )
            .having(
              (state) => state.securityRolesState.error is ResponseException
                  ? (state.securityRolesState.error as ResponseException).message
                  : null,
              'error message',
              equals('Failed to load security roles'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callSecurity()).called(1);
      },
    );

    blocTest<SecurityCubit, SecurityState>(
      'emits failure with custom error message when configuration file is corrupted',
      build: () {
        when(mockJsonContentUseCase.callSecurity()).thenAnswer(
          (_) async => FailedResult<SecurityRolesEntity>('Configuration file corrupted'),
        );
        return securityCubit;
      },
      act: (cubit) => cubit.doIntent( LoadSecurityPolicyIntent()),
      expect: () => [
        isA<SecurityState>().having(
          (state) => state.securityRolesState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<SecurityState>()
            .having(
              (state) => state.securityRolesState.isFailure,
              'isFailure',
              equals(true),
            )
            .having(
              (state) => state.securityRolesState.error is ResponseException
                  ? (state.securityRolesState.error as ResponseException).message
                  : null,
              'error message',
              equals('Configuration file corrupted'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callSecurity()).called(1);
      },
    );
  });

  group('SecurityCubit state verification', () {
    blocTest<SecurityCubit, SecurityState>(
      'verify security roles data structure after successful load',
      build: () {
        when(mockJsonContentUseCase.callSecurity())
            .thenAnswer((_) async => expectedSuccessResult);
        return securityCubit;
      },
      act: (cubit) => cubit.doIntent( LoadSecurityPolicyIntent()),
      skip: 1,// for the loading state
      verify: (cubit) {
        final state = cubit.state;
        expect(state.securityRolesState.isSuccess, true);
        expect(state.securityRolesState.data, isNotNull);
        
        final sections = state.securityRolesState.data!.sections;
        expect(sections.length, equals(3));
        
        // Verify page title section
        final pageTitle = sections[0];
        expect(pageTitle.section, equals('page_title'));
        expect(pageTitle.content?.en, equals('User Roles & Permissions'));
        
        // Verify page description section
        final pageDescription = sections[1];
        expect(pageDescription.section, equals('page_description'));
        expect(pageDescription.content?.ar, equals('إدارة وصول المستخدمين'));
        
        // Verify role definition section
        final roleDef = sections[2];
        expect(roleDef.section, equals('role_definition'));
        expect(roleDef.roleDefinition, isNotNull);
        expect(roleDef.roleDefinition?.roleId, equals('super_admin'));
        expect(roleDef.roleDefinition?.permissions?.length, equals(2));
        expect(roleDef.roleDefinition?.permissions?[0].key, equals('system.config.write'));
      },
    );

    blocTest<SecurityCubit, SecurityState>(
      'verify role definition permissions structure',
      build: () {
        when(mockJsonContentUseCase.callSecurity())
            .thenAnswer((_) async => expectedSuccessResult);
        return securityCubit;
      },
      act: (cubit) => cubit.doIntent( LoadSecurityPolicyIntent()),
      skip: 1, // Skip loading state
      verify: (cubit) {
        final roleDefinition = cubit.state.securityRolesState.data!.sections[2].roleDefinition;
        
        expect(roleDefinition?.permissions, hasLength(2));
        
        final firstPermission = roleDefinition!.permissions![0];
        expect(firstPermission.key, equals('system.config.write'));
        expect(firstPermission.name?.en, equals('Modify System Config'));
        expect(firstPermission.description?.ar, equals('يمكنه تغيير الإعدادات'));
        
        final secondPermission = roleDefinition.permissions![1];
        expect(secondPermission.key, equals('user.all.full'));
        expect(secondPermission.name?.en, equals('Full User Management'));
      },
    );
  });

  group('SecurityCubit error handling', () {
    blocTest<SecurityCubit, SecurityState>(
      'handles Exception thrown by use case',
      build: () {
        when(mockJsonContentUseCase.callSecurity())
            .thenThrow(Exception('Unexpected error'));
        return securityCubit;
      },
      act: (cubit) => cubit.doIntent( LoadSecurityPolicyIntent()),
      expect: () => [
        isA<SecurityState>().having(
          (state) => state.securityRolesState.isLoading,
          'isLoading',
          equals(true),
        ),
      ],
      errors: () => [
        isA<Exception>(),
      ],
    );
  });
}
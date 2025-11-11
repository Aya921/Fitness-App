import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/api/data_source_impl/json_content_data_source_impl/json_content_data_source_impl.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/security_roles_entity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'json_content_data_source_impl_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  late JsonContentDataSourceImpl jsonContentDataSourceImpl;
  late MockAssetBundle mockAssetBundle;

  const String helpJsonString = '''
  {
    "help_screen_content": [
      {
        "section": "page_title",
        "content": {
          "en": "Help & Support",
          "ar": "المساعدة والدعم"
        }
      },
      {
        "section": "page_subtitle",
        "content": {
          "en": "How can we help you today?",
          "ar": "كيف يمكننا مساعدتك اليوم؟"
        }
      },
      {
        "section": "contact_us",
        "title": {
          "en": "Get in Touch",
          "ar": "تواصل معنا"
        },
        "content": [
          {
            "id": "contact_001",
            "method": {
              "en": "Email Support",
              "ar": "الدعم عبر البريد الإلكتروني"
            },
            "details": {
              "en": "Get a response within 24 hours.",
              "ar": "احصل على رد خلال 24 ساعة."
            },
            "value": "support@apexfitness.com"
          }
        ]
      },
      {
        "section": "faq",
        "title": {
          "en": "Frequently Asked Questions",
          "ar": "الأسئلة الشائعة"
        },
        "content": [
          {
            "id": "faq_001",
            "question": {
              "en": "How does the AI Trainer work?",
              "ar": "كيف يعمل المدرب الذكي؟"
            },
            "answer": {
              "en": "Our AI Trainer uses your data to build custom plans.",
              "ar": "يستخدم مدربنا الذكي بياناتك لبناء خطط مخصصة."
            }
          }
        ]
      }
    ]
  }
  ''';

  const String privacyPolicyJsonString = '''
  {
    "privacy_policy": [
      {
        "section": "title",
        "content": {
          "en": "Privacy Policy",
          "ar": "سياسة الخصوصية"
        }
      },
      {
        "section": "last_updated",
        "content": {
          "en": "Last Updated: November 1, 2025",
          "ar": "آخر تحديث: 1 نوفمبر 2025"
        }
      },
      {
        "section": "introduction",
        "content": {
          "en": "Welcome to Apex Fitness.",
          "ar": "مرحباً بكم في أبيكس فيتنس."
        }
      },
      {
        "section": "how_we_use_info",
        "title": {
          "en": "How We Use Your Information",
          "ar": "كيف نستخدم معلوماتك"
        },
        "content": {
          "en": [
            "To provide and improve our services.",
            "To personalize your experience.",
            "To communicate with you."
          ],
          "ar": [
            "لتقديم وتحسين خدماتنا.",
            "لتخصيص تجربتك.",
            "للتواصل معك."
          ]
        }
      },
      {
        "section": "information_collection",
        "title": {
          "en": "Information We Collect",
          "ar": "المعلومات التي نجمعها"
        },
        "sub_sections": [
          {
            "type": "paragraph",
            "title": {
              "en": "Personal Data",
              "ar": "البيانات الشخصية"
            },
            "content": {
              "en": "We collect your personal information.",
              "ar": "نحن نجمع معلوماتك الشخصية."
            }
          }
        ]
      }
    ]
  }
  ''';

  const String securityRolesJsonString = '''
  {
    "security_roles_config": [
      {
        "section": "page_title",
        "content": {
          "en": "User Roles & Permissions",
          "ar": "أدوار وصلاحيات المستخدمين"
        }
      },
      {
        "section": "page_description",
        "content": {
          "en": "Manage user access and capabilities.",
          "ar": "إدارة الوصول وقدرات المستخدمين."
        }
      },
      {
        "section": "role_definition",
        "role_id": "super_admin",
        "name": {
          "en": "Super Admin",
          "ar": "المدير العام"
        },
        "description": {
          "en": "Full system access",
          "ar": "وصول كامل للنظام"
        },
        "permissions": [
          {
            "key": "system.config.write",
            "name": {
              "en": "Modify System Configuration",
              "ar": "تعديل إعدادات النظام"
            },
            "description": {
              "en": "Can change core application settings.",
              "ar": "يمكنه تغيير إعدادات التطبيق الأساسية."
            }
          }
        ]
      }
    ]
  }
  ''';

  setUpAll(() {
    mockAssetBundle = MockAssetBundle();
    jsonContentDataSourceImpl = JsonContentDataSourceImpl(mockAssetBundle);

    provideDummy<Result<HelpContentEntity>>(FailedResult("Dummy"));
    provideDummy<Result<PrivacyPolicyEntity>>(FailedResult("Dummy"));
    provideDummy<Result<SecurityRolesEntity>>(FailedResult("Dummy"));
  });

  group("fetchHelpData Tests", () {
    test("return SuccessResult when asset bundle loads help JSON successfully",
        () async {
      // Arrange
      when(mockAssetBundle.loadString('assets/json_files/help.json'))
          .thenAnswer((_) async => helpJsonString);

      // Act
      final result = await jsonContentDataSourceImpl.fetchHelpData();

      // Assert
      expect(result, isA<Result<HelpContentEntity>>());
      expect(result, isA<SuccessResult<HelpContentEntity>>());
      final successResult = result as SuccessResult<HelpContentEntity>;
      expect(successResult.successResult, isA<HelpContentEntity>());
      expect(successResult.successResult.sections, isNotEmpty);
      expect(successResult.successResult.sections.length, equals(4));
      
      // Verify specific content here
      final pageTitle = successResult.successResult.sections
          .firstWhere((s) => s.section == 'page_title');
      expect(pageTitle.content?.en, equals('Help & Support'));
      
      final contactUs = successResult.successResult.sections
          .firstWhere((s) => s.section == 'contact_us');
      expect(contactUs.contactMethods, hasLength(1));
      expect(contactUs.contactMethods?[0].value, equals('support@apexfitness.com'));
      
      verify(mockAssetBundle.loadString('assets/json_files/help.json'))
          .called(1);
    });

    test("return FailedResult when asset bundle throws exception", () async {
      // Arrange
      final exception = Exception("File not found");
      when(mockAssetBundle.loadString('assets/json_files/help.json'))
          .thenThrow(exception);

      // Act
      final result = await jsonContentDataSourceImpl.fetchHelpData();

      // Assert
      expect(result, isA<Result<HelpContentEntity>>());
      expect(result, isA<FailedResult<HelpContentEntity>>());
      expect((result as FailedResult).errorMessage, contains("File not found"));
      verify(mockAssetBundle.loadString('assets/json_files/help.json'))
          .called(1);
    });

    test("return FailedResult when JSON format is invalid", () async {
      // Arrange
      const invalidJson = '{invalid json}';
      when(mockAssetBundle.loadString('assets/json_files/help.json'))
          .thenAnswer((_) async => invalidJson);

      // Act
      final result = await jsonContentDataSourceImpl.fetchHelpData();

      // Assert
      expect(result, isA<Result<HelpContentEntity>>());
      expect(result, isA<FailedResult<HelpContentEntity>>());
      expect(
          (result as FailedResult).errorMessage, contains("FormatException"));
      verify(mockAssetBundle.loadString('assets/json_files/help.json'))
          .called(1);
    });
  });

  group("fetchPrivacyPolicyData Tests", () {
    test(
        "return SuccessResult when asset bundle loads privacy policy JSON successfully",
        () async {
      // Arrange
      when(mockAssetBundle
              .loadString('assets/json_files/privacy_and_security.json'))
          .thenAnswer((_) async => privacyPolicyJsonString);

      // Act
      final result = await jsonContentDataSourceImpl.fetchPrivacyPolicyData();

      // Assert
      expect(result, isA<Result<PrivacyPolicyEntity>>());
      expect(result, isA<SuccessResult<PrivacyPolicyEntity>>());
      final successResult = result as SuccessResult<PrivacyPolicyEntity>;
      expect(successResult.successResult, isA<PrivacyPolicyEntity>());
      expect(successResult.successResult.sections, isNotEmpty);
      expect(successResult.successResult.sections.length, equals(5));
      
      // Verify title section below
      final title = successResult.successResult.sections
          .firstWhere((s) => s.section == 'title');
      expect(title.content, isA<LocalizedTextEntity>());
      
      // Verify section with subsections here
      final infoCollection = successResult.successResult.sections
          .firstWhere((s) => s.section == 'information_collection');
      expect(infoCollection.subSections, hasLength(1));
      
      verify(mockAssetBundle
              .loadString('assets/json_files/privacy_and_security.json'))
          .called(1);
    });

    test("return FailedResult when asset bundle throws exception", () async {
      // Arrange
      final exception = Exception("Asset not found");
      when(mockAssetBundle
              .loadString('assets/json_files/privacy_and_security.json'))
          .thenThrow(exception);

      // Act
      final result = await jsonContentDataSourceImpl.fetchPrivacyPolicyData();

      // Assert
      expect(result, isA<Result<PrivacyPolicyEntity>>());
      expect(result, isA<FailedResult<PrivacyPolicyEntity>>());
      expect(
          (result as FailedResult).errorMessage, contains("Asset not found"));
      verify(mockAssetBundle
              .loadString('assets/json_files/privacy_and_security.json'))
          .called(1);
    });
  });

  group("fetchSecurityRolesData Tests", () {
    test(
        "return SuccessResult when asset bundle loads security roles JSON successfully",
        () async {
      // Arrange
      when(mockAssetBundle
              .loadString('assets/json_files/security_roles_config.json'))
          .thenAnswer((_) async => securityRolesJsonString);

      // Act
      final result = await jsonContentDataSourceImpl.fetchSecurityRolesData();

      // Assert
      expect(result, isA<Result<SecurityRolesEntity>>());
      expect(result, isA<SuccessResult<SecurityRolesEntity>>());
      final successResult = result as SuccessResult<SecurityRolesEntity>;
      expect(successResult.successResult, isA<SecurityRolesEntity>());
      expect(successResult.successResult.sections, isNotEmpty);
      expect(successResult.successResult.sections.length, equals(3));
      
      // Verify role definition here
      final roleDef = successResult.successResult.sections
          .firstWhere((s) => s.section == 'role_definition');
      expect(roleDef.roleDefinition, isNotNull);
      expect(roleDef.roleDefinition?.roleId, equals('super_admin'));
      expect(roleDef.roleDefinition?.permissions, hasLength(1));
      
      verify(mockAssetBundle
              .loadString('assets/json_files/security_roles_config.json'))
          .called(1);
    });

    test("return FailedResult when asset bundle throws exception", () async {
      // Arrange
      final exception = Exception("Permission denied");
      when(mockAssetBundle
              .loadString('assets/json_files/security_roles_config.json'))
          .thenThrow(exception);

      // Act
      final result = await jsonContentDataSourceImpl.fetchSecurityRolesData();

      // Assert
      expect(result, isA<Result<SecurityRolesEntity>>());
      expect(result, isA<FailedResult<SecurityRolesEntity>>());
      expect((result as FailedResult).errorMessage,
          contains("Permission denied"));
      verify(mockAssetBundle
              .loadString('assets/json_files/security_roles_config.json'))
          .called(1);
    });
  });

  group("Multiple operations", () {
    test("can fetch all three JSON types successfully in sequence", () async {
      // Arrange
      when(mockAssetBundle.loadString('assets/json_files/help.json'))
          .thenAnswer((_) async => helpJsonString);
      when(mockAssetBundle
              .loadString('assets/json_files/privacy_and_security.json'))
          .thenAnswer((_) async => privacyPolicyJsonString);
      when(mockAssetBundle
              .loadString('assets/json_files/security_roles_config.json'))
          .thenAnswer((_) async => securityRolesJsonString);

      // Act
      final helpResult = await jsonContentDataSourceImpl.fetchHelpData();
      final privacyResult =
          await jsonContentDataSourceImpl.fetchPrivacyPolicyData();
      final securityResult =
          await jsonContentDataSourceImpl.fetchSecurityRolesData();

      // Assert
      expect(helpResult, isA<SuccessResult<HelpContentEntity>>());
      expect(privacyResult, isA<SuccessResult<PrivacyPolicyEntity>>());
      expect(securityResult, isA<SuccessResult<SecurityRolesEntity>>());

      verify(mockAssetBundle.loadString('assets/json_files/help.json'))
          .called(1);
      verify(mockAssetBundle
              .loadString('assets/json_files/privacy_and_security.json'))
          .called(1);
      verify(mockAssetBundle
              .loadString('assets/json_files/security_roles_config.json'))
          .called(1);
    });
  });
}
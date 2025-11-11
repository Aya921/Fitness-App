import 'package:fitness/features/home/api/models/json_content_model/help_content_model.dart';
import 'package:fitness/features/home/api/models/json_content_model/privacy_content_model.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PrivacyPolicyModel', () {
    test('fromJson should parse valid JSON with string content correctly', () {
      // Arrange
      final json = {
        'privacy_policy': [
          {
            'section': 'title',
            'content': {
              'en': 'Privacy Policy',
              'ar': 'سياسة الخصوصية',
            },
          },
          {
            'section': 'introduction',
            'content': {
              'en': 'Welcome to our app',
              'ar': 'مرحباً بكم في تطبيقنا',
            },
          },
        ],
      };

      // Act
      final model = PrivacyPolicyModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(2));
      expect(model.sections[0].section, equals('title'));
      expect(model.sections[0].content, isA<LocalizedText>());
      expect((model.sections[0].content as LocalizedText).en, equals('Privacy Policy'));
      expect((model.sections[0].content as LocalizedText).ar, equals('سياسة الخصوصية'));
    });

    test('fromJson should parse valid JSON with list content correctly', () {
      // Arrange
      final json = {
        'privacy_policy': [
          {
            'section': 'how_we_use_info',
            'title': {
              'en': 'How We Use Info',
              'ar': 'كيف نستخدم المعلومات',
            },
            'content': {
              'en': ['Item 1', 'Item 2', 'Item 3'],
              'ar': ['عنصر 1', 'عنصر 2', 'عنصر 3'],
            },
          },
        ],
      };

      // Act
      final model = PrivacyPolicyModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(1));
      expect(model.sections[0].section, equals('how_we_use_info'));
      expect(model.sections[0].content, isA<LocalizedText>());
      final content = model.sections[0].content as LocalizedText;
      expect(content.enList, equals(['Item 1', 'Item 2', 'Item 3']));
      expect(content.arList, equals(['عنصر 1', 'عنصر 2', 'عنصر 3']));
    });

    test('fromJson should parse subsections correctly', () {
      // Arrange
      final json = {
        'privacy_policy': [
          {
            'section': 'information_collection',
            'title': {
              'en': 'Information We Collect',
              'ar': 'المعلومات التي نجمعها',
            },
            'sub_sections': [
              {
                'type': 'paragraph',
                'title': {
                  'en': 'Personal Data',
                  'ar': 'البيانات الشخصية',
                },
                'content': {
                  'en': 'We collect your personal data',
                  'ar': 'نحن نجمع بياناتك الشخصية',
                },
              },
            ],
          },
        ],
      };

      // Act
      final model = PrivacyPolicyModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(1));
      expect(model.sections[0].subSections, hasLength(1));
      expect(model.sections[0].subSections?[0].type, equals('paragraph'));
      expect(model.sections[0].subSections?[0].title?.en, equals('Personal Data'));
      expect(model.sections[0].subSections?[0].content?.en,
          equals('We collect your personal data'));
    });

    test('toEntity should convert model with string content to entity correctly', () {
      // Arrange
      const model = PrivacyPolicyModel(
        sections: [
          PrivacySectionModel(
            section: 'title',
            content: LocalizedText(
              en: 'Privacy Policy',
              ar: 'سياسة الخصوصية',
            ),
          ),
        ],
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<PrivacyPolicyEntity>());
      expect(entity.sections, hasLength(1));
      expect(entity.sections[0].section, equals('title'));
      expect(entity.sections[0].content, isA<LocalizedTextEntity>());
    });

    test('toEntity should convert model with list content to entity correctly', () {
      // Arrange
      const model = PrivacyPolicyModel(
        sections: [
          PrivacySectionModel(
            section: 'data_rights',
            content: ['Right 1', 'Right 2'],
          ),
        ],
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<PrivacyPolicyEntity>());
      expect(entity.sections, hasLength(1));
      expect(entity.sections[0].content, isA<List>());
      expect(entity.sections[0].content, hasLength(2));
    });

    test('fromJson should handle null values correctly', () {
      // Arrange
      final json = {
        'privacy_policy': [
          {
            'section': 'title',
          },
        ],
      };

      // Act
      final model = PrivacyPolicyModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(1));
      expect(model.sections[0].section, equals('title'));
      expect(model.sections[0].title, isNull);
      expect(model.sections[0].content, isNull);
      expect(model.sections[0].subSections, isNull);
    });

    test('toEntity should convert subsections correctly', () {
      // Arrange
      const model = PrivacyPolicyModel(
        sections: [
          PrivacySectionModel(
            section: 'info_collection',
            subSections: [
              SubSectionModel(
                type: 'paragraph',
                title: LocalizedText(en: 'Title', ar: 'عنوان'),
                content: LocalizedText(en: 'Content', ar: 'محتوى'),
              ),
            ],
          ),
        ],
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.sections[0].subSections, hasLength(1));
      expect(entity.sections[0].subSections?[0].type, equals('paragraph'));
    });
  });
}
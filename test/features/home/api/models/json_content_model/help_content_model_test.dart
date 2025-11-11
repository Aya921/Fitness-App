import 'package:fitness/features/home/api/models/json_content_model/help_content_model.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HelpContentModel', () {
    test('fromJson should parse valid JSON correctly', () {
      // Arrange
      final json = {
        'help_screen_content': [
          {
            'section': 'page_title',
            'content': {
              'en': 'Help & Support',
              'ar': 'المساعدة والدعم',
            },
          },
          {
            'section': 'contact_us',
            'title': {
              'en': 'Get in Touch',
              'ar': 'تواصل معنا',
            },
            'content': [
              {
                'id': 'contact_001',
                'method': {
                  'en': 'Email Support',
                  'ar': 'الدعم عبر البريد',
                },
                'details': {
                  'en': 'Response in 24 hours',
                  'ar': 'رد خلال 24 ساعة',
                },
                'value': 'support@test.com',
              },
            ],
          },
          {
            'section': 'faq',
            'title': {
              'en': 'FAQ',
              'ar': 'الأسئلة الشائعة',
            },
            'content': [
              {
                'id': 'faq_001',
                'question': {
                  'en': 'How does it work?',
                  'ar': 'كيف يعمل؟',
                },
                'answer': {
                  'en': 'It works great',
                  'ar': 'يعمل بشكل رائع',
                },
              },
            ],
          },
        ],
      };

      // Act
      final model = HelpContentModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(3));
      expect(model.sections[0].section, equals('page_title'));
      expect(model.sections[0].content?.en, equals('Help & Support'));
      expect(model.sections[0].content?.ar, equals('المساعدة والدعم'));

      expect(model.sections[1].section, equals('contact_us'));
      expect(model.sections[1].title?.en, equals('Get in Touch'));
      expect(model.sections[1].contactMethods, hasLength(1));
      expect(model.sections[1].contactMethods?[0].id, equals('contact_001'));
      expect(model.sections[1].contactMethods?[0].value, equals('support@test.com'));

      expect(model.sections[2].section, equals('faq'));
      expect(model.sections[2].faqItems, hasLength(1));
      expect(model.sections[2].faqItems?[0].id, equals('faq_001'));
      expect(model.sections[2].faqItems?[0].question?.en, equals('How does it work?'));
    });

    test('toEntity should convert model to entity correctly', () {
      // Arrange
      const model = HelpContentModel(
        sections: [
          HelpSectionModel(
            section: 'page_title',
            content: LocalizedText(
              en: 'Help',
              ar: 'مساعدة',
            ),
          ),
          HelpSectionModel(
            section: 'contact_us',
            title: LocalizedText(en: 'Contact', ar: 'اتصل'),
            contactMethods: [
              ContactMethodModel(
                id: 'contact_001',
                method: LocalizedText(en: 'Email', ar: 'بريد'),
                details: LocalizedText(en: '24 hours', ar: '24 ساعة'),
                value: 'test@test.com',
              ),
            ],
          ),
          HelpSectionModel(
            section: 'faq',
            faqItems: [
              FaqItemModel(
                id: 'faq_001',
                question: LocalizedText(en: 'Question?', ar: 'سؤال؟'),
                answer: LocalizedText(en: 'Answer', ar: 'جواب'),
              ),
            ],
          ),
        ],
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<HelpContentEntity>());
      expect(entity.sections, hasLength(3));
      expect(entity.sections[0].section, equals('page_title'));
      expect(entity.sections[0].content?.en, equals('Help'));

      expect(entity.sections[1].contactMethods, hasLength(1));
      expect(entity.sections[1].contactMethods?[0].value, equals('test@test.com'));

      expect(entity.sections[2].faqItems, hasLength(1));
      expect(entity.sections[2].faqItems?[0].id, equals('faq_001'));
    });

    test('fromJson should handle null values correctly', () {
      // Arrange
      final json = {
        'help_screen_content': [
          {
            'section': 'page_title',
          },
        ],
      };

      // Act
      final model = HelpContentModel.fromJson(json);

      // Assert
      expect(model.sections, hasLength(1));
      expect(model.sections[0].section, equals('page_title'));
      expect(model.sections[0].content, isNull);
      expect(model.sections[0].title, isNull);
      expect(model.sections[0].contactMethods, isNull);
      expect(model.sections[0].faqItems, isNull);
    });
  });

  group('LocalizedText', () {
    test('getText should return string when isArabic is false', () {
      // Arrange
      const localizedText = LocalizedText(
        en: 'Hello',
        ar: 'مرحبا',
      );

      // Act
      final result = localizedText.getText(false);

      // Assert
      expect(result, equals('Hello'));
    });

    test('getText should return string when isArabic is true', () {
      // Arrange
      const localizedText = LocalizedText(
        en: 'Hello',
        ar: 'مرحبا',
      );

      // Act
      final result = localizedText.getText(true);

      // Assert
      expect(result, equals('مرحبا'));
    });

    test('getText should return list when content is list', () {
      // Arrange
      const localizedText = LocalizedText(
        enList: ['Item 1', 'Item 2'],
        arList: ['عنصر 1', 'عنصر 2'],
      );

      // Act
      final resultEn = localizedText.getText(false);
      final resultAr = localizedText.getText(true);

      // Assert
      expect(resultEn, isA<List<String>>());
      expect(resultEn, hasLength(2));
      expect(resultAr, hasLength(2));
    });

    test('fromJson should parse string content correctly', () {
      // Arrange
      final json = {
        'en': 'Hello',
        'ar': 'مرحبا',
      };

      // Act
      final localizedText = LocalizedText.fromJson(json);

      // Assert
      expect(localizedText.en, equals('Hello'));
      expect(localizedText.ar, equals('مرحبا'));
      expect(localizedText.enList, isNull);
      expect(localizedText.arList, isNull);
    });

    test('fromJson should parse list content correctly', () {
      // Arrange
      final json = {
        'en': ['Hello', 'World'],
        'ar': ['مرحبا', 'عالم'],
      };

      // Act
      final localizedText = LocalizedText.fromJson(json);

      // Assert
      expect(localizedText.en, isNull);
      expect(localizedText.ar, isNull);
      expect(localizedText.enList, equals(['Hello', 'World']));
      expect(localizedText.arList, equals(['مرحبا', 'عالم']));
    });
  });
}
import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/usecase/json_content_use_case/json_content_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_intents.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'help_cubit_test.mocks.dart';

@GenerateMocks([JsonContentUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late HelpCubit helpCubit;
  late MockJsonContentUseCase mockJsonContentUseCase;
  late Result<HelpContentEntity> expectedSuccessResult;
  late FailedResult<HelpContentEntity> expectedFailureResult;

  setUpAll(() {
    mockJsonContentUseCase = MockJsonContentUseCase();

    const helpContentEntity = HelpContentEntity(
      sections: [
        HelpSectionEntity(
          section: 'page_title',
          content: LocalizedTextEntity(
            en: 'Help & Support',
            ar: 'المساعدة والدعم',
          ),
        ),
        HelpSectionEntity(
          section: 'contact_us',
          title: LocalizedTextEntity(
            en: 'Get in Touch',
            ar: 'تواصل معنا',
          ),
          contactMethods: [
            ContactMethodEntity(
              id: 'contact_001',
              method: LocalizedTextEntity(
                en: 'Email Support',
                ar: 'الدعم عبر البريد',
              ),
              details: LocalizedTextEntity(
                en: 'Response in 24 hours',
                ar: 'رد خلال 24 ساعة',
              ),
              value: 'support@test.com',
            ),
          ],
        ),
        HelpSectionEntity(
          section: 'faq',
          title: LocalizedTextEntity(
            en: 'FAQ',
            ar: 'الأسئلة الشائعة',
          ),
          faqItems: [
            FaqItemEntity(
              id: 'faq_001',
              question: LocalizedTextEntity(
                en: 'How does it work?',
                ar: 'كيف يعمل؟',
              ),
              answer: LocalizedTextEntity(
                en: 'It works great',
                ar: 'يعمل بشكل رائع',
              ),
            ),
          ],
        ),
      ],
    );

    expectedSuccessResult = SuccessResult<HelpContentEntity>(helpContentEntity);
    expectedFailureResult = FailedResult<HelpContentEntity>('Failed to load help content');

    provideDummy<Result<HelpContentEntity>>(expectedSuccessResult);
    provideDummy<Result<HelpContentEntity>>(expectedFailureResult);
  });

  setUp(() {
    helpCubit = HelpCubit(mockJsonContentUseCase);
  });

  group('HelpCubit initialization', () {
    test('initial state should have initial status', () {
      expect(helpCubit.state.helpContentState.isInitial, true);
    });
  });

  group('LoadHelpContentIntent', () {
    blocTest<HelpCubit, HelpState>(
      'emits [loading, success] when loading help content is successful',
      build: () {
        when(mockJsonContentUseCase.callHelp())
            .thenAnswer((_) async => expectedSuccessResult);
        return helpCubit;
      },
      act: (cubit) => cubit.doIntent( LoadHelpContentIntent()),
      expect: () => [
        isA<HelpState>().having(
          (state) => state.helpContentState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<HelpState>()
            .having(
              (state) => state.helpContentState.isSuccess,
              'isSuccess',
              equals(true),
            )
            .having(
              (state) => state.helpContentState.data?.sections.length,
              'sections length',
              equals(3),
            )
            .having(
              (state) => state.helpContentState.data?.sections[0].section,
              'first section',
              equals('page_title'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callHelp()).called(1);
      },
    );

    blocTest<HelpCubit, HelpState>(
      'emits [loading, failure] when loading help content fails',
      build: () {
        when(mockJsonContentUseCase.callHelp())
            .thenAnswer((_) async => expectedFailureResult);
        return helpCubit;
      },
      act: (cubit) => cubit.doIntent( LoadHelpContentIntent()),
      expect: () => [
        isA<HelpState>().having(
          (state) => state.helpContentState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<HelpState>()
            .having(
              (state) => state.helpContentState.isFailure,
              'isFailure',
              equals(true),
            )
            .having(
              (state) => state.helpContentState.error is ResponseException
                  ? (state.helpContentState.error as ResponseException).message
                  : null,
              'error message',
              equals('Failed to load help content'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callHelp()).called(1);
      },
    );

    blocTest<HelpCubit, HelpState>(
      'emits failure with custom error message when API returns error',
      build: () {
        when(mockJsonContentUseCase.callHelp()).thenAnswer(
          (_) async => FailedResult<HelpContentEntity>('Network error occurred'),
        );
        return helpCubit;
      },
      act: (cubit) => cubit.doIntent( LoadHelpContentIntent()),
      expect: () => [
        isA<HelpState>().having(
          (state) => state.helpContentState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<HelpState>()
            .having(
              (state) => state.helpContentState.isFailure,
              'isFailure',
              equals(true),
            )
            .having(
              (state) => state.helpContentState.error is ResponseException
                  ? (state.helpContentState.error as ResponseException).message
                  : null,
              'error message',
              equals('Network error occurred'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callHelp()).called(1);
      },
    );
  });

  group('HelpCubit state verification', () {
    blocTest<HelpCubit, HelpState>(
      'verify help content data structure after successful load',
      build: () {
        when(mockJsonContentUseCase.callHelp())
            .thenAnswer((_) async => expectedSuccessResult);
        return helpCubit;
      },
      act: (cubit) => cubit.doIntent( LoadHelpContentIntent()),
      skip: 1,
      verify: (cubit) {
        final state = cubit.state;
        expect(state.helpContentState.isSuccess, true);
        expect(state.helpContentState.data, isNotNull);
        
        final sections = state.helpContentState.data!.sections;
        expect(sections.length, equals(3));
        
        // Verify page title section
        final pageTitle = sections[0];
        expect(pageTitle.section, equals('page_title'));
        expect(pageTitle.content?.en, equals('Help & Support'));
        
        // Verify contact us section
        final contactUs = sections[1];
        expect(contactUs.section, equals('contact_us'));
        expect(contactUs.contactMethods?.length, equals(1));
        expect(contactUs.contactMethods?[0].value, equals('support@test.com'));
        
        // Verify FAQ section
        final faq = sections[2];
        expect(faq.section, equals('faq'));
        expect(faq.faqItems?.length, equals(1));
        expect(faq.faqItems?[0].id, equals('faq_001'));
      },
    );
  });
}
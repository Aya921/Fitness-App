import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/domain/usecase/json_content_use_case/json_content_use_case.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_intent.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'privacy_policy_cubit_test.mocks.dart';

@GenerateMocks([JsonContentUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late PrivacyPolicyCubit privacyPolicyCubit;
  late MockJsonContentUseCase mockJsonContentUseCase;
  late Result<PrivacyPolicyEntity> expectedSuccessResult;
  late FailedResult<PrivacyPolicyEntity> expectedFailureResult;

  setUpAll(() {
    mockJsonContentUseCase = MockJsonContentUseCase();

    const privacyPolicyEntity = PrivacyPolicyEntity(
      sections: [
        PrivacySectionEntity(
          section: 'title',
          content: LocalizedTextEntity(
            en: 'Privacy Policy',
            ar: 'سياسة الخصوصية',
          ),
        ),
        PrivacySectionEntity(
          section: 'last_updated',
          content: LocalizedTextEntity(
            en: 'Last Updated: November 1, 2025',
            ar: 'آخر تحديث: 1 نوفمبر 2025',
          ),
        ),
        PrivacySectionEntity(
          section: 'introduction',
          content: LocalizedTextEntity(
            en: 'Welcome to our app',
            ar: 'مرحباً بكم في تطبيقنا',
          ),
        ),
        PrivacySectionEntity(
          section: 'information_collection',
          title: LocalizedTextEntity(
            en: 'Information We Collect',
            ar: 'المعلومات التي نجمعها',
          ),
          subSections: [
            SubSectionEntity(
              type: 'paragraph',
              title: LocalizedTextEntity(
                en: 'Personal Data',
                ar: 'البيانات الشخصية',
              ),
              content: LocalizedTextEntity(
                en: 'We collect your personal data',
                ar: 'نحن نجمع بياناتك الشخصية',
              ),
            ),
          ],
        ),
      ],
    );

    expectedSuccessResult = SuccessResult<PrivacyPolicyEntity>(privacyPolicyEntity);
    expectedFailureResult = FailedResult<PrivacyPolicyEntity>('Failed to load privacy policy');

    provideDummy<Result<PrivacyPolicyEntity>>(expectedSuccessResult);
    provideDummy<Result<PrivacyPolicyEntity>>(expectedFailureResult);
  });

  setUp(() {
    privacyPolicyCubit = PrivacyPolicyCubit(mockJsonContentUseCase);
  });

  group('PrivacyPolicyCubit initialization', () {
    test('initial state should have initial status', () {
      expect(privacyPolicyCubit.state.privacyPolicyState.isInitial, true);
    });
  });

  group('LoadPrivacyPolicyIntent', () {
    blocTest<PrivacyPolicyCubit, PrivacyPolicyState>(
      'emits [loading, success] when loading privacy policy is successful',
      build: () {
        when(mockJsonContentUseCase.callPrivacy())
            .thenAnswer((_) async => expectedSuccessResult);
        return privacyPolicyCubit;
      },
      act: (cubit) => cubit.doIntent( LoadPrivacyPolicyIntent()),
      expect: () => [
        isA<PrivacyPolicyState>().having(
          (state) => state.privacyPolicyState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<PrivacyPolicyState>()
            .having(
              (state) => state.privacyPolicyState.isSuccess,
              'isSuccess',
              equals(true),
            )
            .having(
              (state) => state.privacyPolicyState.data?.sections.length,
              'sections length',
              equals(4),
            )
            .having(
              (state) => state.privacyPolicyState.data?.sections[0].section,
              'first section',
              equals('title'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callPrivacy()).called(1);
      },
    );

    blocTest<PrivacyPolicyCubit, PrivacyPolicyState>(
      'emits [loading, failure] when loading privacy policy fails',
      build: () {
        when(mockJsonContentUseCase.callPrivacy())
            .thenAnswer((_) async => expectedFailureResult);
        return privacyPolicyCubit;
      },
      act: (cubit) => cubit.doIntent( LoadPrivacyPolicyIntent()),
      expect: () => [
        isA<PrivacyPolicyState>().having(
          (state) => state.privacyPolicyState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<PrivacyPolicyState>()
            .having(
              (state) => state.privacyPolicyState.isFailure,
              'isFailure',
              equals(true),
            )
            .having(
              (state) => state.privacyPolicyState.error is ResponseException
                  ? (state.privacyPolicyState.error as ResponseException).message
                  : null,
              'error message',
              equals('Failed to load privacy policy'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callPrivacy()).called(1);
      },
    );

    blocTest<PrivacyPolicyCubit, PrivacyPolicyState>(
      'emits failure with custom error message when file not found',
      build: () {
        when(mockJsonContentUseCase.callPrivacy()).thenAnswer(
          (_) async => FailedResult<PrivacyPolicyEntity>('Privacy policy file not found'),
        );
        return privacyPolicyCubit;
      },
      act: (cubit) => cubit.doIntent( LoadPrivacyPolicyIntent()),
      expect: () => [
        isA<PrivacyPolicyState>().having(
          (state) => state.privacyPolicyState.isLoading,
          'isLoading',
          equals(true),
        ),
        isA<PrivacyPolicyState>()
            .having(
              (state) => state.privacyPolicyState.isFailure,
              'isFailure',
              equals(true),
            )
            .having(
              (state) => state.privacyPolicyState.error is ResponseException
                  ? (state.privacyPolicyState.error as ResponseException).message
                  : null,
              'error message',
              equals('Privacy policy file not found'),
            ),
      ],
      verify: (cubit) {
        verify(mockJsonContentUseCase.callPrivacy()).called(1);
      },
    );
  });

  group('PrivacyPolicyCubit state verification', () {
    blocTest<PrivacyPolicyCubit, PrivacyPolicyState>(
      'verify privacy policy data structure after successful load',
      build: () {
        when(mockJsonContentUseCase.callPrivacy())
            .thenAnswer((_) async => expectedSuccessResult);
        return privacyPolicyCubit;
      },
      act: (cubit) => cubit.doIntent( LoadPrivacyPolicyIntent()),
      skip: 1, // for the loading state.
      verify: (cubit) {
        final state = cubit.state;
        expect(state.privacyPolicyState.isSuccess, true);
        expect(state.privacyPolicyState.data, isNotNull);
        
        final sections = state.privacyPolicyState.data!.sections;
        expect(sections.length, equals(4));
        
        // Verify title section
        final title = sections[0];
        expect(title.section, equals('title'));
        expect(title.content, isA<LocalizedTextEntity>());
        
        // Verify last updated section
        final lastUpdated = sections[1];
        expect(lastUpdated.section, equals('last_updated'));
        
        // Verify introduction section
        final introduction = sections[2];
        expect(introduction.section, equals('introduction'));
        
        // Verify section with subsections
        final infoCollection = sections[3];
        expect(infoCollection.section, equals('information_collection'));
        expect(infoCollection.subSections?.length, equals(1));
        expect(infoCollection.subSections?[0].type, equals('paragraph'));
      },
    );
  });

}
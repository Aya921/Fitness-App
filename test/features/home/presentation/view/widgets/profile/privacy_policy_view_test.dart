import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/help_content_entity.dart';
import 'package:fitness/features/home/domain/entities/json_content_entity/privacy_content_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/privacy_policy_view.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'privacy_policy_view_test.mocks.dart';

@GenerateMocks([PrivacyPolicyCubit, AppLanguageConfig])
void main() {
  late MockPrivacyPolicyCubit mockPrivacyPolicyCubit;
  late MockAppLanguageConfig mockAppLanguageConfig;
  final getItInstance = GetIt.instance;

  setUp(() {
    mockPrivacyPolicyCubit = MockPrivacyPolicyCubit();
    mockAppLanguageConfig = MockAppLanguageConfig();

    when(
      mockPrivacyPolicyCubit.stream,
    ).thenAnswer((_) => const Stream<PrivacyPolicyState>.empty());

    when(mockAppLanguageConfig.isEn()).thenReturn(true);
    when(mockAppLanguageConfig.selectedLocal).thenReturn('en');
    when(mockAppLanguageConfig.changeLocal(any)).thenAnswer((_) async {});

    getItInstance.registerFactory<PrivacyPolicyCubit>(
          () => mockPrivacyPolicyCubit,
    );
    getItInstance.registerFactory<AppLanguageConfig>(
          () => mockAppLanguageConfig,
    );
  });

  tearDown(getItInstance.reset);

  Widget prepareWidget() {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<PrivacyPolicyCubit>(
          create: (context) => mockPrivacyPolicyCubit,
          child: const PrivacyPolicyView(),
        ),
      ),
    );
  }

  const fakePrivacyPolicyEntityComplete = PrivacyPolicyEntity(
    sections: [
      PrivacySectionEntity(
        section: "title",
        content: LocalizedTextEntity(
          en: "Privacy Policy",
          ar: "سياسة الخصوصية",
        ),
      ),
      PrivacySectionEntity(
        section: "last_updated",
        content: LocalizedTextEntity(
          en: "Last Updated: November 2024",
          ar: "آخر تحديث: نوفمبر 2024",
        ),
      ),
      PrivacySectionEntity(
        section: "introduction",
        title: LocalizedTextEntity(
          en: "Introduction",
          ar: "المقدمة",
        ),
        content: LocalizedTextEntity(
          en:
          "We value your privacy and are committed to protecting your personal data.",
          ar: "نحن نقدر خصوصيتك وملتزمون بحماية بياناتك الشخصية.",
        ),
      ),
      PrivacySectionEntity(
        section: "data_collection",
        title: LocalizedTextEntity(
          en: "Data Collection",
          ar: "جمع البيانات",
        ),
        content: LocalizedTextEntity(
          en:
          "We collect various types of information to provide better services.",
          ar: "نقوم بجمع أنواع مختلفة من المعلومات لتقديم خدمات أفضل.",
        ),
        subSections: [
          SubSectionEntity(
            title: LocalizedTextEntity(
              en: "Personal Information",
              ar: "المعلومات الشخصية",
            ),
            content: LocalizedTextEntity(
              en: "Name, email, and contact details.",
              ar: "الاسم والبريد الإلكتروني وتفاصيل الاتصال.",
            ),
          ),
          SubSectionEntity(
            title: LocalizedTextEntity(
              en: "Usage Data",
              ar: "بيانات الاستخدام",
            ),
            content: LocalizedTextEntity(
              en: "App usage patterns and preferences.",
              ar: "أنماط استخدام التطبيق والتفضيلات.",
            ),
          ),
        ],
      ),
    ],
  );

  group('PrivacyPolicyView Widget Tests', () {
    testWidgets('should verify structure', (WidgetTester tester) async {
      when(
        mockPrivacyPolicyCubit.state,
      ).thenReturn(
        const PrivacyPolicyState(privacyPolicyState: StateStatus.loading()),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(HomeBackground), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(
        find.byWidgetPredicate((widget) => widget is BlocConsumer),
        findsOneWidget,
      );
    });

    testWidgets('HomeBackground should have correct properties', (
        WidgetTester tester,
        ) async {
      when(
        mockPrivacyPolicyCubit.state,
      ).thenReturn(
        const PrivacyPolicyState(privacyPolicyState: StateStatus.loading()),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      final homeBackground = tester.widget<HomeBackground>(
        find.byType(HomeBackground),
      );
      expect(homeBackground.image, equals(AssetsManager.homeBackground));
      expect(homeBackground.alpha, equals(.12));
    });

    testWidgets('should display loading indicator when state is loading', (
        WidgetTester tester,
        ) async {
      when(
        mockPrivacyPolicyCubit.state,
      ).thenReturn(
        const PrivacyPolicyState(privacyPolicyState: StateStatus.loading()),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is CircularProgressIndicator &&
              widget.color == AppColors.orange,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display loading indicator when state is initial', (
        WidgetTester tester,
        ) async {
      when(
        mockPrivacyPolicyCubit.state,
      ).thenReturn(
        const PrivacyPolicyState(privacyPolicyState: StateStatus.initial()),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is CircularProgressIndicator &&
              widget.color == AppColors.orange,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display error message when state is failure', (
        WidgetTester tester,
        ) async {
      const errorMessage = 'Failed to load privacy policy';
      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState: StateStatus.failure(
            ResponseException(message: errorMessage),
          ),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Center), findsWidgets);
      expect(find.byType(Column), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Icon &&
              widget.icon == Icons.error_outline &&
              widget.color == Colors.redAccent &&
              widget.size == 48,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.style?.color == Colors.redAccent &&
              widget.textAlign == TextAlign.center,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display content when state is success with data', (
        WidgetTester tester,
        ) async {
      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState:
          StateStatus.success(fakePrivacyPolicyEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CustomPopIcon), findsOneWidget);
      expect(find.text("Privacy Policy"), findsOneWidget);
      expect(find.text("Last Updated: November 2024"), findsOneWidget);
      expect(find.text("Introduction"), findsOneWidget);
      expect(find.text("Data Collection"), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // Header text
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == "Privacy Policy" &&
              widget.style ==
                  const TextStyle(
                    fontSize: 24,
                    color: AppColors.orange,
                    fontWeight: FontWeight.bold,
                  ) &&
              widget.textAlign == TextAlign.center,
        ),
        findsOneWidget,
      );

      // Last updated text
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == "Last Updated: November 2024" &&
              widget.style ==
                  const TextStyle(fontSize: 14, color: AppColors.gray) &&
              widget.textAlign == TextAlign.center,
        ),
        findsOneWidget,
      );

      // Section titles
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == "Introduction" &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == "Data Collection" &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should navigate back when CustomPopIcon is tapped', (
        WidgetTester tester,
        ) async {
      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState:
          StateStatus.success(fakePrivacyPolicyEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final customPopIcon = find.byType(CustomPopIcon);
      expect(customPopIcon, findsOneWidget);

      await tester.tap(customPopIcon);
      await tester.pumpAndSettle();

      expect(find.byType(PrivacyPolicyView), findsNothing);
    });

    testWidgets('should display section content correctly', (
        WidgetTester tester,
        ) async {
      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState:
          StateStatus.success(fakePrivacyPolicyEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(
        find.text(
          'We value your privacy and are committed to protecting your personal data.',
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          'We collect various types of information to provide better services.',
        ),
        findsOneWidget,
      );

      // Content text styling
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data ==
                  'We value your privacy and are committed to protecting your personal data.' &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should display subsections correctly', (
        WidgetTester tester,
        ) async {
      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState:
          StateStatus.success(fakePrivacyPolicyEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('Personal Information'), findsOneWidget);
      expect(find.text('Usage Data'), findsOneWidget);
      expect(find.text('Name, email, and contact details.'), findsOneWidget);
      expect(
        find.text('App usage patterns and preferences.'),
        findsOneWidget,
      );

      // Subsection title styling
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == 'Personal Information' &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
        ),
        findsOneWidget,
      );

      // Subsection content styling
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == 'Name, email, and contact details.' &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.gray,
                    fontSize: 14,
                    height: 1.5,
                  ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should have correct text styles for section titles', (
        WidgetTester tester,
        ) async {
      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState:
          StateStatus.success(fakePrivacyPolicyEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final introductionTitle = tester.widget<Text>(
        find.text('Introduction'),
      );
      expect(introductionTitle.style?.color, AppColors.orange);
      expect(introductionTitle.style?.fontSize, 18);
      expect(introductionTitle.style?.fontWeight, FontWeight.bold);

      final dataCollectionTitle = tester.widget<Text>(
        find.text('Data Collection'),
      );
      expect(dataCollectionTitle.style?.color, AppColors.orange);
      expect(dataCollectionTitle.style?.fontSize, 18);
      expect(dataCollectionTitle.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should display last updated only when not empty', (
        WidgetTester tester,
        ) async {
      const entityWithoutLastUpdated = PrivacyPolicyEntity(
        sections: [
          PrivacySectionEntity(
            section: "title",
            content: LocalizedTextEntity(
              en: "Privacy Policy",
              ar: "سياسة الخصوصية",
            ),
          ),
          PrivacySectionEntity(
            section: "last_updated",
            content: LocalizedTextEntity(en: "", ar: ""),
          ),
        ],
      );

      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState: StateStatus.success(entityWithoutLastUpdated),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // Last updated should not appear since it's empty
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Privacy Policy'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.style?.color == AppColors.gray &&
              widget.style?.fontSize == 14 &&
              widget.textAlign == TextAlign.center,
        ),
        findsNothing,
      );
    });

    testWidgets('should skip title and last_updated in ListView', (
        WidgetTester tester,
        ) async {
      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState:
          StateStatus.success(fakePrivacyPolicyEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // Verify that title and last_updated sections return SizedBox.shrink
      // The ListView has 4 sections, but only 2 should be visible (Introduction, Data Collection)
      expect(find.text('Introduction'), findsOneWidget);
      expect(find.text('Data Collection'), findsOneWidget);
    });

    testWidgets('should handle empty content', (
        WidgetTester tester,
        ) async {
      const entityWithEmptyContent = PrivacyPolicyEntity(
        sections: [
          PrivacySectionEntity(
            section: "title",
            content: LocalizedTextEntity(
              en: "Privacy Policy",
              ar: "سياسة الخصوصية",
            ),
          ),
          PrivacySectionEntity(
            section: "empty_section",
            title: LocalizedTextEntity(
              en: "Empty Section",
              ar: "قسم فارغ",
            ),
            content: LocalizedTextEntity(en: "", ar: ""),
          ),
        ],
      );

      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState: StateStatus.success(entityWithEmptyContent),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('Privacy Policy'), findsOneWidget);
      expect(find.text('Empty Section'), findsOneWidget);
      // Should not crash with empty content
    });

    testWidgets('should display multiple subsections correctly', (
        WidgetTester tester,
        ) async {
      when(mockPrivacyPolicyCubit.state).thenReturn(
        const PrivacyPolicyState(
          privacyPolicyState:
          StateStatus.success(fakePrivacyPolicyEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // Verify both subsections are displayed
      expect(find.text('Personal Information'), findsOneWidget);
      expect(find.text('Usage Data'), findsOneWidget);

      // Verify subsection structure with padding
      final subsections = tester.widgetList<Padding>(
        find.byWidgetPredicate(
              (widget) =>
          widget is Padding &&
              widget.padding == const EdgeInsets.only(left: 16.0, top: 12.0),
        ),
      );
      expect(subsections.length, greaterThanOrEqualTo(2));
    });
  });
}
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
import 'package:fitness/features/home/presentation/view/widgets/profile/help_view.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'help_view_test.mocks.dart';

@GenerateMocks([HelpCubit, AppLanguageConfig])
void main() {
  late MockHelpCubit mockHelpCubit;
  late MockAppLanguageConfig mockAppLanguageConfig;
  final getItInstance = GetIt.instance;

  setUp(() {
    mockHelpCubit = MockHelpCubit();
    mockAppLanguageConfig = MockAppLanguageConfig();

    when(
      mockHelpCubit.stream,
    ).thenAnswer((_) => const Stream<HelpState>.empty());

    when(mockAppLanguageConfig.isEn()).thenReturn(true);
    when(mockAppLanguageConfig.selectedLocal).thenReturn('en');
    when(mockAppLanguageConfig.changeLocal(any)).thenAnswer((_) async {});

    getItInstance.registerFactory<HelpCubit>(() => mockHelpCubit);
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
        home: BlocProvider<HelpCubit>(
          create: (context) => mockHelpCubit,
          child: const HelpView(),
        ),
      ),
    );
  }

  const fakeHelpContentEntityComplete = HelpContentEntity(
    sections: [
      HelpSectionEntity(
        section: "page_title",
        content: LocalizedTextEntity(
          en: "Help & Support",
          ar: "المساعدة والدعم",
        ),
      ),
      HelpSectionEntity(
        section: "page_subtitle",
        content: LocalizedTextEntity(
          en: "We're here to help",
          ar: "نحن هنا للمساعدة",
        ),
      ),
      HelpSectionEntity(
        section: "contact_us",
        title: LocalizedTextEntity(en: "Get in Touch", ar: "تواصل معنا"),
        contactMethods: [
          ContactMethodEntity(
            id: "contact_001",
            method: LocalizedTextEntity(
              en: "Email Support",
              ar: "الدعم عبر البريد الإلكتروني",
            ),
            details: LocalizedTextEntity(
              en: "Get a response within 24 hours.",
              ar: "احصل على رد خلال 24 ساعة.",
            ),
            value: "support@apexfitness.com",
          ),
          ContactMethodEntity(
            id: "contact_002",
            method: LocalizedTextEntity(
              en: "Phone Support",
              ar: "الدعم الهاتفي",
            ),
            details: LocalizedTextEntity(
              en: "Call us during business hours.",
              ar: "اتصل بنا خلال ساعات العمل.",
            ),
            value: "+1-800-123-4567",
          ),
        ],
      ),
      HelpSectionEntity(
        section: "faq",
        title: LocalizedTextEntity(en: "FAQ", ar: "الأسئلة الشائعة"),
        faqItems: [
          FaqItemEntity(
            id: "faq_001",
            question: LocalizedTextEntity(
              en: "How do I reset my password?",
              ar: "كيف يمكنني إعادة تعيين كلمة المرور؟",
            ),
            answer: LocalizedTextEntity(
              en: "Go to settings and click forgot password",
              ar: "انتقل إلى الإعدادات وانقر على نسيت كلمة المرور",
            ),
          ),
        ],
      ),
    ],
  );

  group('HelpView Widget Tests', () {
    testWidgets('should verify structure', (WidgetTester tester) async {
      when(
        mockHelpCubit.state,
      ).thenReturn(const HelpState(helpContentState: StateStatus.loading()));

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
        mockHelpCubit.state,
      ).thenReturn(const HelpState(helpContentState: StateStatus.loading()));

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
        mockHelpCubit.state,
      ).thenReturn(const HelpState(helpContentState: StateStatus.loading()));

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
        mockHelpCubit.state,
      ).thenReturn(const HelpState(helpContentState: StateStatus.initial()));

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
      const errorMessage = 'Failed to load help content';
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.failure(
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
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(fakeHelpContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CustomPopIcon), findsOneWidget);
      expect(find.text("Help & Support"), findsOneWidget);
      expect(find.text("We're here to help"), findsOneWidget);
      expect(find.text("Get in Touch"), findsOneWidget);
      expect(find.text("FAQ"), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      //header text
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == "Help & Support" &&
              widget.style ==
                  const TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ) &&
              widget.textAlign == TextAlign.center,
        ),
        findsOneWidget,
      );

      //subtitle
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == "We're here to help" &&
              widget.style ==
                  const TextStyle(fontSize: 16, color: AppColors.gray) &&
              widget.textAlign == TextAlign.center,
        ),
        findsOneWidget,
      );

      // Scrollable Content
      //content
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == "Get in Touch" &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        findsOneWidget,
      );

      //faq
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == "FAQ" &&
              widget.style ==
                  const TextStyle(
                    color: AppColors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should navigate back when CustomPopIcon is tapped', (
      WidgetTester tester,
    ) async {
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(fakeHelpContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final customPopIcon = find.byType(CustomPopIcon);
      expect(customPopIcon, findsOneWidget);

      await tester.tap(customPopIcon);
      await tester.pumpAndSettle();

      expect(find.byType(HelpView), findsNothing);
    });

    testWidgets('should display contact section when available', (
      WidgetTester tester,
    ) async {
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(fakeHelpContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('Get in Touch'), findsOneWidget);
      expect(find.text('Email Support'), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_ios), findsNWidgets(2));

      //email or phone
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Icon &&
              widget.color == AppColors.orange &&
              widget.size == 24,
        ),
        findsWidgets,
      );

      //arrow_forward
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Icon &&
              widget.color == AppColors.orange &&
              widget.size == 18,
        ),
        findsNWidgets(2),
      );
    });

    testWidgets('should display email contact details correctly', (
      WidgetTester tester,
    ) async {
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(fakeHelpContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('Get a response within 24 hours.'), findsOneWidget);
      expect(find.text('support@apexfitness.com'), findsOneWidget);
    });

    testWidgets('should display phone contact details correctly', (
      WidgetTester tester,
    ) async {
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(fakeHelpContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('Call us during business hours.'), findsOneWidget);
      expect(find.text('+1-800-123-4567'), findsOneWidget);
    });

    testWidgets('should display FAQ section when available', (
      WidgetTester tester,
    ) async {
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(fakeHelpContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.text('How do I reset my password?'), findsOneWidget);
      expect(find.byType(ExpansionTile), findsNWidgets(1));

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Theme &&
              widget.data == ThemeData(dividerColor: Colors.transparent) &&
              widget.child is ExpansionTile,
        ),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is ExpansionTile &&
              widget.iconColor == AppColors.orange &&
              widget.collapsedIconColor == AppColors.orange,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should expand FAQ item when tapped', (
      WidgetTester tester,
    ) async {
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(fakeHelpContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // Before tapping, answer should not be visible
      expect(
        find.text('Go to settings and click forgot password'),
        findsNothing,
      );

      // Find and tap the first FAQ item
      final firstExpansionTile = find.byType(ExpansionTile).first;
      await tester.tap(firstExpansionTile);
      await tester.pumpAndSettle();

      // After tapping, answer should be visible
      expect(
        find.text('Go to settings and click forgot password'),
        findsOneWidget,
      );
    });

    testWidgets('should have correct text styles for section titles', (
      WidgetTester tester,
    ) async {
      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(fakeHelpContentEntityComplete),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      // Find section title texts with specific styling
      final contactTitleWidget = tester.widget<Text>(find.text('Get in Touch'));
      expect(contactTitleWidget.style?.color, AppColors.orange);
      expect(contactTitleWidget.style?.fontSize, 20);
      expect(contactTitleWidget.style?.fontWeight, FontWeight.bold);

      final faqTitleWidget = tester.widget<Text>(find.text('FAQ'));
      expect(faqTitleWidget.style?.color, AppColors.orange);
      expect(faqTitleWidget.style?.fontSize, 20);
      expect(faqTitleWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should display subtitle only when not empty', (
      WidgetTester tester,
    ) async {
      const entityWithoutSubtitle = HelpContentEntity(
        sections: [
          HelpSectionEntity(
            section: "page_title",
            content: LocalizedTextEntity(
              en: "Help & Support",
              ar: "المساعدة والدعم",
            ),
          ),
          HelpSectionEntity(
            section: "page_subtitle",
            content: LocalizedTextEntity(en: "", ar: ""),
          ),
        ],
      );

      when(mockHelpCubit.state).thenReturn(
        const HelpState(
          helpContentState: StateStatus.success(entityWithoutSubtitle),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Help & Support'), findsOneWidget);
      // Subtitle should not appear since it's empty
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.style?.color == AppColors.gray &&
              widget.style?.fontSize == 16,
        ),
        findsNothing,
      );
    });
  });
}

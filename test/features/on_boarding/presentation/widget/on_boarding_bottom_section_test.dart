import 'dart:async';

import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_fitness_button.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_state.dart';
import 'package:fitness/features/on_boarding/presentation/widget/discretion_section.dart';
import 'package:fitness/features/on_boarding/presentation/widget/on_boarding_bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'on_boarding_bottom_section_test.mocks.dart';

@GenerateMocks([OnBoardingCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOnBoardingCubit mockCubit;
  late PageController mockPageController;

  final testImages = [
    AssetsManager.onBoardingOne,
    AssetsManager.onBoardingTwo,
    AssetsManager.onBoardingThree,
  ];

  final testTitles = [
    Constants.titleOnBoarding,
    Constants.titleTwoBoarding,
    Constants.titleThreeBoarding,
  ];

  setUp(() {
    mockCubit = MockOnBoardingCubit();
    mockPageController = PageController();
    getIt.registerFactory<OnBoardingCubit>(() => mockCubit);

    provideDummy<OnBoardingState>(const OnBoardingState());
    when(mockCubit.state).thenReturn(const OnBoardingState());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.fromIterable([const OnBoardingState()]));
    when(mockCubit.controller()).thenReturn(mockPageController);
  });

  Widget prepareWidget({
    List<String>? images,
    List<String>? titles,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<OnBoardingCubit>.value(
        value: mockCubit,
        child: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: OnBoardingBottomSection(
              images: images ?? testImages,
              titles: titles ?? testTitles,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('verify OnBoardingBottomSection structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(Column), findsAtLeast(1));
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(Container), findsAtLeast(1));
    expect(find.byType(Text), findsAtLeast(1));
    expect(find.byType(DiscretionSection), findsOneWidget);
    expect(find.byType(CustomElevatedButton), findsAtLeast(1));
  });

  testWidgets('verify first page shows only Next button', (tester) async {
    when(mockCubit.state).thenReturn(const OnBoardingState(pageIndex: 0));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const OnBoardingState(pageIndex: 0)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(find.text(l10n.next), findsOneWidget);
    expect(find.text(l10n.back), findsNothing);
    expect(find.byType(SmoothPageIndicator), findsNothing);
  });

  testWidgets('verify second page shows Back, indicator, and Next',
      (tester) async {
    when(mockCubit.state).thenReturn(const OnBoardingState(pageIndex: 1));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const OnBoardingState(pageIndex: 1)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(find.text(l10n.back), findsOneWidget);
    expect(find.text(l10n.next), findsOneWidget);
    expect(find.byType(SmoothPageIndicator), findsOneWidget);
    expect(find.byType(Row), findsAtLeast(1));
  });

  testWidgets('verify last page shows "Do It" button', (tester) async {
    when(mockCubit.state).thenReturn(const OnBoardingState(pageIndex: 2));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const OnBoardingState(pageIndex: 2)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(find.text(l10n.doIt), findsOneWidget);
    expect(find.text(l10n.next), findsNothing);
  });

  testWidgets('verify tapping Next button triggers NextPageIntent',
      (tester) async {
    when(mockCubit.state).thenReturn(const OnBoardingState(pageIndex: 0));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const OnBoardingState(pageIndex: 0)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    await tester.tap(find.text(l10n.next));
    await tester.pump();

    verify(mockCubit.intent(any)).called(1);
  });

  tearDown(() async {
    mockPageController.dispose();
    await getIt.reset();
  });
}
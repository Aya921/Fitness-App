import 'dart:async';

import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_state.dart';
import 'package:fitness/features/on_boarding/presentation/widget/discretion_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'discretion_section_test.mocks.dart';

@GenerateMocks([OnBoardingCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOnBoardingCubit mockCubit;

  setUp(() {
    mockCubit = MockOnBoardingCubit();
    getIt.registerFactory<OnBoardingCubit>(() => mockCubit);

    provideDummy<OnBoardingState>(const OnBoardingState());
    when(mockCubit.state).thenReturn(const OnBoardingState());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.fromIterable([const OnBoardingState()]));
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<OnBoardingCubit>.value(
        value: mockCubit,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: DiscretionSection(),
          ),
        ),
      ),
    );
  }

  testWidgets('verify DiscretionSection structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(BlocBuilder<OnBoardingCubit, OnBoardingState>), findsOneWidget);
    expect(find.byType(Padding), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('verify Text has correct style', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final textWidget = tester.widget<Text>(find.byType(Text));
    final textStyle = textWidget.style!;

    expect(textStyle.color, AppColors.shadeWhite);
    expect(textStyle.fontSize, FontSize.s16);
    expect(textStyle.fontWeight, FontWeight.normal); // Regular
    expect(textWidget.textAlign, TextAlign.center);
  });

  testWidgets('verify first page displays correct description', (tester) async {
    when(mockCubit.state).thenReturn(const OnBoardingState(pageIndex: 0));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const OnBoardingState(pageIndex: 0)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.onBoardingdescriptionOne), findsOneWidget);
  });

  testWidgets('verify second page displays correct description', (tester) async {
    when(mockCubit.state).thenReturn(const OnBoardingState(pageIndex: 1));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const OnBoardingState(pageIndex: 1)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.onBoardingdescriptionTwo), findsOneWidget);
  });

  testWidgets('verify third page displays correct description', (tester) async {
    when(mockCubit.state).thenReturn(const OnBoardingState(pageIndex: 2));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const OnBoardingState(pageIndex: 2)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.onBoardingdescriptionThree), findsOneWidget);
  });
  tearDown(() async {
    await getIt.reset();
  });
}
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_loading_circle_progress_indictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget prepareWidget({required int index}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: Center(
            child: CustomLoadingCircleProgressIndictor(index: index),
          ),
        ),
      ),
    );
  }

  testWidgets('verify CustomLoadingCircleProgressIndictor structure',
      (tester) async {
    await tester.pumpWidget(prepareWidget(index: 1));
    await tester.pumpAndSettle();

    expect(find.byType(CircularPercentIndicator), findsOneWidget);
    expect(find.text('1/6'), findsOneWidget);
  });

  testWidgets('verify CircularPercentIndicator has correct radius',
      (tester) async {
    await tester.pumpWidget(prepareWidget(index: 1));
    await tester.pumpAndSettle();

    final context = tester.element(
      find.byType(CustomLoadingCircleProgressIndictor),
    );
    final indicator = tester.widget<CircularPercentIndicator>(
      find.byType(CircularPercentIndicator),
    );

    expect(indicator.radius, context.setMinSize(24));
  });

  testWidgets('verify CircularPercentIndicator has transparent background',
      (tester) async {
    await tester.pumpWidget(prepareWidget(index: 1));
    await tester.pumpAndSettle();

    final indicator = tester.widget<CircularPercentIndicator>(
      find.byType(CircularPercentIndicator),
    );

    expect(indicator.backgroundColor, Colors.transparent);
  });

  testWidgets('verify CircularPercentIndicator has correct background width',
      (tester) async {
    await tester.pumpWidget(prepareWidget(index: 1));
    await tester.pumpAndSettle();

    final context = tester.element(
      find.byType(CustomLoadingCircleProgressIndictor),
    );
    final indicator = tester.widget<CircularPercentIndicator>(
      find.byType(CircularPercentIndicator),
    );

    expect(indicator.backgroundWidth, context.setWidth(5));
  });

  testWidgets('verify CircularPercentIndicator has correct line width',
      (tester) async {
    await tester.pumpWidget(prepareWidget(index: 1));
    await tester.pumpAndSettle();

    final context = tester.element(
      find.byType(CustomLoadingCircleProgressIndictor),
    );
    final indicator = tester.widget<CircularPercentIndicator>(
      find.byType(CircularPercentIndicator),
    );

    expect(indicator.lineWidth, context.setWidth(3));
  });

  testWidgets('verify CircularPercentIndicator has correct progress color',
      (tester) async {
    await tester.pumpWidget(prepareWidget(index: 1));
    await tester.pumpAndSettle();

    final indicator = tester.widget<CircularPercentIndicator>(
      find.byType(CircularPercentIndicator),
    );

    expect(indicator.progressColor, AppColors.orange[AppColors.baseColor]);
  });

  testWidgets('verify CircularPercentIndicator has another index than 1',
      (tester) async {
    await tester.pumpWidget(prepareWidget(index: 2));
    await tester.pumpAndSettle();

    final indicator = tester.widget<CircularPercentIndicator>(
      find.byType(CircularPercentIndicator),
    );

     expect(indicator.percent, 2 / 6);
     expect(find.text("2/6"),findsOneWidget);
  });
}
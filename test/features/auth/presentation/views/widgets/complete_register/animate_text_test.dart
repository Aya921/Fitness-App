import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/auth/api/models/register/text_model.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

void main() {
    TestWidgetsFlutterBinding.ensureInitialized();

    Widget prepareWidget({required TextModel textModel}) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: AnimateText(textModel: textModel)),
        ),
      );
    }

    testWidgets('verify AnimateText structure', (tester) async {
      const textModel = TextModel(
        title: 'Test Title',
        subTitle: 'Test Subtitle',
      );

      await tester.pumpWidget(prepareWidget(textModel: textModel));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 900));

      expect(find.byType(FadeInLeft), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(SizedBox), findsOneWidget);
    });
    testWidgets('verify FadeInLeft has correct duration and delay',
      (tester) async {
    const textModel = TextModel(
      title: 'Test Title',
      subTitle: 'Test Subtitle',
    );

    await tester.pumpWidget(prepareWidget(textModel: textModel));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));

    final fadeInLeft = tester.widget<FadeInLeft>(find.byType(FadeInLeft));

    expect(fadeInLeft.duration, const Duration(milliseconds: 800));
    expect(fadeInLeft.delay, const Duration(milliseconds: 800));
  });
  }


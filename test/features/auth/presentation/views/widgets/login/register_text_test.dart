import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/register_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeTestableWidget(Widget child) {
  return SizeProvider(
    baseSize: const Size(375, 812),
    height: 812,
    width: 375,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('RegisterText Widget Tests', () {
    testWidgets('renders correctly with GestureDetector and RichText', (
      tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(const RegisterText()));
      expect(find.byKey(const Key(WidgetKey.registerTextKey)), findsOneWidget);
      expect(find.byType(RichText), findsOneWidget);
    });

    testWidgets('text styles are applied correctly', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const RegisterText()));

      final richText = tester.widget<RichText>(find.byType(RichText));
      final textSpan = richText.text as TextSpan;

      final firstSpan = textSpan.children![0] as TextSpan;
      expect(firstSpan.style?.color, isNotNull);
      expect(firstSpan.style?.fontSize, isNotNull);

      final secondSpan = textSpan.children![1] as TextSpan;
      expect(secondSpan.style?.decoration, TextDecoration.underline);
      expect(secondSpan.style?.color, isNotNull);
    });
  });
}

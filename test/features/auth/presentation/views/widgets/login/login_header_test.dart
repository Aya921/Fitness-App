import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/login_header.dart';
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
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('LoginHeader Widget', () {
    testWidgets('renders "Hey There" and "Welcome Back" texts', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const LoginHeader()));

      expect(find.byType(Text), findsNWidgets(2));
    });

    testWidgets('uses a Column with start alignment', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const LoginHeader()));

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets('texts have white color', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const LoginHeader()));

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      for (final text in textWidgets) {
        expect(text.style?.color, AppColors.white);
      }
    });
  });
}

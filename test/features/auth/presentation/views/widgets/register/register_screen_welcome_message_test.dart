import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_welcome_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget prepareWidget() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(body: RegisterScreenWelcomeMessage()),
      ),
    );
  }

  testWidgets('verify RegisterScreenWelcomeMessage structure', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final context = tester.element(find.byType(RegisterScreenWelcomeMessage));

    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(FittedBox), findsNWidgets(2));
    expect(find.text(l10n.heyThere), findsOneWidget);
    expect(find.text(l10n.createAnAccount), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox && widget.height == context.setHight(8),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.length == 3 &&
            widget.children[0] is FittedBox &&
            widget.children[1] is SizedBox &&
            widget.children[2] is FittedBox,
      ),
      findsOneWidget,
    );
  });
}

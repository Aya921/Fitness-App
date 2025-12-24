import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_or_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget prepareWidget() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(body: RegisterScreenOrRow()),
      ),
    );
  }

  testWidgets('verify RegisterScreenOrRow structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(RegisterScreenOrRow));
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(find.byType(Divider), findsNWidgets(2));
    expect(find.byType(Text), findsOneWidget);

    expect(find.text(l10n.or), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.children.length == 3 &&
            widget.children[0] is Expanded &&
            widget.children[1] is Text &&
            widget.children[2] is Expanded,
      ),
      findsOneWidget,
    );

    final dividers = tester.widgetList<Divider>(find.byType(Divider)).toList();
    expect(dividers[0].thickness, 1);
    expect(dividers[1].thickness, 1);

    expect(dividers[0].color, equals(dividers[1].color));

    final textWidget = tester.widget<Text>(find.text(l10n.or));
    final textStyle = textWidget.style!;
    expect(textStyle.color, equals(dividers[0].color));
    expect(textStyle.fontSize, equals(context.setSp(FontSize.s12)));
  });
}

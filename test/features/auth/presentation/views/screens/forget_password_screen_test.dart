import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/presentation/views/screens/forget_password_screen.dart';
import 'package:fitness/features/auth/presentation/views/widgets/forget_pass_section.dart';
import 'package:fitness/features/auth/presentation/views/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test forget password screen structure ...', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: ForgetPasswordScreen(),
        ),
      ),
    );
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.byType(AppBackground), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Column), findsAtLeast(1));
    expect(find.byType(Logo), findsOneWidget);
    expect(find.byType(Spacer), findsNWidgets(3));
    expect(find.byType(TextSection), findsOneWidget);
    expect(find.byType(BlurContainer), findsOneWidget);
    expect(find.byType(Logo), findsOneWidget);
    expect(find.byType(ForgetPassSection), findsOneWidget);

    expect(find.text(l10n.enterYourEmail), findsOneWidget);
    expect(find.text(l10n.forgetPassword), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.mainAxisAlignment == MainAxisAlignment.center &&
            widget.children.length == 6 &&
            widget.children[0] is Logo &&
            widget.children[1] is Spacer &&
            widget.children[2] is TextSection &&
            widget.children[3] is BlurContainer &&
            widget.children[4] is Spacer &&
            widget.children[5] is Spacer,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && widget.child is Column,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is AppBackground && widget.child is SafeArea,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is BlurContainer && widget.blurChild is ForgetPassSection,
      ),
      findsOneWidget,
    );
  });
}

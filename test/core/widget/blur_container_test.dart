import 'dart:ui';

import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test blur contaier  structure', (
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
          child: Scaffold(body: BlurContainer(blurChild: Text("hi"))),
        ),
      ),
    );

    expect(find.byType(ClipRRect), findsAtLeastNWidgets(1));
    expect(find.byType(Container), findsAtLeastNWidgets(1));
    expect(find.byType(BackdropFilter), findsAtLeastNWidgets(1));
    expect(find.byType(Text), findsAtLeastNWidgets(1));

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is BackdropFilter &&
            widget.filter == ImageFilter.blur(sigmaX: 18, sigmaY: 18) &&
            widget.child is Text,
      ),
      findsOneWidget,
    );

    final context = tester.element(find.byType(Container));
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.padding ==
                EdgeInsets.symmetric(
                  vertical: context.setHight(25),
                  horizontal: context.setWidth(18),
                )&&widget.constraints!
                
                .maxWidth==double.infinity
                
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is ClipRRect &&
            widget.borderRadius ==BorderRadius.circular(context.setWidth(50))
               
                
      ),
      findsOneWidget,
    );
  });

  

}

import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/auth/presentation/views/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test text section when reverse is false  struture  ...', (
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
          child: Scaffold(
            body: TextSection(text1: "uuu", text2: "eee"),
          ),
        ),
      ),
    );

   
    expect(find.byType(Padding), findsAtLeastNWidgets(1));
    expect(find.byType(Column), findsAtLeastNWidgets(1));
    expect(find.byType(Text), findsAtLeastNWidgets(2));

    final context = tester.element(find.byType(Column));

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == "uuu" &&
            widget.style ==
                getRegularStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s18),
                ),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == "eee" &&
            widget.style ==
               getBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s24),
                  ),
      ),
      findsOneWidget,
    );
  });


  testWidgets('test text section when reverse is true  struture then it should reverse styles  ...', (
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
          child: Scaffold(
            body: TextSection(text1: "uuu", text2: "eee",reverseStyles: true,),
          ),
        ),
      ),
    );


    final context = tester.element(find.byType(Column));

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == "uuu" &&
            widget.style ==
               
                  getBoldStyle(
                    color: AppColors.white,
                    fontSize: context.setSp(FontSize.s24),
                  ),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == "eee" &&
            widget.style ==
               getRegularStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s18),
                ),
      ),
      findsOneWidget,
    );
  });




}

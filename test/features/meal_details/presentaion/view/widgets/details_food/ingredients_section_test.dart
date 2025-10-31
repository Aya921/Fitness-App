import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/ingredients_section.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/ingredients_section_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test IngredientsSection structure ...', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: IngredientsSection(ingredients: ["nn"], measures: ["100g"]),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(Padding), findsAtLeast(2));
    expect(find.byType(Column), findsAtLeast(1));
    expect(find.byType(Text), findsAtLeast(1));
    expect(find.byType(Container), findsAtLeast(1));
    expect(find.byType(ListView), findsAtLeast(1));
    expect(find.byType(IngredientsSectionDetails), findsAtLeast(1));

    final context = tester.element(find.byType(Container).first);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is ListView &&
            widget.padding ==
                EdgeInsets.symmetric(vertical: context.setHight(10)),
      ),
      findsAtLeast(1),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.child is ListView &&
            widget.constraints!.maxWidth == double.infinity &&
            widget.constraints!.maxHeight == context.setHight(150) &&
            widget.decoration ==
                BoxDecoration(
                  borderRadius: BorderRadius.circular(context.setWidth(25)),
                  color: const Color.fromARGB(184, 0, 0, 0),
                ),
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.length == 2 &&
            widget.children[0] is Padding &&
            widget.children[1] is Divider,
      ),
      findsAtLeast(1),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == context.loc.ingredients &&
            widget.style ==
                getSemiBoldStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s20),
                ),
      ),
      findsAtLeast(1),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding == EdgeInsets.all(context.setWidth(10)) &&
            widget.child is Text,
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding == EdgeInsets.all(context.setWidth(5)) &&
            widget.child is Column,
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.length == 2 &&
            widget.children[0] is Padding &&
            widget.children[1] is Container &&
            widget.crossAxisAlignment == CrossAxisAlignment.start,
      ),
      findsAtLeast(1),
    );
  });
}

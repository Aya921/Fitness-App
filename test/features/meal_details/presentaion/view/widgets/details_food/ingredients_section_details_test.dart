import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/ingredients_section_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test IngredientsSectionDetails structure ...', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: IngredientsSectionDetails(
            ingredient: "water",
            measure: "100g",
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(Padding), findsAtLeast(2));
    expect(find.byType(Column), findsAtLeast(1));
    expect(find.byType(Row), findsAtLeast(1));
    expect(find.byType(Divider), findsAtLeast(1));
    expect(find.byType(Text), findsAtLeast(2));

    final context = tester.element(find.byType(Column).first);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == "water" &&
            widget.style ==
                getBoldStyle(color: AppColors.white, fontSize: FontSize.s16),
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == "100g" &&
            widget.style == getBoldStyle(color: AppColors.orange),
      ),
      findsAtLeast(1),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Divider && widget.color == const Color(0xFF2D2D2D),
      ),
      findsAtLeast(1),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.mainAxisAlignment == MainAxisAlignment.spaceBetween &&
            widget.children.length == 2 &&
            widget.children[0] is Text &&
            widget.children[1] is Text,
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
            widget is Padding &&
            widget.padding ==
                EdgeInsets.symmetric(vertical: context.setHight(5)) &&
            widget.child is Row,
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding ==
                EdgeInsets.symmetric(horizontal: context.setWidth(15)) &&
            widget.child is Column,
      ),
      findsAtLeast(1),
    );
  });
}

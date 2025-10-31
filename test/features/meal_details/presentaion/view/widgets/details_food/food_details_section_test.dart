import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/food_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test FoodDetailsSection structure ...', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize:  Size(375, 812),
          height: 812,
          width: 375,
          child: FoodDetailsSection(tags: ["nn","bb"],),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(SizedBox), findsAtLeast(1));
    expect(find.byType(ListView), findsAtLeast(1));
    expect(find.byType(Container), findsAtLeast(1));
    expect(find.byType(Center), findsAtLeast(1));
    expect(find.byType(Text), findsAtLeast(1));


    final context = tester.element(find.byType(SizedBox).first);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.overflow == TextOverflow.ellipsis &&
            widget.data == "nn"&&widget.style== getRegularStyle(color: AppColors.orange), 
            
          
      ),
      findsAtLeast(1),
    );
   
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Center &&widget.child is Text
           
      ),
      findsAtLeast(1),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.child is Center &&
            widget.margin == EdgeInsets.only(right: context.setWidth(40)) &&
            widget.constraints!.maxHeight == context.setHight(44) &&
            widget.constraints!.maxWidth == context.setWidth(54)&& widget.decoration == BoxDecoration(
              border: Border.all(color: AppColors.white),
              borderRadius: BorderRadius.circular(context.setWidth(20)),
            ),
      ),
      findsAtLeast(1),
    );







    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is ListView &&
            widget.shrinkWrap == true && widget.scrollDirection == Axis.horizontal
           
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SizedBox &&
            widget.height ==  context.setHight(44)&&
            widget.child is ListView,
      ),
      findsAtLeast(1),
    );
   
   
  });
}

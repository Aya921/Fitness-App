import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/features/foods/presentaion/view/widgets/food_recommendation_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  Widget prepareWidget() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(body: FoodRecommendationTitle()),
      ),
    );
  }

  testWidgets("verfiy Structure for FoodRecommendationTitle", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    expect(find.byType(CustomPopIcon), findsOneWidget);
    expect(find.text("Food Recommendation"), findsOneWidget);
  });
}

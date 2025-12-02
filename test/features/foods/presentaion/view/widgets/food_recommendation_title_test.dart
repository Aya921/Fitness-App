import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/features/foods/presentaion/view/widgets/food_recommendation_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'food_recommendation_title_test.mocks.dart';
@GenerateMocks([AppLanguageConfig])
void main() {
  late MockAppLanguageConfig mockAppLanguageConfig;
  setUpAll(() {
    mockAppLanguageConfig = MockAppLanguageConfig();
    when(mockAppLanguageConfig.isEn()).thenReturn(true);
    getIt.registerFactory<AppLanguageConfig>(() => mockAppLanguageConfig);
  });
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

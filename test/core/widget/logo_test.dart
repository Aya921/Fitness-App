import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test logo structure', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: Logo()),
        ),
      ),
    );

    expect(find.byType(Center), findsAtLeastNWidgets(1));
    expect(find.byType(Image), findsAtLeastNWidgets(1));

    final context = tester.element(find.byType(Center));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Center && widget.child is Image,
      ),
      findsOneWidget,
    );
    final Image imageWidget = tester.widget(find.byType(Image));

    final AssetImage assetImage = imageWidget.image as AssetImage;

    expect(assetImage.assetName, AssetsManager.logo);

    expect(imageWidget.height, context.setHight(70));
  });
}

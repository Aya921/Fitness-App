import 'dart:ui';

import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test app background structure ...', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppBackground(child: Text("hi")),
      ),
    );
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.color == AppColors.black.withValues(alpha: 0.2),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is BackdropFilter &&
            widget.filter == ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Stack &&
            widget.children.length == 3 &&
            widget.children[0] is Image &&
            widget.children[1] is BackdropFilter &&
            widget.children[2] is Text,
      ),
      findsOneWidget,
    );

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    final Image imageWidget = tester.widget(imageFinder);
    final AssetImage assetImage = imageWidget.image as AssetImage;
    expect(assetImage.assetName, AssetsManager.backGroundImage);
  });
}

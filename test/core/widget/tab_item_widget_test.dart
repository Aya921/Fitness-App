import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/tab_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String testTitle = 'Workouts';

  Widget prepareWidget({
    required String title,
    bool isSelected = false,
    required Function() onTap,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: TabItemWidget(
            title: title,
            isSelected: isSelected,
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  testWidgets('Tab Item when isSelected = false', (WidgetTester tester) async {
    await tester.pumpWidget(
      prepareWidget(
        title: testTitle,
        isSelected: false,
        onTap: () {},
      ),
    );

    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final animatedDecoration =
    animatedContainer.decoration as BoxDecoration;

    expect(animatedDecoration.color, Colors.transparent);
  });

  testWidgets('Tab Item when isSelected = true', (WidgetTester tester) async {
    await tester.pumpWidget(
      prepareWidget(
        title: testTitle,
        isSelected: true,
        onTap: () {},
      ),
    );

    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final animatedDecoration =
    animatedContainer.decoration as BoxDecoration;

    expect(animatedDecoration.color, AppColors.orange[AppColors.baseColor]);
  });
  testWidgets("Tab Item when click on this container", (WidgetTester tester)async{
    await tester.pumpWidget(prepareWidget(title: testTitle, onTap: (){
    }));
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();
    expect(find.text(testTitle), findsOneWidget);
  });
}

import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_popular_training_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget prepareWidget() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: ExplorePopularTrainingListView(),
        ),
      ),
    );
  }

  group('ExplorePopularTrainingListView Tests', () {
    testWidgets('renders column structure correctly', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(Column), findsNWidgets(4));
      expect(find.byType(FittedBox), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('renders localized title text', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      expect(find.text(l10n.popularTrainingText), findsOneWidget);

      final textWidget = tester.widget<Text>(find.text(l10n.popularTrainingText));
      expect(textWidget.style!.fontFamily, 'BalooThambi2');
      expect(textWidget.style!.fontSize, FontSize.s16);
    });

    testWidgets('ListView is horizontal and has correct height', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);

      final listView = tester.widget<ListView>(listViewFinder);
      expect(listView.scrollDirection, Axis.horizontal);

      final sizedBoxFinder = find.byType(SizedBox).at(1);
      final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
      expect(sizedBox.height, isNonZero);
    });

    testWidgets('padding and spacing elements are present', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
     
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.first.height, isNonZero);
    });
  });
}

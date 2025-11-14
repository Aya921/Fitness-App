import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_categories_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ExploreCategoriesListView widget tests', () {
    Widget prepareWidget() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: ExploreCategoriesListView()),
        ),
      );
    }

    testWidgets('verify ExploreCategoriesListView structure', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

  
      expect(find.byType(Column), findsNWidgets(6));
      expect(find.byType(FittedBox), findsNWidgets(6));
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(5));

     
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.text(l10n.categoryHomeText), findsOneWidget);

 
      expect(find.text('Gym'), findsOneWidget);
      expect(find.text('Fitness'), findsOneWidget);
      expect(find.text('Yoga'), findsOneWidget);
      expect(find.text('Aerobics'), findsOneWidget);
      expect(find.text('Trainer'), findsOneWidget);
    });

    testWidgets('list view should contain 5 category items with separators', (
      tester,
    ) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);

      final listView = tester.widget<ListView>(listViewFinder);
      expect(listView.scrollDirection, Axis.horizontal);
      expect(listView.physics, isA<NeverScrollableScrollPhysics>());
      expect(listView.shrinkWrap, isTrue);
    });

    testWidgets('verify blur and container structure', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

    
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);

  
      final containerFinder = find.descendant(
        of: find.byType(ClipRRect),
        matching: find.byType(Container),
      );

      final container = tester.widget<Container>(containerFinder.first);
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
      expect(decoration.borderRadius, isNotNull);
      expect(decoration.boxShadow, isNotEmpty);
    });

    testWidgets('verify each category image asset is loaded correctly', (
      tester,
    ) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final imageFinders = find.byType(Image);
      expect(imageFinders, findsNWidgets(5));

      final imageWidgets = tester.widgetList<Image>(imageFinders).toList();
      expect(
        imageWidgets.map((e) => (e.image as AssetImage).assetName),
        containsAll([
          AssetsManager.gymCategory1,
          AssetsManager.gymCategory2,
          AssetsManager.gymCategory3,
          AssetsManager.gymCategory4,
          AssetsManager.gymCategory5,
        ]),
      );
    });

    testWidgets('each item has correct text and layout', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final itemColumns = tester
          .widgetList<Column>(find.byType(Column))
          .where(
            (column) => column.mainAxisAlignment == MainAxisAlignment.center,
          )
          .toList();

      expect(itemColumns.length, 5);

      final firstColumn = itemColumns.first;
      final children = firstColumn.children;

      expect(
        children.any((e) => e is Image),
        isFalse,
        reason: 'Item must contain Image',
      );
      expect(
        children.any((e) => e is SizedBox),
        isTrue,
        reason: 'Item must contain SizedBox',
      );
      expect(
        children.any((e) => e is FittedBox),
        isTrue,
        reason: 'Item must contain FittedBox',
      );
    });
  });
}

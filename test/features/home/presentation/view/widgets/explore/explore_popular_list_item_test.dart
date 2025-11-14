import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_popular_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget prepareWidget() {
    return const MaterialApp(
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: ExplorePopularListItem(),
        ),
      ),
    );
  }

  group('ExplorePopularListItem tests', () {
    testWidgets('verify structure', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(Padding), findsNWidgets(5));
      expect(find.byType(Stack), findsNWidgets(2));
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(BackdropFilter), findsNWidgets(2));
    });

    testWidgets('renders background container with correct image',
        (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final container = tester.widget<Container>(
        find.byWidgetPredicate(
          (w) =>
              w is Container &&
              w.decoration is BoxDecoration &&
              (w.decoration as BoxDecoration).image != null,
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      final image = decoration.image!;
      expect(image.image, isA<AssetImage>());
      expect((image.image as AssetImage).assetName,
          AssetsManager.popularTrainingImg);
    });

    testWidgets('renders title text and labels', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.text("Exercises That\nStrengthen Your Chest"),
          findsOneWidget);
      expect(find.text("24 Tasks"), findsOneWidget);
      expect(find.text("Beginner"), findsOneWidget);
    });

    testWidgets('title text has correct style', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final title = tester.widget<Text>(
        find.text("Exercises That\nStrengthen Your Chest"),
      );

      expect(title.style!.color, AppColors.white);
      expect(title.style!.fontFamily, "BalooThambi2");
      expect(title.style!.fontSize, FontSize.s14);
    });

    testWidgets('"Beginner" label has correct bold style', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final beginner = tester.widget<Text>(find.text("Beginner"));

      expect(beginner.style!.color, AppColors.orange);
      expect(beginner.style!.fontFamily, "BalooThambi2");
      expect(beginner.style!.fontSize, FontSize.s12);
    });

    testWidgets('blur filters are applied', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final filters = find.byType(BackdropFilter);
      expect(filters, findsNWidgets(2));

      for (final element in filters.evaluate()) {
        final filterWidget = element.widget as BackdropFilter;
        final filter = filterWidget.filter;
        expect(filter.toString(), contains('blur'));
      }
    });

    testWidgets('contains two expanded overlay items', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final expandedWidgets = find.byType(Expanded);
      expect(expandedWidgets, findsNWidgets(2));
    });

    testWidgets('overlay containers have correct decoration',
        (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final containerFinder = find.byWidgetPredicate((widget) {
        if (widget is Container && widget.decoration is BoxDecoration) {
        final box = widget.decoration as BoxDecoration;
          return box.color ==  AppColors.gray[AppColors.colorCode90]!.withValues(alpha: 0.5) &&
              box.borderRadius != null;

        }
        return false;
      });

      expect(containerFinder, findsNWidgets(2));

      final container =
          tester.widget<Container>(containerFinder.first);
      final boxDecoration = container.decoration as BoxDecoration;

      expect(boxDecoration.color!.withOpacity(1).value,
          AppColors.gray[AppColors.colorCode90]!.value);
      expect(boxDecoration.borderRadius, isNotNull);
    });

    testWidgets('Row uses spaceBetween layout', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });
  });
}

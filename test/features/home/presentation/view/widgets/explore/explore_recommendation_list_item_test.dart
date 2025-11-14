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

  group("ExplorePopularListItem Tests", () {
    testWidgets("verify structure", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Stack), findsNWidgets(2));
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(BackdropFilter), findsNWidgets(2));
    });

    testWidgets("renders background container with correct image", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final bgContainer = find.byType(Container).first;
      final containerWidget = tester.widget<Container>(bgContainer);
      final decoration = containerWidget.decoration as BoxDecoration;

      expect(decoration.image, isNotNull);
      expect(
        (decoration.image!.image as AssetImage).assetName,
        AssetsManager.popularTrainingImg,
      );
    });

    testWidgets("renders title text with correct style", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final titleFinder =
          find.text("Exercises That\nStrengthen Your Chest");
      final text = tester.widget<Text>(titleFinder);

      expect(text.style!.color, AppColors.white);
      expect(text.style!.fontFamily, "BalooThambi2");
      expect(text.style!.fontSize, FontSize.s14);
    });

    testWidgets("renders blur overlay containers", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final blurred = find.byType(BackdropFilter);
      expect(blurred, findsNWidgets(2));

      final overlayContainers = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color != null,
      );

      expect(overlayContainers, findsWidgets);

      final first = tester.widget<Container>(overlayContainers.first);
      final box = first.decoration as BoxDecoration;

      expect(box.color!.opacity, closeTo(0.5, 0.1));
    });

    testWidgets("renders '24 Tasks' and 'Beginner' texts", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.text("24 Tasks"), findsOneWidget);
      expect(find.text("Beginner"), findsOneWidget);

      final beginner = tester.widget<Text>(find.text("Beginner"));
      expect(beginner.style!.color, AppColors.orange);
      expect(beginner.style!.fontSize, FontSize.s12);
    });

    testWidgets("layout alignment checks", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final stack = tester.widgetList<Stack>(find.byType(Stack)).first;
      expect(stack.alignment, Alignment.bottomCenter);

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.mainAxisAlignment, MainAxisAlignment.end);

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });
  });
}

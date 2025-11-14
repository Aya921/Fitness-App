import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_upcoming_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const fakeMuscle = MuscleEntity(
    name: "Chest",
    image: "https://example.com/img.jpg",
  );

  Widget prepareWidget() {
    return const MaterialApp(
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: ExploreUpcomingListItem(musclesentity: fakeMuscle),
        ),
      ),
    );
  }

  group("ExploreUpcomingListItem Tests", () {

    testWidgets("verify structure", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Stack), findsNWidgets(2));
      expect(find.byType(Positioned), findsOneWidget);
      expect(find.byType(ClipRRect), findsNWidgets(2));
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets("renders main image with correct URL", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final img = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );

      expect(img.imageUrl, equals(fakeMuscle.image));
    });

    testWidgets("renders blur overlay container", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final blurred = find.byType(BackdropFilter);
      expect(blurred, findsOneWidget);

      final overlayContainer = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color != null,
      );

      expect(overlayContainer, findsWidgets);

      final decoration =
          (tester.widget<Container>(overlayContainer.first).decoration
              as BoxDecoration);

      expect(decoration.color!.opacity, closeTo(0.5, 0.1));
    });

    testWidgets("renders text with correct style", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final textWidget = tester.widget<Text>(find.text("Chest"));

      expect(textWidget.style!.color, AppColors.white);
      expect(textWidget.style!.fontFamily, "BalooThambi2");
      expect(textWidget.style!.fontSize, FontSize.s12);
    });

    testWidgets("layout alignment checks", (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final stack = tester.widgetList<Stack>(find.byType(Stack)).first;
      expect(stack.alignment, Alignment.bottomCenter);

      final fitted = tester.widget<FittedBox>(find.byType(FittedBox));
      expect(fitted.fit, BoxFit.scaleDown);
    });
  });
}

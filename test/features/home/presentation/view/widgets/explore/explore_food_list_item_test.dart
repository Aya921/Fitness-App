import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/foods/domain/entities/meals_categories.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_food_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ExploreFoodListItem Widget Tests', () {
    Widget prepareWidget(MealCategoryEntity entity) {
      return MaterialApp(
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: Center(
              child: ExploreFoodListItem(mealCategoryEntity: entity),
            ),
          ),
        ),
      );
    }

    testWidgets('verify structure', (tester) async {
      const testEntity = MealCategoryEntity(
        idCategory: "1",
        strCategory: "Beef",
        strCategoryThumb: "https://example.com/beef.jpg", strCategoryDescription: '',
      );

      await tester.pumpWidget(prepareWidget(testEntity));
      await tester.pumpAndSettle();

      expect(find.byType(Padding), findsNWidgets(2));
      expect(find.byType(Stack), findsNWidgets(2));
      expect(find.byType(SizedBox), findsNWidgets(2));
      expect(find.byType(ClipRRect), findsNWidgets(2));
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.byType(Positioned), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(FittedBox), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      
      expect(find.text("Beef"), findsOneWidget);
    });


   testWidgets('apply correct blur and color overlay', (tester) async {
  const testEntity = MealCategoryEntity(
    idCategory: "1",
    strCategory: "Chicken",
    strCategoryThumb: "https://example.com/chicken.jpg",
    strCategoryDescription: '',
  );

  await tester.pumpWidget(prepareWidget(testEntity));
  await tester.pumpAndSettle();


  final blurFilterFinder = find.byType(BackdropFilter);
  expect(blurFilterFinder, findsOneWidget);

  final blurFilter = tester.widget<BackdropFilter>(blurFilterFinder);

 
  expect(blurFilter.filter, isA<ImageFilter>());
  final imageFilter = blurFilter.filter;

 
  expect(imageFilter.toString(), startsWith('ImageFilter.blur'));
  expect(imageFilter.toString(), contains('10.0')); 


  final containerFinder = find.descendant(
    of: blurFilterFinder,
    matching: find.byType(Container),
  );

  final container = tester.widget<Container>(containerFinder.first);
  final boxDecoration = container.decoration as BoxDecoration;
  expect(boxDecoration.color, isNotNull);

  expect(boxDecoration.color!.opacity, moreOrLessEquals(0.5, epsilon: 0.1));
});

    testWidgets('use correct text style and alignment', (tester) async {
      const testEntity = MealCategoryEntity(
        idCategory: "1",
        strCategory: "Vegan",
        strCategoryThumb: "https://example.com/vegan.jpg", strCategoryDescription: '',
      );

      await tester.pumpWidget(prepareWidget(testEntity));
      await tester.pumpAndSettle();

      final textFinder = find.text("Vegan");
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.textAlign, TextAlign.center);
      expect(textWidget.style!.color, AppColors.white);
    });
  });
}

// import 'dart:ui';
// import 'package:fitness/core/constants/assets_manager.dart';
// import 'package:fitness/core/responsive/size_provider.dart';
// import 'package:fitness/core/theme/app_colors.dart';
// import 'package:fitness/core/theme/font_manager.dart';
// import 'package:fitness/features/home/presentation/view/widgets/explore/explore_popular_list_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

// Widget prepareWidget() {
//   return const MaterialApp(
//     home: SizeProvider(
//       baseSize: Size(375, 812),
//       height: 812,
//       width: 375,
//       child: Scaffold(
//         body: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: ExplorePopularListItem(),
//         ),
//       ),
//     ),
//   );
// }

//   group('ExplorePopularListItem Widget Tests', () {
//     testWidgets('renders structure correctly', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pump();

//       // Basic structure
//       expect(find.byType(Padding), findsNWidgets(5));
//       expect(find.byType(Stack), findsOneWidget);
//       expect(find.byType(Column), findsOneWidget);
//       expect(find.byType(Row), findsOneWidget);
//       expect(find.byType(BackdropFilter), findsNWidgets(2));
//       expect(find.byType(Container), findsWidgets);

//       // Background Container check
//       final containerFinder = find.byType(Container).first;
//       final container = tester.widget<Container>(containerFinder);
//       final boxDecoration = container.decoration as BoxDecoration;
//       expect(boxDecoration.image, isNotNull);
//       expect(
//         (boxDecoration.image!.image as AssetImage).assetName,
//         AssetsManager.popularTrainingImg,
//       );
//     });

//     testWidgets('renders all expected texts', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pump();

//       expect(
//         find.text('Exercises That\nStrengthen Your Chest'),
//         findsOneWidget,
//       );
//       expect(find.text('24 Tasks'), findsOneWidget);
//       expect(find.text('Beginner'), findsOneWidget);
//     });

//     testWidgets('applies correct text styles', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pump();

//       final titleFinder =
//           find.text('Exercises That\nStrengthen Your Chest');
//       final titleText = tester.widget<Text>(titleFinder);
//       expect(titleText.style!.color, AppColors.white);
//       expect(titleText.style!.fontFamily, 'BalooThambi2');
//       expect(titleText.style!.fontSize, FontSize.s14);

//       final beginnerFinder = find.text('Beginner');
//       final beginnerText = tester.widget<Text>(beginnerFinder);
//       expect(beginnerText.style!.color, AppColors.orange);
//       expect(beginnerText.style!.fontFamily, 'BalooThambi2');
//       expect(beginnerText.style!.fontSize, FontSize.s12);
//     });

//     testWidgets('applies blur effect and semi-transparent gray overlay',
//         (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pump();

//       final blurFilters = find.byType(BackdropFilter);
//       expect(blurFilters, findsNWidgets(2));

//       // Verify blur is applied
//       for (final blurFilter in blurFilters.evaluate()) {
//         final widget = blurFilter.widget as BackdropFilter;
//         expect(widget.filter, isA<ImageFilter>());
//         expect(widget.filter.toString(), contains('blur'));
//       }

//       // Verify overlay container colors
//       final overlayContainers = find.byWidgetPredicate((widget) {
//         return widget is Container &&
//             widget.decoration is BoxDecoration &&
//             (widget.decoration as BoxDecoration).color != null;
//       });

//       expect(overlayContainers, findsWidgets);

//       final firstOverlay = tester.widget<Container>(overlayContainers.first);
//       final boxDecoration = firstOverlay.decoration as BoxDecoration;
//       expect(boxDecoration.color, isNotNull);
//       expect(boxDecoration.color!.opacity, closeTo(0.5, 0.1));
//   expect(
//   boxDecoration.color!.withOpacity(1).value,
//   equals(AppColors.gray.value),
// );

//     });

//     testWidgets('renders correct layout hierarchy', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pump();

//       final stack = tester.widget<Stack>(find.byType(Stack));
//       expect(stack.alignment, Alignment.bottomCenter);

//       final column = tester.widget<Column>(find.byType(Column));
//       expect(column.mainAxisAlignment, MainAxisAlignment.end);
//       expect(column.crossAxisAlignment, CrossAxisAlignment.center);

//       final row = tester.widget<Row>(find.byType(Row));
//       expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
//     });
//   });
// }

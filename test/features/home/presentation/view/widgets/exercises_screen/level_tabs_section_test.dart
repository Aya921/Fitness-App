// import 'package:fitness/core/enum/request_state.dart';
// import 'package:fitness/core/l10n/translations/app_localizations.dart';
// import 'package:fitness/core/responsive/size_provider.dart';
// import 'package:fitness/core/widget/tab_bar_widget.dart';
// import 'package:fitness/features/home/domain/entities/exercises/difficulty_level_entity.dart';
// import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/level_tabs_section.dart';
// import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
// import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';

// import 'level_tabs_section_test.mocks.dart';


// @GenerateMocks([ExercisesCubit, TabController])
// void main() {
//   late MockExercisesCubit mockExercisesCubit;
//   late MockTabController mockTabController;

//   const testMuscleId = 'muscle_123';
//   final testLevels = [
//     const LevelEntity(id: 'level_1', name: 'Beginner'),
//     const LevelEntity(id: 'level_2', name: 'Intermediate'),
//     const LevelEntity(id: 'level_3', name: 'Advanced'),
//   ];

//   setUpAll(() {
//     provideDummy<ExercisesStates>(const ExercisesStates());
//   });

//   setUp(() {
//     mockExercisesCubit = MockExercisesCubit();
//     mockTabController = MockTabController();

//     when(mockExercisesCubit.stream)
//         .thenAnswer((_) => const Stream<ExercisesStates>.empty());
//     when(mockExercisesCubit.state).thenReturn(
//       ExercisesStates(
//         levelsByMuscleStatus: StateStatus.success(testLevels),
//       ),
//     );
//   });

//   Widget prepareWidget({
//     ExercisesCubit? cubit,
//     TabController? tabController,
//     String? muscleId,
//   }) {
//     return SizeProvider(
//       baseSize: const Size(375, 812),
//       height: 812,
//       width: 375,
//       child: MaterialApp(
//         localizationsDelegates: AppLocalizations.localizationsDelegates,
//         supportedLocales: AppLocalizations.supportedLocales,
//         locale: const Locale('en'),
//         home: Scaffold(
//           body: BlocProvider<ExercisesCubit>(
//             create: (_) => cubit ?? mockExercisesCubit,
//             child: LevelTabsSection(
//               muscleId: muscleId ?? testMuscleId,
//               tabController: tabController ?? mockTabController,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   group('LevelTabsSection Widget Tests', () {
//     testWidgets('verify level tabs section structure', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pumpAndSettle();

//       expect(find.byType(Container), findsWidgets);
//       expect(find.byType(TabBarWidget), findsOneWidget);
//       expect(find.byType(BlocBuilder<ExercisesCubit, ExercisesStates>),
//           findsOneWidget);
//     });

//     testWidgets('verify tabs display correct level names', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pumpAndSettle();

//       final tabBarWidget = tester.widget<TabBarWidget>(
//         find.byType(TabBarWidget),
//       );

//       expect(tabBarWidget.titles.length, equals(3));
//       expect(tabBarWidget.titles[0], equals('Beginner'));
//       expect(tabBarWidget.titles[1], equals('Intermediate'));
//       expect(tabBarWidget.titles[2], equals('Advanced'));
//     });

//     testWidgets('verify tab selection triggers cubit intent', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pumpAndSettle();

//       final tabBarWidget = tester.widget<TabBarWidget>(
//         find.byType(TabBarWidget),
//       );

//       // Simulate tab change to index 1 (Intermediate)
//       tabBarWidget.onTabChanged!(1);
//       await tester.pumpAndSettle();

//       verify(
//         mockExercisesCubit.doIntent(
//           intent: anyNamed('intent'),
//         ),
//       ).called(1);
//     });

//     testWidgets('verify tab change animates TabController', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pumpAndSettle();

//       // Get TabBarWidget
//       final tabBarWidget = tester.widget<TabBarWidget>(
//         find.byType(TabBarWidget),
//       );

//       // Simulate tab change to index 2 (Advanced)
//       tabBarWidget.onTabChanged!(2);
//       await tester.pumpAndSettle();

//       // Verify TabController's animateTo was called with correct index
//       verify(mockTabController.animateTo(2)).called(1);
//     });

//     testWidgets('verify multiple tab changes trigger multiple intents',
//             (tester) async {
//           await tester.pumpWidget(prepareWidget());
//           await tester.pumpAndSettle();

//           final tabBarWidget = tester.widget<TabBarWidget>(
//             find.byType(TabBarWidget),
//           );

//           // Simulate multiple tab changes
//           tabBarWidget.onTabChanged!(0);
//           await tester.pumpAndSettle();

//           tabBarWidget.onTabChanged!(1);
//           await tester.pumpAndSettle();

//           tabBarWidget.onTabChanged!(2);
//           await tester.pumpAndSettle();

//           // Verify cubit's doIntent was called 3 times
//           verify(
//             mockExercisesCubit.doIntent(
//               intent: anyNamed('intent'),
//             ),
//           ).called(3);

//           // Verify TabController's animateTo was called 3 times
//           verify(mockTabController.animateTo(any)).called(3);
//         });

//     testWidgets('verify empty levels list shows empty tabs', (tester) async {
//       // Setup cubit with empty levels
//       when(mockExercisesCubit.state).thenReturn(
//         const ExercisesStates(
//           levelsByMuscleStatus: StateStatus.success([]),
//         ),
//       );

//       await tester.pumpWidget(prepareWidget());
//       await tester.pumpAndSettle();

//       final tabBarWidget = tester.widget<TabBarWidget>(
//         find.byType(TabBarWidget),
//       );

//       expect(tabBarWidget.titles.length, equals(0));
//     });

//     testWidgets('verify container has correct styling', (tester) async {
//       await tester.pumpWidget(prepareWidget());
//       await tester.pumpAndSettle();

//       final container = tester.widgetList<Container>(
//         find.byType(Container),
//       ).first;

//       expect(container.decoration, isA<BoxDecoration>());
//       final decoration = container.decoration as BoxDecoration;
//       expect(decoration.borderRadius, isNotNull);
//     });

//     testWidgets('verify correct muscleId is passed to intent',
//             (tester) async {
//           const customMuscleId = 'custom_muscle_456';

//           await tester.pumpWidget(
//             prepareWidget(muscleId: customMuscleId),
//           );
//           await tester.pumpAndSettle();

//           final tabBarWidget = tester.widget<TabBarWidget>(
//             find.byType(TabBarWidget),
//           );

//           tabBarWidget.onTabChanged!(0);
//           await tester.pumpAndSettle();

//           verify(
//             mockExercisesCubit.doIntent(
//               intent: anyNamed('intent'),
//             ),
//           ).called(1);
//         });

//   });
// }
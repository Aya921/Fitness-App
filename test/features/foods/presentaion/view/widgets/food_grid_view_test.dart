import 'dart:io';

import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/foods/domain/entities/meals_by_category.dart';
import 'package:fitness/features/foods/presentaion/view/widgets/food_grid_view.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/core/widget/custom_card_fitness.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'food_grid_view_test.mocks.dart';

class _FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _FakeHttpClient();
  }
}

class _FakeHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
@GenerateMocks([FoodCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockFoodCubit mockFoodCubit;



  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockFoodCubit = MockFoodCubit();
    HttpOverrides.global = _FakeHttpOverrides();

    if (getIt.isRegistered<FoodCubit>()) {
      getIt.unregister<FoodCubit>();
    }

    getIt.registerFactory<FoodCubit>(() => mockFoodCubit);
    provideDummy<FoodStates>(const FoodStates());
  });

  Widget createWidgetUnderTest(FoodStates state) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: BlocProvider<FoodCubit>.value(
            value: mockFoodCubit,
            child: const Column(
              children: [
                FoodGridView(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  group('FoodGridView Widget Tests', () {
    testWidgets('should show loading skeleton when state is loading', (WidgetTester tester) async {
      const loadingState = FoodStates(
        mealsByCategorieStatus: StateStatus.loading(),
      );
      when(mockFoodCubit.state).thenReturn(loadingState);
      when(mockFoodCubit.stream).thenAnswer((_) => Stream.value(loadingState));

      await tester.pumpWidget(createWidgetUnderTest(loadingState));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(GridView), findsOneWidget);

      expect(find.byType(Skeletonizer), findsNothing);
      expect(find.byType(CustomCardFitness), findsWidgets);
    });
    testWidgets('should show loading skeleton when state is initial', (WidgetTester tester) async {
      // Arrange
      const initialState = FoodStates(
        mealsByCategorieStatus:  StateStatus.initial(),
      );
   when(mockFoodCubit.state).thenReturn(initialState);
   when(mockFoodCubit.stream).thenAnswer((_)=>Stream.value(initialState));

      // Act
      await tester.pumpWidget(createWidgetUnderTest(initialState));

      // Assert
      expect(find.byType(Skeletonizer), findsNothing);
      expect(find.byType(CustomCardFitness), findsWidgets);
    });

    testWidgets('should show loading skeleton when state is failure',
            (WidgetTester tester) async {
      // Arrange
      const failureState = FoodStates(
        mealsByCategorieStatus: StateStatus.failure(ResponseException(message: "")),
      );

      when(mockFoodCubit.state).thenReturn(failureState);
      when(mockFoodCubit.stream).thenAnswer((_) => Stream.value(failureState));



      await tester.pumpWidget(createWidgetUnderTest(failureState));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(GridView), findsOneWidget);

      expect(find.byType(Skeletonizer), findsNothing);
      expect(find.byType(CustomCardFitness), findsWidgets);
    });
    testWidgets('should show actual data when state is success', (WidgetTester tester) async {
      // Arrange
      final mockMeals = [
        const MealsByCategory(
          idMeal: '1',
          strMeal: '15-minute chicken & halloumi burger',
          strMealThumb: 'https://example.com/burger.jpg',
        ),
      ];

      final successState = FoodStates(
        mealsByCategorieStatus: StateStatus.success(mockMeals),
      );

      when(mockFoodCubit.state).thenReturn(successState);
      when(mockFoodCubit.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createWidgetUnderTest(successState));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();


      expect(find.byType(GridView), findsOneWidget);
      expect(find.textContaining('halloumi'), findsOneWidget);
      expect(find.byType(Skeletonizer), findsNothing);
    });



  });

}

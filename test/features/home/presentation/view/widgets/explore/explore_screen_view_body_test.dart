import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_states.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_state.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_categories_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_food_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_popular_training_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_screen_profile_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_recommendation_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_upcoming_list_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_screen_view_body.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:fitness/core/enum/request_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'explore_screen_view_body_test.mocks.dart';
@GenerateMocks([ExploreCubit, FoodCubit, BottomNavigationCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockExploreCubit mockExploreCubit;
  late MockFoodCubit mockFoodCubit;
late MockBottomNavigationCubit mockBottomNavCubit;
  

  const baseState = ExploreState(
    userData: StateStatus.success(AuthEntity()),
    musclesGroupState: StateStatus.success([]),
    randomMusclesState: StateStatus.success([]),
    musclesGroupById: StateStatus.success(MusclesGroupIdResponseEntity()),
  );

  const errorState = ExploreState(
    userData: StateStatus.failure(ResponseException(message: 'error')),
    musclesGroupState: StateStatus.failure(ResponseException(message: 'error')),
    randomMusclesState: StateStatus.failure(ResponseException(message: 'error')),
    musclesGroupById: StateStatus.failure(ResponseException(message: 'error')),
  );



setUp(() {
  mockExploreCubit = MockExploreCubit();
  mockFoodCubit = MockFoodCubit();
  mockBottomNavCubit = MockBottomNavigationCubit();

  provideDummy<ExploreState>(const ExploreState());
  provideDummy<FoodStates>(const FoodStates());
  provideDummy<BottomNavigationState>(const BottomNavigationState(index: 0));

  when(mockBottomNavCubit.state).thenReturn(const BottomNavigationState(index: 0));
  when(mockBottomNavCubit.stream).thenAnswer((_) => Stream.value(const BottomNavigationState(index: 0)));

  when(mockFoodCubit.state).thenReturn(
    const FoodStates(
      mealsCategories: StateStatus.success([]),
    ),
  );
  when(mockFoodCubit.stream).thenAnswer((_) => Stream.value(
    const FoodStates(mealsCategories: StateStatus.success([])),
  ));
});

Widget prepareWidget() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<ExploreCubit>.value(value: mockExploreCubit),
      BlocProvider<FoodCubit>.value(value: mockFoodCubit),
      BlocProvider<BottomNavigationCubit>.value(value: mockBottomNavCubit),
    ],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: ExploreScreenViewBody(),
        ),
      ),
    ),
  );
}

  group("ExploreScreenViewBody tests", () {
    testWidgets("verify structure", (tester) async {
      when(mockExploreCubit.state).thenReturn(baseState);
      when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(baseState));

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ExploreScreenProfileSection), findsOneWidget);
      expect(find.byType(ExploreCategoriesListView), findsOneWidget);
      expect(find.byType(ExploreRecommendationListView), findsOneWidget);
      expect(find.byType(ExploreUpcomingListView), findsOneWidget);
      expect(find.byType(ExploreFoodListView), findsOneWidget);
      expect(find.byType(ExplorePopularTrainingListView), findsOneWidget);

      
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets("background is applied correctly", (tester) async {
      when(mockExploreCubit.state).thenReturn(baseState);
      when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(baseState));

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      expect(find.byType(HomeBackground), findsOneWidget);
    });

    testWidgets("error state triggers Loaders.showErrorMessage", (tester) async {
      when(mockExploreCubit.state).thenReturn(errorState);
      when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(errorState));

      await tester.pumpWidget(prepareWidget());
      await tester.pump();
 expect(find.text("error"), findsOneWidget);
 
    });

    testWidgets("structural layout matches expected tree", (tester) async {
      when(mockExploreCubit.state).thenReturn(baseState);
      when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(baseState));

      await tester.pumpWidget(prepareWidget());
      await tester.pump();

      final column = tester.widgetList<Column>(
        find.byWidgetPredicate((w) => w is Column && w.crossAxisAlignment == CrossAxisAlignment.start),
      ).first;

      expect(column.crossAxisAlignment, CrossAxisAlignment.start);

      final scroll = tester.widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
      expect(scroll.physics, isNull);
    });
  });
}

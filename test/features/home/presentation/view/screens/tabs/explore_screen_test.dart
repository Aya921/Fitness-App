import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/foods/domain/entities/meals_categories.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_states.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/explore_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_state.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_screen_view_body.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'explore_screen_test.mocks.dart';

@GenerateMocks([ExploreCubit, FoodCubit, BottomNavigationCubit])

void main() {
  
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockExploreCubit mockExploreCubit;
  late MockFoodCubit mockFoodCubit;
  late MockBottomNavigationCubit mockBottomNavigationCubit;
  late List<MealCategoryEntity> fakeMeals;
  fakeMeals = [
    const MealCategoryEntity(
      idCategory: '1',
      strCategory: 'beef',
      strCategoryThumb: 'https://www.themealdb.com/images/category/beef.png',
      strCategoryDescription: 'descritption',
    ),
  ];

  final successState = FoodStates(
    mealsCategories: StateStatus<List<MealCategoryEntity>>.success(fakeMeals),
  );
  setUp(() {
    mockExploreCubit = MockExploreCubit();
    mockFoodCubit = MockFoodCubit();
    mockBottomNavigationCubit = MockBottomNavigationCubit();
    getIt.registerFactory<ExploreCubit>(() => mockExploreCubit);
    getIt.registerFactory<FoodCubit>(() => mockFoodCubit);
    getIt.registerFactory<BottomNavigationCubit>(
      () => mockBottomNavigationCubit,
    );
    provideDummy<ExploreState>(const ExploreState());
    provideDummy<FoodStates>(const FoodStates());
    provideDummy<BottomNavigationState>(const BottomNavigationState(index: 0));
    when(
      mockExploreCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ExploreState()]));
    when(mockExploreCubit.state).thenReturn(
      const ExploreState(
        musclesGroupById: StateStatus.success(MusclesGroupIdResponseEntity()),
        musclesGroupState: StateStatus.success([]),
        randomMusclesState: StateStatus.success([]),
        userData: StateStatus.success(AuthEntity()),
      ),
    );

    when(mockFoodCubit.stream).thenAnswer((_) => Stream.value(successState));
    when(mockFoodCubit.state).thenReturn(successState);

    when(mockBottomNavigationCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const BottomNavigationState(index: 0)]),
    );
    when(
      mockBottomNavigationCubit.state,
    ).thenReturn(const BottomNavigationState(index: 0));
  });

  Widget prepareWidget() {
    return BlocProvider<BottomNavigationCubit>(
      create: (context) => mockBottomNavigationCubit,
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: ExploreScreen(),
        ),
      ),
    );
  }

  testWidgets("verify Explore Screen Structure", (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    
    expect(find.byType(ExploreScreenViewBody), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(MultiBlocProvider), findsOneWidget);
  });
  tearDown(getIt.reset);
}

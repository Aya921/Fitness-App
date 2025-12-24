import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/foods/domain/entities/meals_by_category.dart';
import 'package:fitness/features/foods/domain/entities/meals_categories.dart';
import 'package:fitness/features/foods/domain/use_case/get_meal_by_categories_use_case.dart';
import 'package:fitness/features/foods/domain/use_case/get_meals_categories_use_case.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_intent.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_states.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_cubit_test.mocks.dart';

@GenerateMocks([GetMealsCategoriesUseCase, GetMealsByCategoriesUseCase])
void main() {

  late MockGetMealsCategoriesUseCase mockGetMealsCategoriesUseCase;
  late MockGetMealsByCategoriesUseCase mockGetMealsByCategoriesUseCase;
  late FoodCubit foodCubit;
  setUp(() {
    mockGetMealsByCategoriesUseCase = MockGetMealsByCategoriesUseCase();
    mockGetMealsCategoriesUseCase = MockGetMealsCategoriesUseCase();
    foodCubit = FoodCubit(
      mockGetMealsCategoriesUseCase,
      mockGetMealsByCategoriesUseCase,
    );
    provideDummy<Result<List<MealCategoryEntity>>>(
      FailedResult("failed to load data"),
    );
    provideDummy<Result<List<MealsByCategory>>>(
      FailedResult("failed to load data"),
    );
  });
  group("Meals Categories", () {
    final fakeSuccessResponse = [
      const MealCategoryEntity(
        idCategory: "1",
        strCategory: "Beef",
        strCategoryThumb: "https://www.themealdb.com/images/category/beef.png",
        strCategoryDescription:
        "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]",
      ),
      const MealCategoryEntity(
        idCategory: "2",
        strCategory: "Chicken",
        strCategoryThumb:
        "https://www.themealdb.com/images/category/chicken.png",
        strCategoryDescription:
        "Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.",
      ),
    ];

    blocTest<FoodCubit, FoodStates>(
      "emit [loading,success] when use case success",
      build: () {
        //arrange
        when(
          mockGetMealsCategoriesUseCase.call(),
        ).thenAnswer((_) async => SuccessResult(fakeSuccessResponse));

        return foodCubit;
      },
      act: (cubit) => [
        //act
        cubit.doIntent(intent: FoodInitializationIntent()),
      ],
      expect: () => [
        isA<FoodStates>().having(
              (state) => state.mealsCategories.isLoading,
          "isLoading",
          equals(true),
        ),

        isA<FoodStates>().having(
              (state) => state.mealsCategories.data,
          "load data",
          equals(fakeSuccessResponse),
        ),

        // isA<FoodStates>().having((state)=>state.mealsCategories.isFailure,
        //     "isFailure",  equals('failed to load data'))
      ],
      verify: (_) => verify(mockGetMealsCategoriesUseCase.call()).called(1),
    );
    blocTest<FoodCubit, FoodStates>(
      "emit [loading,failure] when use case failed",
      build: () {
        when(
          mockGetMealsCategoriesUseCase.call(),
        ).thenAnswer((_) async => FailedResult("failed to load data"));
        return foodCubit;
      },
      act: (cubit) => [cubit.doIntent(intent: FoodInitializationIntent())],
      expect: () => [
        isA<FoodStates>().having(
              (state) => state.mealsCategories.isLoading,
          "isLoading",
          equals(true),
        ),

        isA<FoodStates>().having(
              (state) => state.mealsCategories.error,
          "isFailure",
          const ResponseException(message: "failed to load data"),
        ),
      ],
      verify: (_) => verify(mockGetMealsCategoriesUseCase.call()).called(1),
    );
  });
  group("Get Meals By Category", () {
    final List<MealsByCategory> fakeSuccessResponse = [
      const MealsByCategory(
        strMeal: "15-minute chicken & halloumi burgers",
        strMealThumb:
        "https://www.themealdb.com/images/media/meals/vdwloy1713225718.jpg",
        idMeal: "53085",
      ),
      const MealsByCategory(
        strMeal: "Ayam Percik",
        strMealThumb:
        "https://www.themealdb.com/images/media/meals/020z181619788503.jpg",
        idMeal: "53050",
      ),
    ];
    const category = "Chicken";
    blocTest<FoodCubit, FoodStates>(
      "emit [loading,success] when use case success on get meals by category ",
      build: () {
        when(
          mockGetMealsByCategoriesUseCase.call(category),
        ).thenAnswer((_) async => SuccessResult(fakeSuccessResponse));

        return foodCubit;
      },
      act: (cubit) =>
      cubit..doIntent(intent: MealsByCategoriesIntent(category)),
      expect: () => [
        foodCubit.state.copyWith(
          mealsByCategorieStatus: const StateStatus.loading(),
        ),
        foodCubit.state.copyWith(
          mealsByCategorieStatus: StateStatus.success(fakeSuccessResponse),
        ),
      ],
      verify: (_) =>
          verify(mockGetMealsByCategoriesUseCase.call(category)).called(1),
    );

    blocTest<FoodCubit, FoodStates>(
      "emit [loading, failure] when use case failed on get meals by category",
      build: () {
        when(mockGetMealsByCategoriesUseCase.call(category))
            .thenAnswer((_) async => FailedResult("failed to load data"));
        return foodCubit;
      },
      act: (cubit) => cubit.doIntent(intent: MealsByCategoriesIntent(category)),
      expect: () => [
        const FoodStates().copyWith(
          mealsByCategorieStatus: const StateStatus.loading(),
          errorMealsByCategories: null,
        ),

        const FoodStates().copyWith(
          mealsByCategorieStatus: const StateStatus.failure(
            ResponseException(message: "failed to load data"),
          ),
          errorMealsByCategories: "failed to load data",
        ),
      ],
      verify: (_) =>
          verify(mockGetMealsByCategoriesUseCase.call(category)).called(1),
    );


  });
}

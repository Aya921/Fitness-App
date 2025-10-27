import 'package:bloc_test/bloc_test.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/food/domain/entities/meals_categories.dart';
import 'package:fitness/features/food/domain/use_case/get_meals_categories_use_case.dart';
import 'package:fitness/features/food/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/food/presentaion/view_model/food_intent.dart';
import 'package:fitness/features/food/presentaion/view_model/food_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_cubit_test.mocks.dart';

@GenerateMocks([GetMealsCategoriesUseCase])
void main() {
  late MockGetMealsCategoriesUseCase mockGetMealsCategoriesUseCase;
  late FoodCubit foodCubit;
  setUp(() {
    mockGetMealsCategoriesUseCase = MockGetMealsCategoriesUseCase();
    foodCubit = FoodCubit(mockGetMealsCategoriesUseCase);
    provideDummy<Result<List<MealCategoryEntity>>>(
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
}

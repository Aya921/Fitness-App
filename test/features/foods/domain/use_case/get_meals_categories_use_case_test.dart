import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/foods/data/repo/food_repo_impl.dart';
import 'package:fitness/features/foods/domain/entities/meals_categories.dart';
import 'package:fitness/features/foods/domain/use_case/get_meals_categories_use_case.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_meals_categories_use_case_test.mocks.dart';

@GenerateMocks([FoodRepoImpl])
void main() {
  late MockFoodRepoImpl mockFoodRepoImpl;
  late GetMealsCategoriesUseCase getMealsCategoriesUseCase;
  setUpAll(() {
    mockFoodRepoImpl = MockFoodRepoImpl();
    getMealsCategoriesUseCase = GetMealsCategoriesUseCase(mockFoodRepoImpl);
    provideDummy<Result<List<MealCategoryEntity>>>(
        FailedResult("failed to load data"));
  });
  group("Get Meal Categories", () {
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
    test("return SucessResult when repo success", () async {
      when(
        mockFoodRepoImpl.getMealsCategories(),
      ).thenAnswer((_) async => SuccessResult(fakeSuccessResponse));
      final result = await getMealsCategoriesUseCase.call();
      expect(result, isA<SuccessResult>());
      expect((result as SuccessResult).successResult, fakeSuccessResponse);
      verify(mockFoodRepoImpl.getMealsCategories()).called(1);
    });
    test("return FailedResult when repo failed", () async {
      when(
        mockFoodRepoImpl.getMealsCategories(),
      ).thenAnswer((_) async => FailedResult("failed to load data"));
      final result = await getMealsCategoriesUseCase.call();
      expect(result, isA<FailedResult>());
      expect((result as FailedResult).errorMessage, "failed to load data");
      verify(mockFoodRepoImpl.getMealsCategories()).called(1);
    });
  });
}
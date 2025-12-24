import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/foods/api/data_source/food_remote_data_source_impl.dart';
import 'package:fitness/features/foods/data/repo/food_repo_impl.dart';

import 'package:fitness/features/foods/domain/entities/meals_by_category.dart';
import 'package:fitness/features/foods/domain/entities/meals_categories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_repo_impl_test.mocks.dart';
@GenerateMocks([FoodRemoteDataSourceImpl])
void main() {
  late MockFoodRemoteDataSourceImpl mockFoodRemoteDataSourceImpl;
  late FoodRepoImpl foodRepoImpl;
  setUpAll((){
    mockFoodRemoteDataSourceImpl=MockFoodRemoteDataSourceImpl();
    foodRepoImpl=FoodRepoImpl(mockFoodRemoteDataSourceImpl);
    provideDummy<Result<List<MealCategoryEntity>>>(
        FailedResult("failed to load data"));
    provideDummy<Result<List<MealsByCategory>>>(
        FailedResult("failed to load data"));
  });
  group("Get Meals Categories", (){
    final fakeSuccessResponse =
    [
      const MealCategoryEntity(
        idCategory: "1",
        strCategory: "Beef",
        strCategoryThumb:
        "https://www.themealdb.com/images/category/beef.png",
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
    test("return SuccessResult when data source success", ()async{
      when(mockFoodRemoteDataSourceImpl.getMealsCategories())
          .thenAnswer((_)async=>SuccessResult(fakeSuccessResponse));
      final result=await foodRepoImpl.getMealsCategories();
      expect(result, isA<SuccessResult>());
      expect((result as SuccessResult).successResult, fakeSuccessResponse);
      verify(mockFoodRemoteDataSourceImpl.getMealsCategories()).called(1);
    });
    test("return SuccessResult when data source failed", ()async{

      when(mockFoodRemoteDataSourceImpl.getMealsCategories())
          .thenAnswer((_)async=>FailedResult("failed to load data"));
      final result=await foodRepoImpl.getMealsCategories();
      expect(result, isA<FailedResult>());
      expect((result as FailedResult).errorMessage, "failed to load data");
      verify(mockFoodRemoteDataSourceImpl.getMealsCategories()).called(1);
    });

  });
  group("Get Meals By Category", (){
    final fakeSuccessResponse=[
      const MealsByCategory(
          strMeal: "15-minute chicken & halloumi burgers",
          strMealThumb: "https://www.themealdb.com/images/media/meals/vdwloy1713225718.jpg",
          idMeal: "53085"
      ),
      const MealsByCategory (
          strMeal: "Ayam Percik",
          strMealThumb: "https://www.themealdb.com/images/media/meals/020z181619788503.jpg",
          idMeal: "53050"
      )
    ];
    const category="Chicken";
    test("return SuccessResult when data source success on meals by Category", ()async{

      when(mockFoodRemoteDataSourceImpl.getMealsByCategories(category))
          .thenAnswer((_)async=>SuccessResult(fakeSuccessResponse));
      final result=await foodRepoImpl.getMealsByCategories(category);
      expect(result, isA<SuccessResult>());
      expect((result as SuccessResult).successResult, fakeSuccessResponse);
      verify(mockFoodRemoteDataSourceImpl.getMealsByCategories(category)).called(1);
    });
    test("return FailedResult when data source success on meals by Category", ()async{

      when(mockFoodRemoteDataSourceImpl.getMealsByCategories(category))
          .thenAnswer((_)async=>FailedResult("Failed to load data"));
      final result=await foodRepoImpl.getMealsByCategories(category);
      expect(result, isA<FailedResult>());
      expect((result as FailedResult).errorMessage, "Failed to load data");
      verify(mockFoodRemoteDataSourceImpl.getMealsByCategories(category)).called(1);
    });

  });
}
import '../../../../core/result/result.dart';
import '../entities/meals_categories.dart';

abstract interface class FoodRepo{
  Future<Result<List<MealCategoryEntity>>> getMealsCategories();

}
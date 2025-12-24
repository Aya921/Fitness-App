import '../../../../core/result/result.dart';
import '../entities/meals_by_category.dart';
import '../entities/meals_categories.dart';

abstract interface class FoodRepo{
  Future<Result<List<MealCategoryEntity>>> getMealsCategories();
  Future<Result<List<MealsByCategory>>>
  getMealsByCategories(String category);
}
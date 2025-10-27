import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/food/domain/entities/meals_categories.dart';

abstract interface class FoodRemoteDataSource{
  Future<Result<List<MealCategoryEntity>>> getMealsCategories();
}
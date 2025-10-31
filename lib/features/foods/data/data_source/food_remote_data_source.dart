import 'package:fitness/core/result/result.dart';


import '../../domain/entities/meals_by_category.dart';
import '../../domain/entities/meals_categories.dart';

abstract interface class FoodRemoteDataSource{
  Future<Result<List<MealCategoryEntity>>> getMealsCategories();
  Future<Result<List<MealsByCategory>>> getMealsByCategories(
      String category
      );

}
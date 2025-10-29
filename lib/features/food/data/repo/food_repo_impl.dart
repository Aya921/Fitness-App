import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/food/data/data_source/food_remote_data_source.dart';
import 'package:fitness/features/food/domain/entities/meals_by_category.dart';

import 'package:fitness/features/food/domain/entities/meals_categories.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/food_repo.dart';
@Injectable(as:FoodRepo )
class FoodRepoImpl implements   FoodRepo{
  final FoodRemoteDataSource _foodRemoteDataSource;
const  FoodRepoImpl(this._foodRemoteDataSource);
  @override
  Future<Result<List<MealCategoryEntity>>> getMealsCategories() async{
   return await _foodRemoteDataSource.getMealsCategories();
  }

  @override
  Future<Result<List<MealsByCategory>>> getMealsByCategories
      (String category) async{
return await _foodRemoteDataSource.getMealsByCategories(category);
  }

}
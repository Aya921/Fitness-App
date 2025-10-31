import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';

import 'package:injectable/injectable.dart';

import '../../data/data_source/food_remote_data_source.dart';
import '../../domain/entities/meals_by_category.dart';
import '../../domain/entities/meals_categories.dart';
import '../client/api_services.dart';
@Injectable(as:FoodRemoteDataSource )
class FoodRemoteDataSourceImpl implements
    FoodRemoteDataSource{
  final FoodApiServices _foodApiServices;
  const FoodRemoteDataSourceImpl(this._foodApiServices);
  @override
  Future<Result<List<MealCategoryEntity>>> getMealsCategories()async {

 return safeApiCall(()async{
final response=await _foodApiServices.getMealsCategories();
final meals=response.categories?.map((e)=>e.toEntity()).toList()??[];
return meals;
 });

  }

  @override
  Future<Result<List<MealsByCategory>>>
  getMealsByCategories(String category)async {
return safeApiCall(()async{
  final response=await _foodApiServices.getMealsByCategories(category);
  final mealsByCategory=response.meals?.map((e)=>e.toEntity()).toList()??[];
return mealsByCategory;
});
  }

}
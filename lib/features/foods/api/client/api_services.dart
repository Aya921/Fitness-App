import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/end_points_constants.dart';
import '../models/meal_categories.dart';
import '../models/meals_cattegories_response.dart';
part 'api_services.g.dart';
@RestApi(baseUrl: EndPointsConstants.baseUrlFood)
@injectable
abstract class FoodApiServices{
  @factoryMethod
  factory FoodApiServices(Dio dio  ) = _FoodApiServices;
  @GET(EndPointsConstants.mealsCategories)

  Future<MealCaregoriesResponse>getMealsCategories();

  @GET(EndPointsConstants.mealsByCategories)
  Future<MealsCattegoriesResponse>getMealsByCategories(
      @Query("c") String category,
      );
}
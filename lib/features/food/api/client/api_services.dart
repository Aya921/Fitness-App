import 'package:fitness/features/food/api/models/meal_categories.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/end_points_constants.dart';
part 'api_services.g.dart';
@RestApi(baseUrl: EndPointsConstants.baseUrl)
@injectable
abstract class FoodApiServices{
  @factoryMethod
  factory FoodApiServices(Dio dio  ) = _FoodApiServices;
  @GET(EndPointsConstants.mealsCategories)

  Future<MealCaregoriesResponse>getMealsCategories();
}

import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/constants/end_points_constants.dart';
import 'package:fitness/features/meal_details/remote/details_food_api/models/meal_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'details_food_api_service.g.dart';

@RestApi()
@injectable
abstract class DetailsFoodApiService{
  @factoryMethod
  factory DetailsFoodApiService(Dio dio  ) = _DetailsFoodApiService;

   @GET(EndPointsConstants.detailsFoodBaseUrl)
  Future<MealResponseModel> getMealDetails(@Query(Constants.getMealsDetailsQuery) String mealId);



}
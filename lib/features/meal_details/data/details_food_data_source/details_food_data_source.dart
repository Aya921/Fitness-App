import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';



abstract interface class DetailsFoodDataSource {
  Future<Result<String>> convertIdToVideo(String videoUrl);
  Future<Result<MealResponseEntity>> getMealDetails({required String mealId});
}
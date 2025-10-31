import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/data/details_food_data_source/details_food_data_source.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/domain/repository/details_food_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DetailsFoodRepo)
class DetailsFoodRepoImp implements DetailsFoodRepo {
  final DetailsFoodDataSource _detailsFoodDataSource;

  DetailsFoodRepoImp(this._detailsFoodDataSource);

  @override
  Future<Result<String>> convertIdToVideo(String videoUrl) async {
    return await _detailsFoodDataSource.convertIdToVideo(videoUrl);
  }

  @override
  Future<Result<MealResponseEntity>> getMealDetails({
    required String mealId,
  }) async {
    return await _detailsFoodDataSource.getMealDetails(mealId: mealId);
  }
}

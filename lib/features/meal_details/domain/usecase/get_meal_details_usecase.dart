import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/domain/repository/details_food_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealDetailsUsecase {
  final DetailsFoodRepo _detailsFoodRepo;
  GetMealDetailsUsecase(this._detailsFoodRepo);

  Future<Result<MealResponseEntity>> getMealDetails ({required String mealId}) async {
    return await _detailsFoodRepo.getMealDetails(mealId: mealId);
  }
}

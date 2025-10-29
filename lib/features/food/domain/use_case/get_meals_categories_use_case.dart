import 'package:fitness/features/food/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../entities/meals_categories.dart';

@injectable
class GetMealsCategoriesUseCase{
  final FoodRepo _foodRepo;
 const GetMealsCategoriesUseCase(this._foodRepo);
  Future<Result<List<MealCategoryEntity>>>call()async{
    return await _foodRepo.getMealsCategories();
  }
}

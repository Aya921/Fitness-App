import 'package:fitness/features/food/domain/entities/meals_by_category.dart';
import 'package:fitness/features/food/domain/repo/food_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';

@injectable
class GetMealsByCategoriesUseCase{
  final FoodRepo _foodRepo;
  const GetMealsByCategoriesUseCase(this._foodRepo);
  Future<Result<List<MealsByCategory>>>call(String category)async{
    return await _foodRepo.getMealsByCategories(category);
  }
}

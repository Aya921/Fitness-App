
import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../entities/meals_by_category.dart';
import '../repo/food_repo.dart';

@injectable
class GetMealsByCategoriesUseCase{
  final FoodRepo _foodRepo;
  const GetMealsByCategoriesUseCase(this._foodRepo);
  Future<Result<List<MealsByCategory>>>call(String category)async{
    return await _foodRepo.getMealsByCategories(category);
  }
}
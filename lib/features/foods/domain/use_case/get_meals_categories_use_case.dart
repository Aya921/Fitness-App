import 'package:injectable/injectable.dart';
import '../../../../core/result/result.dart';
import '../entities/meals_categories.dart';
import '../repo/food_repo.dart';

@injectable
class GetMealsCategoriesUseCase{
  final FoodRepo _foodRepo;
 const GetMealsCategoriesUseCase(this._foodRepo);
  Future<Result<List<MealCategoryEntity>>>call()async{
    return await _foodRepo.getMealsCategories();
  }
}

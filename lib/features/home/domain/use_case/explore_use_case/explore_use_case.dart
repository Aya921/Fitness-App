import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/repositories/explore_repositories_impl/explore_repositories_impl.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/meals_categories_entity/meals_categories_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_random_entity/muscles_random_entity.dart';
import 'package:fitness/features/home/domain/repositories/explore_repositories/explore_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreUseCase {
 final ExploreRepositories _exploreRepositories;

  ExploreUseCase(this._exploreRepositories);
  Future<Result<List<MealsCategoriesEntity>>> getMealsCategories() {
    return _exploreRepositories.getMealsCategories();
  }

  
  Future<Result<List<MusclesGroupEntity>>> getMusclesGroup() {
      return _exploreRepositories.getMusclesGroup();
  }

  
  Future<Result<List<MusclesRandomEntity>>> getRandomMuscles() {
       return _exploreRepositories.getRandomMuscles();
  }

}
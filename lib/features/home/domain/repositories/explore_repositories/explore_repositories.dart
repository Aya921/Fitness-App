import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/meals_categories_entity/meals_categories_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_random_entity/muscles_random_entity.dart';

abstract class ExploreRepositories {
  
 Future<Result<List<MusclesRandomEntity>>> getRandomMuscles();

 Future<Result<List<MusclesGroupEntity>>> getMusclesGroup();

 Future<Result<List<MealsCategoriesEntity>>> getMealsCategories();
}
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/explore_data_source/explore_data_source.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/meals_categories_entity/meals_categories_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_random_entity/muscles_random_entity.dart';
import 'package:fitness/features/home/domain/repositories/explore_repositories/explore_repositories.dart';
import 'package:injectable/injectable.dart';

@Injectable(as : ExploreRepositories)
class ExploreRepositoriesImpl implements ExploreRepositories {
  final ExploreDataSource _exploreDataSource;

  ExploreRepositoriesImpl(this._exploreDataSource);
  @override
  Future<Result<List<MealsCategoriesEntity>>> getMealsCategories() {
    return _exploreDataSource.getMealsCategories();
  }

  @override
  Future<Result<List<MusclesGroupEntity>>> getMusclesGroup() {
     return _exploreDataSource.getMusclesGroup();
  }

  @override
  Future<Result<List<MusclesRandomEntity>>> getRandomMuscles() {
      return _exploreDataSource.getRandomMuscles();
  }

}
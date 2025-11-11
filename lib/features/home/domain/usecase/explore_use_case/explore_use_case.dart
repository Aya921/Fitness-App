import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:injectable/injectable.dart';

import '../../repo/explore_repositories/explore_repositories.dart';

@injectable
class ExploreUseCase {
 final ExploreRepositories _exploreRepositories;

  ExploreUseCase(this._exploreRepositories);
  

  
  Future<Result<List<MusclesGroupEntity>>> getMusclesGroup() {
      return _exploreRepositories.getMusclesGroup();
  }

  
  Future<Result<List<MuscleEntity>>> getRandomMuscles() {
       return _exploreRepositories.getRandomMuscles();
  }

       Future<Result<MusclesGroupIdResponseEntity>> getAllMusclesGroupById(String? id) {
       return _exploreRepositories.getAllMusclesGroupById(id);
  }

}
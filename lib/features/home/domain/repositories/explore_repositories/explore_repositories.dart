import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';

abstract class ExploreRepositories {
  
 Future<Result<List<MuscleEntity>>> getRandomMuscles();

 Future<Result<List<MusclesGroupEntity>>> getMusclesGroup();


  Future<Result<MusclesGroupIdResponseEntity>> getAllMusclesGroupById(String? id);
}
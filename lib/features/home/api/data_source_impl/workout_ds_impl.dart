import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/data/data_source/workout_ds.dart';
import 'package:fitness/features/home/domain/entity/workout/difficulty_level_entitiy.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:WorkoutDs )
class WorkoutDsImpl implements WorkoutDs{
  final ApiServices _apiServices;
  const WorkoutDsImpl(this._apiServices);

  @override
  Future<Result<List<ExerciseEntity>>> getAllExercises({int page = 1}) async{
    return safeApiCall(() async {
      final response= await _apiServices.getAllExercises(page: page);
      return response.toEntity().exercises??[];
    },);


  }

  @override
  Future<Result<List<LevelEntity>>> getDifficultyLevels() async{
    return safeApiCall(() async{
      final response=await _apiServices.getDifficultyLevels();
      return response.levels?.map((level) => level.toEntity(),).toList()??[];
    },);
  }

}
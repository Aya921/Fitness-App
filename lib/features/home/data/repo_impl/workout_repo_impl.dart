import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/workout_ds.dart';
import 'package:fitness/features/home/domain/entity/workout/difficulty_level_entitiy.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_entity.dart';
import 'package:fitness/features/home/domain/repo/workout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:WorkoutRepo )
class WorkoutRepoImpl implements WorkoutRepo{
  final WorkoutDs _workoutDs;
  const WorkoutRepoImpl(this._workoutDs);
  @override
  Future<Result<List<ExerciseEntity>>> getAllExercises({int page = 1}) {
    return _workoutDs.getAllExercises(page: page);
  }

  @override
  Future<Result<List<LevelEntity>>> getDifficultyLevels() {
    return _workoutDs.getDifficultyLevels();
  }

}
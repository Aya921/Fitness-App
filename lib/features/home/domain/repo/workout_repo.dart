import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_entity.dart';

import '../entity/workout/difficulty_level_entitiy.dart';

abstract interface class WorkoutRepo {
  Future<Result<List<ExerciseEntity>>> getAllExercises({int page = 1});
  Future<Result<List<LevelEntity>>> getDifficultyLevels();

}
import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entity/workout/difficulty_level_entitiy.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_entity.dart';

abstract interface class WorkoutDs {
  Future<Result<List<ExerciseEntity>>> getAllExercises({int page = 1});
  Future<Result<List<LevelEntity>>> getDifficultyLevels();
}
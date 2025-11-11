import 'package:fitness/core/result/result.dart';
import '../../entities/exercises/difficulty_level_entity.dart';
import '../../entities/exercises/exercise_entity.dart';

abstract interface class ExercisesRepo {
  Future<Result<List<LevelEntity>>> getDifficultyLevelsByPrimeMoverMuscles(
    String primeMoverMuscleId,
  );
  Future<Result<List<ExerciseEntity>>> getExercisesByMuscleAndDifficulty(
    String primeMoverMuscleId,
    String difficultyLevelId,
      {int page = 1}
  );
}

import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/data/data_source/exercises_ds.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:fitness/features/home/domain/repo/exercises_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExercisesRepo)
class ExercisesRepoImpl implements ExercisesRepo {
  final ExercisesDs _exercisesDs;
  const ExercisesRepoImpl(this._exercisesDs);

  @override
  Future<Result<List<LevelEntity>>> getDifficultyLevelsByPrimeMoverMuscles(
    String primeMoverMuscleId,
  ) {
    return _exercisesDs.getDifficultyLevelsByPrimeMoverMuscles(
      primeMoverMuscleId,
    );
  }

  @override
  Future<Result<List<ExerciseEntity>>> getExercisesByMuscleAndDifficulty(
    String primeMoverMuscleId,
    String difficultyLevelId, {
    int page = 1,
  }) {
    return _exercisesDs.getExercisesByMuscleAndDifficulty(
      primeMoverMuscleId,
      difficultyLevelId,
      page: page,
    );
  }
}

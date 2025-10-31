import 'package:fitness/core/result/result.dart';
import 'package:fitness/core/safe_api_call/safe_api_call.dart';
import 'package:fitness/features/home/api/client/api_services.dart';
import 'package:fitness/features/home/data/data_source/exercises_ds.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExercisesDs)
class ExercisestDsImpl implements ExercisesDs {
  final ApiServices _apiServices;
  const ExercisestDsImpl(this._apiServices);

  @override
  Future<Result<List<LevelEntity>>> getDifficultyLevelsByPrimeMoverMuscles(
    String primeMoverMuscleId,
  ) async {
    return safeApiCall(() async {
      final response = await _apiServices
          .getDifficultyLevelsByPrimeMoverMuscles(
            primeMoverMuscleId: primeMoverMuscleId,
          );

      return response.difficultyLevels
              ?.map((level) => level.toEntity())
              .toList() ??
          [];
    });
  }

  @override
  Future<Result<List<ExerciseEntity>>> getExercisesByMuscleAndDifficulty(
    String primeMoverMuscleId,
    String difficultyLevelId, {
    int page = 1,
  }) async {
    return safeApiCall(() async {
      final response = await _apiServices.getExercisesByMuscleAndDifficulty(
        difficultyLevelId: difficultyLevelId,
        primeMoverMuscleId: primeMoverMuscleId,
        page: page,
      );
      return response.exercises
              ?.map((exercise) => (exercise).toEntity())
              .toList() ??
          [];
    });
  }
}

import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/repo/exercises_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDifficultyLevelsByMuscleUseCase {
  final ExercisesRepo _workoutRepo;
  const GetDifficultyLevelsByMuscleUseCase(this._workoutRepo);

  Future<Result<List<LevelEntity>>> call(String primeMoverMuscleId){
    return _workoutRepo.getDifficultyLevelsByPrimeMoverMuscles(primeMoverMuscleId);
  }
}
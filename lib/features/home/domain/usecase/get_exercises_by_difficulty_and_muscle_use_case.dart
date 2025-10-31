import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';
import 'package:fitness/features/home/domain/repo/exercises_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExercisesByDifficultyAndMuscleUseCase {
  final ExercisesRepo _workoutRepo;
  const GetExercisesByDifficultyAndMuscleUseCase(this._workoutRepo);

  Future<Result<List<ExerciseEntity>>> call(String primeMoverMuscleId, String difficultyLevelId,{int page = 1}){
    return _workoutRepo.getExercisesByMuscleAndDifficulty(primeMoverMuscleId, difficultyLevelId,page: page);
  }
}
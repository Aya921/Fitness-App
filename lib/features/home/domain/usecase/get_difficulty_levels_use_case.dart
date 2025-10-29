import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/entity/workout/difficulty_level_entitiy.dart';
import 'package:fitness/features/home/domain/repo/workout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDifficultyLevelsUseCase {

  final WorkoutRepo _workoutRepo;
const GetDifficultyLevelsUseCase(this._workoutRepo);

  Future<Result<List<LevelEntity>>> call(){
    return _workoutRepo.getDifficultyLevels();
  }

}
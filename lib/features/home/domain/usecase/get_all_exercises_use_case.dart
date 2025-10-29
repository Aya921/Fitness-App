import 'package:fitness/core/result/result.dart';
import 'package:fitness/features/home/domain/repo/workout_repo.dart';
import 'package:injectable/injectable.dart';

import '../entity/workout/exercise_entity.dart';

@injectable
class GetAllExercisesUseCase {
 final WorkoutRepo _workoutRepo;
 GetAllExercisesUseCase(this._workoutRepo);

 Future<Result<List<ExerciseEntity>>> call({int page = 1}){
   return _workoutRepo.getAllExercises(page: page);
 }
}
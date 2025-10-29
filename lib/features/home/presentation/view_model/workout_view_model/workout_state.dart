
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/home/domain/entity/workout/exercise_entity.dart';

import '../../../domain/entity/workout/difficulty_level_entitiy.dart';

class WorkoutStates {
  StateStatus<List<LevelEntity>> levelsStatus;
  StateStatus<List<ExerciseEntity>> exercisesStatus;
  List<ExerciseEntity> filteredExercises;
  final List<ExerciseEntity> allExercises;
  final String? selectedLevel;
  final Map<String, int>? exercisesCountByLevel;


  WorkoutStates({
   this.exercisesStatus=const StateStatus.loading(),
    this.levelsStatus=const StateStatus.loading(),
    this.filteredExercises=const [],
    this.allExercises=const[],
    this.selectedLevel="",
    this.exercisesCountByLevel=const{}
  });


  WorkoutStates copyWith({
    StateStatus<List<LevelEntity>>? levelsStatus,
    StateStatus<List<ExerciseEntity>>? exercisesStatus,
    List<ExerciseEntity>? filteredExercises,
    final List<ExerciseEntity>? allExercises,
    final String? selectedLevel,
    final Map<String, int>? exercisesCountByLevel

  }) {
    return WorkoutStates(
      levelsStatus: levelsStatus??this.levelsStatus,
      exercisesStatus: exercisesStatus??this.exercisesStatus,
      filteredExercises: filteredExercises??this.filteredExercises,
        allExercises: allExercises??this.allExercises,
      selectedLevel: selectedLevel??this.selectedLevel,
      exercisesCountByLevel: exercisesCountByLevel??this.exercisesCountByLevel
    );
  }
}

import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';

class ExercisesStates {
  final StateStatus<List<LevelEntity>> levelsByMuscleStatus;
  final StateStatus<List<ExerciseEntity>> exercisesByLevelAndMuscleStatus;
  final String? selectedLevelId;
  final StateStatus<String> youtubeIdStatus;

  const ExercisesStates({
    this.levelsByMuscleStatus = const StateStatus.loading(),
    this.exercisesByLevelAndMuscleStatus = const StateStatus.loading(),
    this.selectedLevelId = "",
    this.youtubeIdStatus = const StateStatus.initial(),
  });

  ExercisesStates copyWith({
    StateStatus<List<LevelEntity>>? levelsByMuscleStatus,
    StateStatus<List<ExerciseEntity>>? exercisesByLevelAndMuscleStatus,
    String? selectedLevelId,
    final StateStatus<String>? youtubeIdStatus,
  }) {
    return ExercisesStates(
      levelsByMuscleStatus: levelsByMuscleStatus ?? this.levelsByMuscleStatus,
      exercisesByLevelAndMuscleStatus:
          exercisesByLevelAndMuscleStatus ??
          this.exercisesByLevelAndMuscleStatus,
      selectedLevelId: selectedLevelId ?? this.selectedLevelId,
      youtubeIdStatus: youtubeIdStatus ?? this.youtubeIdStatus,
    );
  }
}

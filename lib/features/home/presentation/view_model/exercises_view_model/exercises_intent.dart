sealed class ExercisesIntent {}

final class LoadLevelsByMuscleIntent extends ExercisesIntent {
  final String muscleId;
  LoadLevelsByMuscleIntent({required this.muscleId});
}

final class LoadExercisesByMuscleAndLevelIntent extends ExercisesIntent {
  final String muscleId;
  final String levelId;
  LoadExercisesByMuscleAndLevelIntent({
    required this.muscleId,
    required this.levelId,
  });
}

final class ChangeSelectedLevelIntent extends ExercisesIntent {
  final String muscleId;
  final String levelId;
  ChangeSelectedLevelIntent({required this.muscleId, required this.levelId});
}

final class LoadMoreExercisesByMuscleAndLevelIntent extends ExercisesIntent {
  final String muscleId;
  final String levelId;

  LoadMoreExercisesByMuscleAndLevelIntent({
    required this.muscleId,
    required this.levelId,
  });
}

final class GetYoutubeIdIntent extends ExercisesIntent {
  final String videoUrl;
  GetYoutubeIdIntent({required this.videoUrl});
}

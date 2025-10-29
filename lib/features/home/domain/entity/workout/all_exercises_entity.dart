import 'package:fitness/features/home/domain/entity/workout/exercise_entity.dart';

class AllExercisesEntity {
  String? message;
  final int? totalExercises;
  final int? totalPages;
  final int? currentPage;
  final List<ExerciseEntity>? exercises;

  AllExercisesEntity({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });
}

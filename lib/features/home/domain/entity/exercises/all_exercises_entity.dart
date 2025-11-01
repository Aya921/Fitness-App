import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entity/exercises/exercise_entity.dart';

class AllExercisesEntity extends Equatable {
  final String? message;
  final int? totalExercises;
  final int? totalPages;
  final int? currentPage;
  final List<ExerciseEntity>? exercises;

  const AllExercisesEntity({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  @override
  List<Object?> get props => [
    message,
    totalPages,
    totalExercises,
    currentPage,
    exercises,
  ];
}

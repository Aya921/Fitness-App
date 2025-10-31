import 'package:fitness/features/home/api/models/exercises/exercise_response.dart';
import 'package:fitness/features/home/domain/entity/exercises/all_exercises_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_exercises_response.g.dart';

@JsonSerializable()
class AllExercisesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalExercises")
  final int? totalExercises;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "exercises")
  final List<ExerciseResponse>? exercises;

  AllExercisesResponse({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory AllExercisesResponse.fromJson(Map<String, dynamic> json) {
    return _$AllExercisesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllExercisesResponseToJson(this);
  }

  AllExercisesEntity toEntity() {
    return AllExercisesEntity(
      message: message,
      currentPage: currentPage,
      totalExercises: totalExercises,
      totalPages: totalPages,
      exercises: exercises
          ?.map((exerciseResponse) => exerciseResponse.toEntity())
          .toList(),
    );
  }
}

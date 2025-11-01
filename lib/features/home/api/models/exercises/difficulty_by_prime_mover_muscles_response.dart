import 'package:fitness/features/home/api/models/exercises/level_response.dart';
import 'package:fitness/features/home/domain/entity/exercises/difficulty_by_prime_mover_muscles_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'difficulty_by_prime_mover_muscles_response.g.dart';

@JsonSerializable()
class DifficultyByPrimeMoverMusclesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalLevels")
  final int? totalLevels;
  @JsonKey(name: "difficulty_levels")
  final List<LevelResponse>? difficultyLevels;

  DifficultyByPrimeMoverMusclesResponse({
    this.message,
    this.totalLevels,
    this.difficultyLevels,
  });

  factory DifficultyByPrimeMoverMusclesResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$DifficultyByPrimeMoverMusclesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DifficultyByPrimeMoverMusclesResponseToJson(this);
  }

  DifficultyByPrimeMoverMusclesEntity toEntity() {
    return DifficultyByPrimeMoverMusclesEntity(
      message: message,
      totalLevels: totalLevels,
      difficultyLevels: difficultyLevels
          ?.map((level) => level.toEntity())
          .toList(),
    );
  }
}

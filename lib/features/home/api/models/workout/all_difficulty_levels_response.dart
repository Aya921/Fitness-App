import 'package:fitness/features/home/api/models/workout/level_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_difficulty_levels_response.g.dart';

@JsonSerializable()
class AllDifficultyLevelsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "levels")
  final List<LevelResponse>? levels;

  AllDifficultyLevelsResponse ({
    this.message,
    this.levels,
  });

  factory AllDifficultyLevelsResponse.fromJson(Map<String, dynamic> json) {
    return _$AllDifficultyLevelsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllDifficultyLevelsResponseToJson(this);
  }
}


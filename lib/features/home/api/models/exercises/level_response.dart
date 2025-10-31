import 'package:fitness/features/home/domain/entity/exercises/difficulty_level_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'level_response.g.dart';

@JsonSerializable()
class LevelResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  LevelResponse ({
    this.id,
    this.name,
  });

  factory LevelResponse.fromJson(Map<String, dynamic> json) {
    return _$LevelResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LevelResponseToJson(this);
  }

  LevelEntity toEntity(){
    return LevelEntity(
      id: id,
      name: name
    );
  }
}


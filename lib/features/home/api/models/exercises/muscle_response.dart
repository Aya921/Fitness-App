import 'package:fitness/features/home/domain/entity/exercises/mover_muscle_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_response.g.dart';

@JsonSerializable()
class MuscleResponse {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;

  MuscleResponse ({
    this.id,
    this.name,
    this.image,
  });

  factory MuscleResponse.fromJson(Map<String, dynamic> json) {
    return _$MuscleResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleResponseToJson(this);
  }

  MoverMuscleEntity toEntity() {
    return MoverMuscleEntity(
      id: id ?? '',
      name: name ?? '',
      image: image ?? '',
    );
  }
}



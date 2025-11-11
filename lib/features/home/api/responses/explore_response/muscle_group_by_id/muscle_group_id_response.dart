import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/api/models/explore_models/muscle_group_model/muscle_group_model.dart';
import 'package:fitness/features/home/api/models/explore_models/muscle_model/muscle_model.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_by_id_response_entity/muscles_group_id_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_group_id_response.g.dart';

@JsonSerializable()
class MuscleGroupIdResponse extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  
  @JsonKey(name: "muscleGroup")
  final MuscleGroupModel? musclesGroup;
  
  @JsonKey(name: "muscles")
  final List<MuscleModel>? muscles;

  const MuscleGroupIdResponse({
    this.message,
    this.musclesGroup,
    this.muscles,
  });

  factory MuscleGroupIdResponse.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupIdResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupIdResponseToJson(this);
  }

  @override
  List<Object?> get props => [message, musclesGroup, muscles];

   MusclesGroupIdResponseEntity toEntity() {
    return MusclesGroupIdResponseEntity(
      message: message,
      musclesGroup: musclesGroup?.toEntity(),
      muscles: muscles?.map((muscle) => muscle.toEntity()).toList(),
    );
  }
}
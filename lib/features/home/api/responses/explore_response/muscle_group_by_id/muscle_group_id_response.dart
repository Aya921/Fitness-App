import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/api/models/explore_models/muscle_group_id/muscle_group_model.dart';
import 'package:fitness/features/home/api/models/explore_models/muscle_group_id/muscle_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_group_id_response.g.dart';

@JsonSerializable()
class MuscleGroupIdResponse extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  
  @JsonKey(name: "muscleGroup")
  final MuscleGroupModel? muscleGroup;
  
  @JsonKey(name: "muscles")
  final List<MuscleModel>? muscles;

  const MuscleGroupIdResponse({
    this.message,
    this.muscleGroup,
    this.muscles,
  });

  factory MuscleGroupIdResponse.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupIdResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupIdResponseToJson(this);
  }

  @override
  List<Object?> get props => [message, muscleGroup, muscles];
}
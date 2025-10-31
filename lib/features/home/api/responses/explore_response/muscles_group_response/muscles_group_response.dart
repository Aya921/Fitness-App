import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/api/models/explore_models/muscles_group_model/muscles_group_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscles_group_response.g.dart';

@JsonSerializable()
class MusclesGroupResponse extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  
  @JsonKey(name: "musclesGroup")
  final List<MusclesGroupModel>? musclesGroup;

  const MusclesGroupResponse({
    this.message,
    this.musclesGroup,
  });

  factory MusclesGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$MusclesGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesGroupResponseToJson(this);
  }

  @override
  List<Object?> get props => [message, musclesGroup];
}
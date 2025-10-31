import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_group_model.g.dart';

@JsonSerializable()
class MuscleGroupModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  
  @JsonKey(name: "name")
  final String? name;

  const MuscleGroupModel({
    this.id,
    this.name,
  });

  factory MuscleGroupModel.fromJson(Map<String, dynamic> json) {
    return _$MuscleGroupModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleGroupModelToJson(this);
  }

  // MuscleGroupEntity toEntity() {
  //   return MuscleGroupEntity(
  //     id: id,
  //     name: name,
  //   );
  // }

  @override
  List<Object?> get props => [id, name];
}
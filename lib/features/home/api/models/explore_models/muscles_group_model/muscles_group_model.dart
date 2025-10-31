import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_group_entity/muscles_group_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscles_group_model.g.dart';

@JsonSerializable()
class MusclesGroupModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  
  @JsonKey(name: "name")
  final String? name;

  const MusclesGroupModel({
    this.id,
    this.name,
  });

  factory MusclesGroupModel.fromJson(Map<String, dynamic> json) {
    return _$MusclesGroupModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesGroupModelToJson(this);
  }

  @override
  List<Object?> get props => [id, name];

   MusclesGroupEntity toEntity() {
    return MusclesGroupEntity(
      id: id,
      name: name,
    );
  }
}
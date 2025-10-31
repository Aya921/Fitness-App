import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscles_random_entity/muscles_random_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscles_random_model.g.dart';

@JsonSerializable()
class MusclesRandomModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  
  @JsonKey(name: "name")
  final String? name;
  
  @JsonKey(name: "image")
  final String? image;

  const MusclesRandomModel({
    this.id,
    this.name,
    this.image,
  });

  factory MusclesRandomModel.fromJson(Map<String, dynamic> json) {
    return _$MusclesRandomModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesRandomModelToJson(this);
  }

  @override
  List<Object?> get props => [id, name, image];

   MusclesRandomEntity toEntity() {
    return MusclesRandomEntity(
      id: id,
      name: name,
      image: image,
    );
  }
}
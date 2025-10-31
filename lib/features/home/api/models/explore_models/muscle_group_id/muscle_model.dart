import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscle_model.g.dart';

@JsonSerializable()
class MuscleModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  
  @JsonKey(name: "name")
  final String? name;
  
  @JsonKey(name: "image")
  final String? image;

  const MuscleModel({
    this.id,
    this.name,
    this.image,
  });

  factory MuscleModel.fromJson(Map<String, dynamic> json) {
    return _$MuscleModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MuscleModelToJson(this);
  }

  // MuscleEntity toEntity() {
  //   return MuscleEntity(
  //     id: id,
  //     name: name,
  //     image: image,
  //   );
  // }

  @override
  List<Object?> get props => [id, name, image];
}
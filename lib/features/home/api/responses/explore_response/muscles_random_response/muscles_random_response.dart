import 'package:equatable/equatable.dart';
import 'package:fitness/features/home/api/models/explore_models/muscles_random_model/muscles_random_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscles_random_response.g.dart';

@JsonSerializable()
class MusclesRandomResponse extends Equatable {
  @JsonKey(name: "message")
  final String? message;
  
  @JsonKey(name: "totalMuscles")
  final int? totalMuscles;
  
  @JsonKey(name: "muscles")
  final List<MusclesRandomModel>? muscles;

  const MusclesRandomResponse({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  factory MusclesRandomResponse.fromJson(Map<String, dynamic> json) {
    return _$MusclesRandomResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesRandomResponseToJson(this);
  }

  @override
  List<Object?> get props => [message, totalMuscles, muscles];
}
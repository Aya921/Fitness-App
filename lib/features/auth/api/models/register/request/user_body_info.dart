import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/constants/json_serializable_constants.dart';

part 'user_body_info.g.dart';

@JsonSerializable()
class UserBodyInfo {
  @JsonKey(name: JsonSerializableConstants.height)
  final int? height;
  @JsonKey(name: JsonSerializableConstants.weight)
  final int? weight;
  @JsonKey(name: JsonSerializableConstants.age)
  final int? age;
  @JsonKey(name: JsonSerializableConstants.goal)
  final String? goal;
  @JsonKey(name: JsonSerializableConstants.activityLevel)
  final String? activityLevel;

  UserBodyInfo ({
    this.height,
    this.weight,
    this.age,
    this.goal,
    this.activityLevel,
  });

  factory UserBodyInfo.fromJson(Map<String, dynamic> json) {
    return _$UserBodyInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserBodyInfoToJson(this);
  }
}



import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:fitness/features/auth/api/models/auth_response/body_info.dart';
import 'package:fitness/features/auth/api/models/auth_response/personal_info.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserResponse {
  final PersonalInfo? personalInfo;
  final BodyInfo? bodyInfo;

  @JsonKey(name: JsonSerializableConstants.activityLevel)
  final String? activityLevel;

  @JsonKey(name: JsonSerializableConstants.goal)
  final String? goal;

  @JsonKey(name: JsonSerializableConstants.createdAt)
  final String? createdAt;

  UserResponse({
    this.personalInfo,
    this.bodyInfo,
    this.activityLevel,
    this.goal,
    this.createdAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      personalInfo: personalInfo?.toEntity(),
      bodyInfo: bodyInfo?.toEntity(),
      activityLevel: activityLevel,
      goal: goal,
    );
  }
}

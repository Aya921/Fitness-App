import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: JsonSerializableConstants.id)
  final String? id;
  @JsonKey(name: JsonSerializableConstants.firstName)
  final String? firstName;
  @JsonKey(name: JsonSerializableConstants.lastName)
  final String? lastName;
  @JsonKey(name: JsonSerializableConstants.email)
  final String? email;
  @JsonKey(name: JsonSerializableConstants.gender)
  final String? gender;
  @JsonKey(name: JsonSerializableConstants.age)
  final int? age;
  @JsonKey(name: JsonSerializableConstants.weight)
  final int? weight;
  @JsonKey(name: JsonSerializableConstants.height)
  final int? height;
  @JsonKey(name: JsonSerializableConstants.activityLevel)
  final String? activityLevel;
  @JsonKey(name: JsonSerializableConstants.goal)
  final String? goal;
  @JsonKey(name: JsonSerializableConstants.photo)
  final String? photo;
  @JsonKey(name: JsonSerializableConstants.createdAt)
  final String? createdAt;

  UserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
    this.createdAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return _$UserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserResponseToJson(this);
  }

  UserEntity toEntity() {
    return UserEntity(
      personalInfo: PersonalInfoEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        age: age,
        photo: photo,
      ),
      bodyInfo: BodyInfoEntity(weight: weight, height: height),
      goal: goal,
      activityLevel: activityLevel,
      createdAt: createdAt,
    );
  }
}

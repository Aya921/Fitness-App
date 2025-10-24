import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'personal_info.g.dart';

@JsonSerializable()
class PersonalInfo {
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

  @JsonKey(name: JsonSerializableConstants.photo)
  final String? photo;

  const PersonalInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.photo,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoToJson(this);

  PersonalInfoEntity toEntity(){
    return PersonalInfoEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      age: age,
      photo: photo
    );
  }
}
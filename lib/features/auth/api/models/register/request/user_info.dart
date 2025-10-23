import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/constants/json_serializable_constants.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  @JsonKey(name: JsonSerializableConstants.firstName)
  final String? firstName;
  @JsonKey(name: JsonSerializableConstants.lastName)
  final String? lastName;
  @JsonKey(name: JsonSerializableConstants.email)
  final String? email;
  @JsonKey(name: JsonSerializableConstants.password)
  final String? password;
  @JsonKey(name: JsonSerializableConstants.rePassword)
  final String? rePassword;
  @JsonKey(name: JsonSerializableConstants.gender)
  final String? gender;

  UserInfo ({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return _$UserInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserInfoToJson(this);
  }
}
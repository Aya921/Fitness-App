import 'package:fitness/features/auth/api/models/register/request/user_body_info.dart';
import 'package:fitness/features/auth/api/models/register/request/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/constants/json_serializable_constants.dart';




// @JsonSerializable(explicitToJson: true)
// class RegisterRequest {
// final UserInfo? userInfo;
//
//   final UserBodyInfo? userBodyInfo;
//
//   RegisterRequest ({
//     this.userInfo,
//     this.userBodyInfo
//   });
//
//   factory RegisterRequest.fromJson(Map<String, dynamic> json) {
//     return _$RegisterRequestFromJson(json);
//   }
//
//   Map<String, dynamic> toJson() {
//     return _$RegisterRequestToJson(this);
//   }
// }



part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final UserInfo? userInfo;
  final UserBodyInfo? userBodyInfo;

  RegisterRequest({
    this.userInfo,
    this.userBodyInfo,
  });

  // DO NOT LET json_serializable generate toJson()
  // We override it to FLATTEN the data
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (userInfo != null) {
      map.addAll({
        JsonSerializableConstants.firstName: userInfo!.firstName,
        JsonSerializableConstants.lastName: userInfo!.lastName,
        JsonSerializableConstants.email: userInfo!.email,
        JsonSerializableConstants.password: userInfo!.password,
        JsonSerializableConstants.rePassword: userInfo!.rePassword,
        JsonSerializableConstants.gender: userInfo!.gender,
      });
    }

    if (userBodyInfo != null) {
      map.addAll({
        JsonSerializableConstants.height: userBodyInfo!.height,
        JsonSerializableConstants.weight: userBodyInfo!.weight,
        JsonSerializableConstants.age: userBodyInfo!.age,
        JsonSerializableConstants.goal: userBodyInfo!.goal,
        JsonSerializableConstants.activityLevel: userBodyInfo!.activityLevel,
      });
    }

    return map;
  }

  // Keep fromJson for completeness (optional)
  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

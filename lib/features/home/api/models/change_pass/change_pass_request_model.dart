import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/chage_pass/change_pass_request.dart';
part 'change_pass_request_model.g.dart';

@JsonSerializable()
class ChangePassRequestModel {
  @JsonKey(name: JsonSerializableConstants.password)
  final String? password;
  @JsonKey(name: JsonSerializableConstants.newPassword)
  final String? newPassword;
  ChangePassRequestModel({this.password, this.newPassword});

  factory ChangePassRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePassRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePassRequestModelToJson(this);


   factory ChangePassRequestModel.toModel(ChangePassRequest entity) {
    return ChangePassRequestModel(password: entity.password, newPassword: entity.newPassword);
  }
}

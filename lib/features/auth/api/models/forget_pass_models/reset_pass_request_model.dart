import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/reset_pass_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_pass_request_model.g.dart';

@JsonSerializable()
class ResetPassRequestModel {
  @JsonKey(name: JsonSerializableConstants.email)
  String? email;
  @JsonKey(name: JsonSerializableConstants.newPassword)
  String? newPassword;

  ResetPassRequestModel({this.email,this.newPassword});

  factory ResetPassRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPassRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPassRequestModelToJson(this);

  factory ResetPassRequestModel.toModel(ResetPassRequest entity) {
    return ResetPassRequestModel(email:entity.email,newPassword: entity.newPass );
  }
}

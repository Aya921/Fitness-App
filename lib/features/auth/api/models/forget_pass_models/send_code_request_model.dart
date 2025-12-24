import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/send_code_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_code_request_model.g.dart';

@JsonSerializable()
class SendCodeRequestModel {
  @JsonKey(name: JsonSerializableConstants.resetCode)
  String? resetCode;

  SendCodeRequestModel({this.resetCode});

  factory SendCodeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SendCodeRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendCodeRequestModelToJson(this);

  factory SendCodeRequestModel.toModel(SendCodeRequest entity) {
    return SendCodeRequestModel(resetCode:entity.otpCode );
  }
}

import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_pass_response_model.g.dart';

@JsonSerializable()
class ForgetPassResponseModel {
  @JsonKey(name: JsonSerializableConstants.message)
  String? message;
  @JsonKey(name: JsonSerializableConstants.info)
  String? info;

  ForgetPassResponseModel({this.message, this.info});

  factory ForgetPassResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPassResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPassResponseModelToJson(this);

  ForgetPassResponse toEntity() {
    return ForgetPassResponse(info: info!);
  }
}

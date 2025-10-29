import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:fitness/features/auth/domain/entity/auth/forgetPassEntity/forget_pass_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_pass_request_model.g.dart';

@JsonSerializable()
class ForgetPassRequestModel {
  @JsonKey(name: JsonSerializableConstants.email)
  String? email;

  ForgetPassRequestModel({this.email});

  factory ForgetPassRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPassRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPassRequestModelToJson(this);

  factory ForgetPassRequestModel.toModel(ForgetPassRequest entity) {
    return ForgetPassRequestModel(email:entity.email );
  }
}

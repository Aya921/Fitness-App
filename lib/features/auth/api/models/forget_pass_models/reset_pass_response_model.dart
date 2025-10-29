import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_pass_response_model.g.dart';

@JsonSerializable()
class ResetPassResponseModel {
  @JsonKey(name: JsonSerializableConstants.message)
  String? email;
  @JsonKey(name:JsonSerializableConstants.token)
  String? token;

  ResetPassResponseModel({this.email,this.token});

  factory ResetPassResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPassResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPassResponseModelToJson(this);

 
}

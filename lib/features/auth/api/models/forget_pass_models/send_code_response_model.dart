import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_code_response_model.g.dart';

@JsonSerializable()
class SendCodeResponseModel {
  @JsonKey(name: JsonSerializableConstants.status)
  String? status;

  SendCodeResponseModel({this.status});

  factory SendCodeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendCodeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendCodeResponseModelToJson(this);

 
}
